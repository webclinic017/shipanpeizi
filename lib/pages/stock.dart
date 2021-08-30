import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/trade/trade.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Util.dart';
import 'package:flutterapp2/utils/request.dart';
import 'package:flutter/services.dart';
import '../chart/entity/k_line_entity.dart';
import '../chart/k_chart_widget.dart';
import '../chart/utils/data_util.dart';

class stock extends StatefulWidget{
  String stock_id;

  stock(this.stock_id);
  @override
  _stock createState() => _stock();

}
class _stock extends State<stock>{

  bool is_check = false;
  List<KLineEntity> datas;
  bool isLine = true;
  MainState _mainState = MainState.MA;  //MA
  bool showLoading = true;
  SecondaryState _secondaryState = SecondaryState.MACD;  //MACD
  @override
  List k_cate;
  TextStyle check_style;
  TextStyle default_style;
  int cur_index;
  int dang_index;
  String default_name = "--";
  String defalut_price = "0.00";
  String defalut_diff_money = "0.00";
  String defalut_diff_rate = "0.00";
  String defalut_status = "未开盘";
  String defalut_date = "--";
  String default_stock_flag = "--";
  Color default_color = Colors.black;
  String sell1_n = "0";
  String sell1_m = "0";
  String sell2_n = "0";
  String sell2_m = "0";
  String sell3_n = "0";
  String sell3_m = "0";
  String sell4_n = "0";
  String sell4_m = "0";
  String sell5_n = "0";
  String sell5_m = "0";
  String buy1_n = "0";
  String buy1_m = "0";
  String buy2_n = "0";
  String buy2_m = "0";
  String buy3_n = "0";
  String buy3_m = "0";
  String buy4_n = "0";
  String buy4_m = "0";
  String buy5_n = "0";
  String buy5_m = "0";
  String default_yes_close = "0";
  String default_most_high = "0";
  String default_today_open = "0";
  String default_most_low = "0";
  String default_cjl = "0";
  String default_cje = "0";
  String default_zf = "0";
  String default_zt = "0";
  String default_dt = "0";
  String default_syl = "0";
  String default_sjl = "0";
  String default_hsl = "0";
  List trade_detail_list = ["五档", "明细"];
  List stock_detail ;
  List wudang = [];
  List detail = [];
  String defaul_flag = "1";
  PageController controller;
  Timer timer_;
  void initState(){
    super.initState();
    cur_index =0;
    dang_index = 0;
    check_style = TextStyle(color: Colors.black);
     default_style = TextStyle(color: Colors.black54);
    k_cate = [{"text":"分时","style":check_style,"time":"1"},{"text":"5分","style":default_style,"time":"5"},{"text":"30分","style":default_style,"time":"30"},{"text":"日k","style":default_style,"time":"day"},{"text":"周K","style":default_style,"time":"week"},{"text":"月k","style":default_style,"time":"month"}];
    stock_detail = [
      {"text":"今开","value":default_today_open},
      {"text":"昨收","value":default_yes_close},
      {"text":"最高","value":default_most_high},
      {"text":"最低","value":default_most_low},
      {"text":"成交量","value":default_cjl},
      {"text":"成交额","value":default_cje},
      {"text":"振幅","value":default_zf},
      {"text":"涨停","value":default_zt},
      {"text":"跌停","value":default_dt},
      {"text":"市盈率","value":default_syl},
      {"text":"市净率","value":default_sjl},
      {"text":"换手率","value":default_hsl},
      ];
    controller = new PageController(initialPage: this.dang_index);
    wudang = [
      {"text": "卖5", "price": "0", "number": "0"},
      {"text": "卖4", "price": "0", "number": "0"},
      {"text": "卖3", "price": "0", "number": "0"},
      {"text": "卖2", "price": "0", "number": "0"},
      {"text": "卖1", "price": "0", "number": "0"},
      {},
      {"text": "买1", "price": "0", "number": "0"},
      {"text": "买2", "price": "0", "number": "0"},
      {"text": "买3", "price": "0", "number": "0"},
      {"text": "买4", "price": "0", "number": "0"},
      {"text": "买5", "price": "0", "number": "0"},
    ];
    getData(defaul_flag,0);
    getTradeData();
    getIsOptional();
    bool is_trade = Util().checkStockTradeTime();
    if(is_trade){
      timer_ = Timer.periodic(Duration(seconds: 5), (t){
        try{
          getTradeData();
          getNowPrice();
        }catch(Exception){
        }
      });
    }
  }
  //default_stock_flag
  getNowPrice()async{
    ResultData result = await HttpManager.getInstance().get("stock/getTimeSharingData/"+widget.stock_id,withLoading: false);

    Map d =   json.decode(result.data["data1"]);
    Map map1 = d["showapi_res_body"]["list"][0];
    setState(() {
    KLineEntity s = datas[datas.length-1];
    defalut_diff_money = map1["diff_money"];
    defalut_diff_rate = map1["diff_rate"]+"%";
    defalut_price = map1["nowPrice"].toString();
    s.close = double.parse(map1["nowPrice"]);
   });
  }
  getIsOptional() async {
   ResultData res =  await HttpManager.getInstance().get("stock/get_is_optional",params: {"stock_code":widget.stock_id},withLoading: false);

   if(res.data != null){
     if(res.data>0){
       setState(() {
         is_check = true;
       });
     }
   }

  }
  @override
  void dispose() {
    if(timer_ != null){
      timer_.cancel();
    }
    super.dispose();
  }
  guTransToShou(String gu) {
    int a = int.parse(gu);
    num b = (a / 100).round();
    return b.toString();
  }
  Future getTradeData() async {

    try {

      ResultData dd = await HttpManager.getInstance().get("stock/getTradeData/"+widget.stock_id,withLoading: false);
      Map s1 =  json.decode(dd.data["data"]);
      Map s2 = json.decode(dd.data["data1"]);
      List list = s1["showapi_res_body"]["list"];
      Map map1 = list[0];
      List list1 = s2["showapi_res_body"]["list"];
      setState(() {
        if(list1 != null){
          detail = list1;
        }

        default_stock_flag = map1["market"];
        default_name = map1["name"];

        defalut_date = map1["date"] + " " + map1["time"];


        wudang[0]["price"] = map1["sell5_m"];
        wudang[0]["number"] = guTransToShou(map1["sell5_n"]);
        wudang[1]["price"] = map1["sell4_m"];
        wudang[1]["number"] = guTransToShou(map1["sell4_n"]);
        wudang[2]["price"] = map1["sell3_m"];
        wudang[2]["number"] = guTransToShou(map1["sell3_n"]);
        wudang[3]["price"] = map1["sell2_m"];
        wudang[3]["number"] = guTransToShou(map1["sell2_n"]);
        wudang[4]["price"] = map1["sell1_m"];
        wudang[4]["number"] = guTransToShou(map1["sell1_n"]);
        wudang[6]["price"] = map1["buy1_m"];
        wudang[6]["number"] = guTransToShou(map1["buy1_n"]);
        wudang[7]["price"] = map1["buy2_m"];
        wudang[7]["number"] = guTransToShou(map1["buy2_n"]);
        wudang[8]["price"] = map1["buy3_m"];
        wudang[8]["number"] = guTransToShou(map1["buy3_n"]);
        wudang[9]["price"] = map1["buy4_m"];
        wudang[9]["number"] = guTransToShou(map1["buy4_n"]);
        wudang[10]["price"] = map1["buy5_m"];
        wudang[10]["number"] = guTransToShou(map1["buy5_n"]);
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            tooltip: "Alarm",
            onPressed: () {
              setState(() {
                showLoading = true;
              });
              getData("1", 0);
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          size: 12.0,
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(color: Colors.red),
                  padding: EdgeInsets.only(top: 1,bottom: 1,left: 3,right: 3),
                  child: Text(default_stock_flag,style: TextStyle(color: Colors.white,fontSize: 12),),
                ),
                Text(default_name,style: TextStyle(color: Colors.black,fontSize: 14),),
              ],
            ),
            Row(

              crossAxisAlignment: CrossAxisAlignment.values[1],
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(defalut_status,style: TextStyle(color: Color(0xFF686e7a),fontSize: 11),),
                Text("  "+defalut_date,style: TextStyle(color: Color(0xFF686e7a),fontSize: 11),)
              ],
            )
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
               Container(
                 decoration: BoxDecoration(  color: Colors.white,border: Border(bottom: BorderSide(color: Color(0xffF5F5F5),width: 4))),
                 padding: EdgeInsets.only(top: 15,bottom: 5,left: 10,right: 10),

                 child:
                     Row(
                       mainAxisAlignment:MainAxisAlignment.center,
                       children: <Widget>[
                         Text(defalut_price,style: TextStyle(color: default_color,fontSize: 22,fontWeight: FontWeight.bold),),
                         Container(
                           margin: EdgeInsets.only(left: 8),
                           child: Wrap(
                             direction:Axis.vertical,
                             spacing:5,
                             children: <Widget>[
                               Text(defalut_diff_money,style: TextStyle(color: default_color),),
                               Text(defalut_diff_rate,style: TextStyle(color: default_color),)
                             ],
                           ),
                         )
                       ],
                     ),



               ),
                Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color:  Color(0xffeeee),width: 1.5))),
                  child:   Container(
                    padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                    color: Colors.white,
                    child: Container(
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: getKCate(),
                      ),
                    ),
                  ),
                ),

                Stack(
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        Container(

                          height: 350,
                          width: isLine==false?double.infinity:ScreenUtil().setWidth(275),
                          child: KChartWidget(
                            datas,
                            isLine: isLine,
                            mainState: _mainState,
                            secondaryState: _secondaryState,
                            volState: VolState.VOL,
                            fractionDigits: 4,
                          ),
                        ),
                        isLine==true?Container(
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Colors.black26, width: 0.1),
                                bottom:
                                BorderSide(color: Colors.black26, width: 0.1),
                                left: BorderSide(color: Colors.black26, width: 0.1),
                                right:
                                BorderSide(color: Colors.black26, width: 0.1)),
                          ),
                          width: ScreenUtil().setWidth(135),
                          margin: EdgeInsets.only(left: 5),
                          height: 280,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: trade_detail_list.asMap().keys.map((e) {
                                    FontWeight fw = FontWeight.normal;
                                    if (dang_index == e) {
                                      fw = FontWeight.bold;
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dang_index = e;
                                          controller.jumpToPage(e);
                                        });
                                      },
                                      child: Text(
                                        trade_detail_list[e],
                                        style: TextStyle(fontWeight: fw),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Expanded(
                                child: PageView(
                                  onPageChanged: onPageChanged,
                                  controller: controller,
                                  children: <Widget>[
                                    ListView(
                                      children: <Widget>[
                                        Wrap(
                                          spacing: 9,
                                          runAlignment: WrapAlignment.center,
                                          alignment: WrapAlignment.center,
                                          direction: Axis.vertical,
                                          children: wudang.asMap().keys.map((e) {
                                            if (e == 5) {
                                              return Container(
                                                margin: EdgeInsets.only(left: 6),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.28,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                            color:
                                                            Color(0xffb3b3b3),
                                                            width: 0.5))),
                                              );
                                            }
                                            return Material(
                                              color: Colors.white,
                                              child: Ink(
                                                child: InkWell(
                                                  splashColor: Colors.black26,
                                                  onTap: () {

                                                  },
                                                  child: Container(
                                                    width: ScreenUtil().setWidth(135),
                                                    padding: EdgeInsets.only(
                                                        left: 3, right: 3),
                                             
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,

                                                      children: <Widget>[
                                                        Container(


                                                          child: Row(

                                                            children: <Widget>[
                                                              Text(
                                                                wudang[e]["text"],
                                                                style: TextStyle(
                                                                    fontSize: 12),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(left:10),
                                                                child: Text(
                                                                  wudang[e]["price"],
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      color:
                                                                      default_color),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          getNum(int.parse(wudang[e]["number"])),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        Wrap(
                                          runAlignment: WrapAlignment.center,
                                          alignment: WrapAlignment.center,
                                          direction: Axis.vertical,
                                          children: detail.asMap().keys.map((e) {
                                            Color cur_color = Colors.black;
                                            if (detail[e]['type'] == 'B') {
                                              cur_color = Colors.red;
                                            } else {
                                              cur_color = Colors.green;
                                            }
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  left: 3, right: 3),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.32,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.19,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          detail[e]["time"]
                                                              .toString()
                                                              .substring(0, 5),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        Text(detail[e]["price"],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                default_color)),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    detail[e]["tradeNum"],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: cur_color),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ):Container()
                      ],
                    ),
                    if (showLoading)
                      Container(
                          width: double.infinity, height: 450, alignment: Alignment.center, child: CircularProgressIndicator()
                      ),
                  ],
                ),
                //股票详细信息
             Container(
               color: Colors.white,
               padding: EdgeInsets.all(10),
               child:Wrap(
                 runSpacing: 10,
                 alignment:WrapAlignment.spaceBetween,
                 spacing: 27,
                 children: getDetailWrapList()
               ),
             ),
             Container(
               decoration: BoxDecoration( color: Colors.white,border: Border(top: BorderSide(width: 5,color: Color(0xffF5F5F5)))),
               padding: EdgeInsets.all(3),
               margin: EdgeInsets.only(bottom: 60),

             ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 5,right: 5,top: 7,bottom: 7),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        if(is_check==false){
                         ResultData res = await HttpManager.getInstance().post("stock/add_optional",params: {"stock_code":widget.stock_id},withLoading: false);

                           setState(() {
                             is_check = true;
                           });

                        }else{
                          ResultData res = await HttpManager.getInstance().post("stock/delete_optional",params: {"stock_code":widget.stock_id},withLoading: false);

                            setState(() {
                              is_check = false;
                            });

                        }
                      },
                      child: Wrap(
                        direction:Axis.vertical,
                        spacing: 3,
                        children: <Widget>[
                          this.is_check==false? Icon(//0xe610
                           const IconData(0xe621, fontFamily: 'iconfont'),
                            size:22,
                            color: Colors.yellow,
                          ):Icon(//0xe610
                            const IconData(0xe610, fontFamily: 'iconfont'),
                            size:22,
                            color: Colors.yellow,
                          ),
                         Text("自选",style: TextStyle(fontSize: 12),),

                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var is_login = await TokenStore().getToken("is_login");
                        if(is_login == null || is_login == "0"){
                          Rute.navigatorKey.currentState.pushNamedAndRemoveUntil("/login",
                              ModalRoute.withName("/"));
                          return;
                        }

                        JumpAnimation().jump(trade(default_stock_flag+widget.stock_id), context);
                      },
                      child: Container(

                        padding: EdgeInsets.only(left: 120,right: 120,top: 6,bottom: 6),
                        decoration: BoxDecoration(color: Color(0xffffe100),boxShadow:[
                          BoxShadow(
                            offset: Offset(3.0, 3.0),
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ],borderRadius: BorderRadius.circular(45)),
                        child: Text("交易",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this.dang_index = page;
    });
  }
  List getDetailWrapList(){
    double spacing = 5;
   return stock_detail.asMap().keys.map((e){
     if(e == 4){
       spacing = 2;
     }
     return Wrap(
       direction:Axis.vertical,
       crossAxisAlignment:WrapCrossAlignment.start,
       spacing: spacing,
       children: <Widget>[
         Text(stock_detail[e]["text"],style: TextStyle(fontSize:12,color: Color(0xff959ca7)),),
         Text(stock_detail[e]["value"],style: TextStyle(fontSize:12)),
       ],
     );
   }).toList();
  }
  List getKCate(){
    return k_cate.asMap().keys.map((e){

       return Material(
         color: Colors.white,
         child: Ink(

           child: InkWell(
             onTap: (){
               setState(() {
                 showLoading = true;
                 defaul_flag = k_cate[e]["time"];
               });
                   getData(k_cate[e]["time"],e);
             },
             splashColor: Colors.black26,
             child:  Container(
                 alignment: Alignment.center,
                 height: 35,
                 child: Text(k_cate[e]['text'],style: k_cate[e]['style']),
               ),


           ),
         ),
       );
    }).toList();
  }
  void getData(String period,int e) async {
    Map parseJson;
    Map parseJson1;
    Map data;
      String url;
    if(period == "1"){
      url = "stock/getTimeSharingData/"+widget.stock_id;

    }else{
      url = "stock/getKdata/"+period+"/"+widget.stock_id;

    }
    ResultData result = await HttpManager.getInstance().get(url,withLoading: false);

    data =  json.decode(result.data["data"]);


      Map map1;
      List list;
      if(period == "1"){
        list = data["showapi_res_body"]["dataList"][0]["minuteList"];
        Map data1 = json.decode(result.data["data1"]);
        map1 = data1["showapi_res_body"]["list"][0];
      }else{

        list = data["showapi_res_body"]["dataList"];
      }

      if(list != null){
        list.forEach((element) {
          String time = '';

          element["amount"] = 7628.590000000000000000;
          element["count"] = 7628.590000000000000000;
          if(period == "1"){
            var time_ = element["time"].toString();
            element["detail_time"] = element["time"].toString();
            element["open"] = 0.3;//万维易源没有开盘价随便写个0.3
            element["low"] = 7628.590000000000000000;
            element["high"] = 7628.590000000000000000;
            element["volume"] = num.parse(element["volume"]);
            element["nowPrice"] = num.parse(element["nowPrice"]);
            String str1 = time_.substring(0,1);
            String str2 = time_.substring(1,2);
            String str3 = time_.substring(2,3);
            String str4 = time_.substring(3,4);
            time = str1+str2+":"+str3+str4;
            element["time"] = time;

          }else{
            var o = 201611181500;
            if(period == "5" || period == "30"){
              var time_ = element["minute"].toString();
              String str1 = time_.substring(8,10);
              String str2 = ":";
              String str3 = time_.substring(10,12);
              time = str1+str2+str3;
              element["detail_time"] = element["minute"].toString();
            }else{
              var time_ = element["time"].toString();
              element["detail_time"] = element["time"].toString();
              String str1 = time_.substring(0,4);
              String str2 = "-";
              String str3 = time_.substring(4,6);
              time = str1+str2+str3;
            }

            element["open"] = num.parse(element["open"]);
            element["nowPrice"] = num.parse(element["close"]);
            element["low"] = num.parse(element["min"]);
            element["high"] = num.parse(element["max"]);
            element["time"] = time;
            element["volume"] = num.parse(element["volumn"]);
          }
        });

        if(period == "1"){
          datas = list.map((item) => KLineEntity.fromJson(item)).toList().toList().cast<KLineEntity>();
        }else{
          datas = list.map((item) => KLineEntity.fromJson(item)).toList().reversed.toList().cast<KLineEntity>();

        }
      }

      DataUtil.calculate(datas);
      showLoading = false;
      setState(() {
        if(period == "1"){
          stock_detail[0]["value"] = map1["openPrice"];
          stock_detail[1]["value"] = map1["closePrice"];
          stock_detail[2]["value"] = map1["todayMax"];
          stock_detail[3]["value"] = map1["todayMin"];
          stock_detail[4]["value"] = formatNum((double.parse(map1["tradeNum"])/1000000), 2).toString()+"万手";
          List s = map1["tradeAmount"].split('.');
          stock_detail[5]["value"] = formatNum((double.parse(s[0])/100000000), 2).toString()+"亿";
          stock_detail[6]["value"] = map1["swing"];
          stock_detail[7]["value"] = map1["highLimit"];
          stock_detail[8]["value"] = map1["downLimit"];
          stock_detail[9]["value"] = map1["pe"];
          stock_detail[10]["value"] = map1["pb"];
          stock_detail[11]["value"] = map1["turnover"];
          if(double.parse(map1["diff_rate"])>0.00){
            defalut_diff_money = "+"+map1["diff_money"];
            defalut_diff_rate = "+"+map1["diff_rate"]+"%";
            default_color = Colors.red;
          }else{
            defalut_diff_money = map1["diff_money"];
            defalut_diff_rate = map1["diff_rate"]+"%";
            default_color = Color(0xff09B971);
          }

          if(Util().checkStockTradeTime()){
            defalut_status = "交易中";
          }
          defalut_date = map1["date"]+" "+map1["time"];
          default_stock_flag = map1["market"];
          default_name = map1["name"];
          defalut_price = map1["nowPrice"];
          buy1_m = map1["buy1_m"];
          buy2_m = map1["buy2_m"];
          buy3_m = map1["buy3_m"];
          buy4_m = map1["buy4_m"];
          buy5_m = map1["buy5_m"];
          buy5_n = map1["buy5_n"];
          buy4_n = map1["buy4_n"];
          buy3_n = map1["buy3_n"];
          buy2_n = map1["buy2_n"];
          buy1_n = map1["buy1_n"];
          sell1_m = map1["sell1_m"];
          sell2_m = map1["sell2_m"];
          sell3_m = map1["sell3_m"];
          sell4_m = map1["sell4_m"];
          sell5_m = map1["sell5_m"];
          sell5_n = map1["sell5_n"];
          sell4_n = map1["sell4_n"];
          sell3_n = map1["sell3_n"];
          sell2_n = map1["sell2_n"];
          sell1_n = map1["sell1_n"];
        }


        if(e != 0){
          isLine =false;
        }else{
          isLine =true;
        }
        if(e != cur_index){
          k_cate[e]["style"] = check_style;
          k_cate[cur_index]["style"] = default_style;
          cur_index = e;
        }
      });

  }
  checkStockTradeTime(){

   if(DateTime.now().weekday == 0 || DateTime.now().weekday == 6){
        return false;
   }
   if((DateTime.now().hour+8) < 9 || ((DateTime.now().hour+8) == 9 && DateTime.now().minute < 30)){

     return false;
   }
   if((((DateTime.now().hour+8) == 11 && DateTime.now().minute > 30) || (DateTime.now().hour+8) > 11) && (DateTime.now().hour+8) < 13){
     return false;
   }
   if((DateTime.now().hour+8) >= 15){
     return false;
   }
   return true;
  }
  formatNum(double num,int postion){
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
      //小数点后有几位小数
      return num.toStringAsFixed(postion).substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }else{
      return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }
  }
  getNum(int num){
    int num_ = (num/1000).floor() as int;
    if(num_ >= 100){
      return (num / 10000).floor().toString()+"万";
    }else{
      return num.toString();
    }
  }
}