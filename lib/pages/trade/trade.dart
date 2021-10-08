import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/hangqing/StockRankList.dart';
import 'package:flutterapp2/pages/heyue/applyHeYue.dart';
import 'package:flutterapp2/pages/order/deal.dart';
import 'package:flutterapp2/pages/order/holdOrder.dart';
import 'package:flutterapp2/pages/order/order.dart';
import 'package:flutterapp2/pages/searchStock.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/NumUtil.dart';
import 'package:flutterapp2/utils/TipDioLog.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:flutterapp2/utils/Util.dart';
import 'package:flutterapp2/utils/request.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/utils/NumberTextInputFormatter.dart';
class trade extends StatefulWidget {

  String stock_code;
  trade(this.stock_code);
  @override
  _trade createState() => _trade();
}

class _trade extends State<trade> {
  bool can_tap = true;
  String defalut_status = "未开盘";
  String defalut_date = "--";
  String default_stock_flag = "--";
  String default_name = "--";
  String default_code = "--";
  String default_price = "--";
  String default_diff = "--";
  String default_diff_money = "--";
  String default_heyue = '0';
  String default_weituo_way = "1";
  Color default_color = Colors.black;
  String search_code;
  String market_price;
  String input_price;
  String number = "0";
  double screenwidth;
  int cur_index = 0;
  int cur_page = 0;
  double slider = 0;
  int can_sell = 0;
  double trade_amount = 0;
  double max_buy_stock_num = 0;
  List trade_detail_list = ["五档", "明细"];
  List detail = [];
  bool is_disable = true;
  bool is_readOnly = false;
  double cur_price = 0;
  List my_heyue = [];
  List<DropdownMenuItem<String>> my_heyue_list = [];
  List<DropdownMenuItem<String>> weituo_way = [];
  Timer timer_;
  FocusNode _commentFocus;
  List color_list = [
    {"bg_color": Color(0xffffcc00), "text_color": Colors.black, "text": "买入","color":Colors.red},
    {
    "color":Colors.green,
      "bg_color": Colors.lightBlueAccent,
      "text_color": Colors.white,
      "text": "卖出"
    }
  ];
  List wudang = [];
  PageController controller;
List stock_list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
    stock_list = [];
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
    controller = new PageController(initialPage: this.cur_index);
    //my_heyue_list.add(DropdownMenuItem(value: '0', child: Container(padding:EdgeInsets.only(left: 5,right: 60),child: Text('请选择合约'),)));
    weituo_way.add(DropdownMenuItem(value: '1', child: Container(padding:EdgeInsets.only(left: 0,right: 0),child: Text('限价委托'),)));
    weituo_way.add(DropdownMenuItem(value: '2', child: Container(padding:EdgeInsets.only(left: 0,right: 0),child: Text('市价委托'),)));
   Future f = getTradeData();
    getMyHeYue();
   bool is_trade = Util().checkStockTradeTime();
   if(is_trade){
     timer_ = Timer.periodic(Duration(seconds: 5), (t){
       try{
         getTradeData();
       }catch(Exception){
       }
     });
   }

  }
  bool is_search = false;
  @override
  void dispose() {
    if(timer_ != null){
      timer_.cancel();
    }

    super.dispose();
  }
  getTradeAmount(){
    if(input_price != null){
      return (double.parse(input_price)*NumUtil.getDoubleByValueStr(number)).toStringAsFixed(2);

    }else{
      return "0";
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);
    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              tooltip: "Alarm",
              onPressed: () {
               getTradeData();
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
                    padding:
                    EdgeInsets.only(top: 1, bottom: 1, left: 3, right: 3),
                    child: Text(
                      default_stock_flag,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Text(
                    default_name,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.values[1],
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    defalut_status,
                    style: TextStyle(color: Color(0xFF686e7a), fontSize: 11),
                  ),
                  Text(
                    "  " + defalut_date,
                    style: TextStyle(color: Color(0xFF686e7a), fontSize: 11),
                  )
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[

                Column(
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only(top: 15, left: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              "选择合约",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(

                            height: 30,
                            color: Color(0xfff0f0f0),
                            child: DropdownButton(
                              underline: Container(),
                              items: my_heyue_list,
                              value: default_heyue,
                              iconDisabledColor: Color(0xFF333333),//图标禁用颜色
                              //禁用提示 的样式
                              disabledHint: Container(padding:EdgeInsets.only(left: 5,right: 60),child: Text(
                                "选择合约",
                                style: TextStyle(color: Color(0xFF333333)),
                              ),),
                              onChanged: is_disable == true ? null : (e) {
                                setState(() {
                                  default_heyue = e;



                                  childKey.currentState.fun1(int.parse(e),0);

                                  if(my_heyue.length>0){
                                    max_buy_stock_num = my_heyue[int.parse(e)]["total_capital"]/cur_price;
                                    trade_amount = cur_price*double.parse(number);

                                  }else{
                                    max_buy_stock_num = 0;
                                    trade_amount = 0;
                                    this.slider = 0;
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 15),
                      child: Row(

                        children: <Widget>[
                          Text("代码"),
                          GestureDetector(
                            onTap: (){
                              //JumpAnimation().jump(searchStock(), context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 40),
                              child: Row(

                                children: <Widget>[
                                  Text(default_name),
                                  Container(
                                    margin: EdgeInsets.only(left: 10,right: 10,top: 3),
                                    width: 90,
                                    height: 20,
                                    child: TextField(
                                        focusNode: _commentFocus,
                                        onChanged:(e){

                                          setState(() async {

                                            setState(() {

                                              search_code = e;
                                            });
                                            if(e.length>=3){
                                              ResultData result =  await HttpManager.getInstance().get("stock/searchStock",params: {"stock_code":e},withLoading: false);
                                              Map res = result.data;
                                              Map res1 =  json.decode(res["data"]);
                                              Map res2 = res1["showapi_res_body"];
                                              List res3 = res2["list"];
                                              setState(() {
                                                if(res3.length>10){
                                                  stock_list = res3.sublist(0,9);
                                                }else{
                                                  stock_list = res3;
                                                }
                                                if(stock_list.length>0){
                                                  is_search = true;
                                                }else{
                                                  is_search = false;
                                                }
                                              });
                                            }else{
                                              setState(() {
                                                is_search = false;
                                              });
                                            }
                                          });
                                        },
                                        controller: TextEditingController
                                            .fromValue(TextEditingValue(
                                            text:
                                            '${this.search_code == null ? "" : this.search_code}',
                                            selection:
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    affinity:
                                                    TextAffinity
                                                        .downstream,
                                                    offset:
                                                    '${this.search_code}'
                                                        .length)))),

                                        /// 设置字体
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                        /// 设置输入框样式
                                        decoration: InputDecoration(

                                          border: InputBorder.none,
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      FocusScope.of(context).requestFocus(_commentFocus);
                                    },
                                    child: Icon(Icons.search),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Text(default_name),
                          ),
                          Container(
                            child: Text(default_code),
                          ),
                          Container(
                            child: Text(
                              default_price,
                              style: TextStyle(color: default_color),
                            ),
                          ),
                          Container(
                            child: Text(default_diff_money,
                                style: TextStyle(color: default_color)),
                          ),
                          Container(
                            child: Text(default_diff,
                                style: TextStyle(color: default_color)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 10,left: 15),
                      child: Wrap(

                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(250),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(200),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: color_list.asMap().keys.map((e) {
                                      Color cur_text_color = Colors.grey;
                                      Color cur_bg_color = Color(0xfff0f0f0);


                                      if (e == cur_page) {
                                        cur_bg_color = color_list[e]["bg_color"];
                                        cur_text_color = color_list[e]["text_color"];
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          if(e==1){

                                            if(double.parse(number)>can_sell){
                                              setState(() {
                                                slider = can_sell.toDouble();
                                                number = can_sell.toString();
                                              });
                                            }
                                          }else{
                                            if(double.parse(number)>max_buy_stock_num){
                                              setState(() {
                                                slider = max_buy_stock_num.toDouble();
                                                number = max_buy_stock_num.toStringAsFixed(0);
                                              });
                                            }
                                            setState(() {

                                              if(my_heyue.length>0){
                                                max_buy_stock_num =  my_heyue[int.parse(default_heyue)]["total_capital"]/cur_price;

                                              }else{
                                                max_buy_stock_num = 0;
                                              }
                                            });
                                          }
                                          setState(() {
                                            cur_page = e;
                                          });

                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(top: 10,bottom: 10),
                                          alignment: Alignment.center,
                                          width: ScreenUtil().setWidth(100),
                                          color: cur_bg_color,
                                          child: Text(
                                            color_list[e]["text"],
                                            style: TextStyle(
                                                color: cur_text_color,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black87, width: 0.5)),
                                  width: ScreenUtil().setWidth(200),
                                  child: DropdownButton(
                                      value: default_weituo_way,
                                      underline: Container(),
                                      items: [
                                        DropdownMenuItem(value:"1",child: Container(padding:EdgeInsets.only(right: ScreenUtil().setWidth(110)),child: Text('限价委托',style: TextStyle(fontSize: 12),),)),
                                        DropdownMenuItem(value:"2",child: Container(child: Text('市价委托',style: TextStyle(fontSize: 12),),)),
                                      ], onChanged: (e) {
                                    setState(() {
                                      if(e == '2'){
                                        cur_price = double.parse(default_price);
                                        input_price = default_price;
                                        market_price = '市价';
                                        is_readOnly = true;
                                        if(my_heyue.length>0){
                                          max_buy_stock_num = my_heyue[int.parse(default_heyue)]["total_capital"]/cur_price;
                                          trade_amount = double.parse(number)*cur_price;
                                        }
                                      }else{
                                        market_price = default_price;
                                        cur_price = double.parse(market_price);
                                        input_price = market_price;
                                        trade_amount = double.parse(number)*cur_price;
                                        is_readOnly = false;
                                      }
                                      default_weituo_way = e;
                                    });

                                  }),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: ScreenUtil().setWidth(200),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          width: ScreenUtil().setWidth(140),
                                          height: 30,

                                          /// 设置外边距

                                          child: TextField(

                                              readOnly: is_readOnly,
                                              inputFormatters: [
                                                //限制小数位数
                                                WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                                              ],
                                              onChanged:(e){

                                                if(my_heyue.length>0){

                                                  setState(() {
                                                    max_buy_stock_num = my_heyue[int.parse(default_heyue)]["total_capital"]/double.parse(e);
                                                    trade_amount = double.parse(number)*double.parse(e);

                                                  });
                                                }
                                                setState(() {
                                                  market_price = e;
                                                  cur_price = double.parse(market_price);
                                                  input_price = e;
                                                });
                                              },
                                              controller: TextEditingController
                                                  .fromValue(TextEditingValue(
                                                  text:
                                                  '${this.input_price == null ? "" : this.input_price}',
                                                  selection:
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          affinity:
                                                          TextAffinity
                                                              .downstream,
                                                          offset:
                                                          '${this.input_price}'
                                                              .length)))),

                                              /// 设置字体
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),

                                              /// 设置输入框样式
                                              decoration: InputDecoration(
                                                hintText: '价格',
                                                /// 边框
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft:
                                                        Radius.circular(0))),
                                                ///设置内容内边距
                                                contentPadding: EdgeInsets.only(
                                                  left: 5,
                                                  top: 0,
                                                  bottom: 0,
                                                ),
                                              ))),
                                      Container(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        width: ScreenUtil().setWidth(60),
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.black87,
                                                    width: 0.5),
                                                bottom: BorderSide(
                                                    color: Colors.black87,
                                                    width: 0.5),
                                                right: BorderSide(
                                                    color: Colors.black87,
                                                    width: 0.5))),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  if(default_weituo_way != '2'){
                                                    if(market_price != null && double.parse(market_price) > 0){
                                                      market_price = (double.parse(market_price)-0.01).toStringAsFixed(2);

                                                      cur_price = double.parse(market_price);
                                                      input_price = market_price;

                                                      if(my_heyue.length>0){
                                                        if(cur_page ==0){
                                                          max_buy_stock_num = my_heyue[int.parse(default_heyue)]["total_capital"]/cur_price;
                                                        }else{
                                                          max_buy_stock_num = can_sell.toDouble();
                                                        }

                                                        trade_amount = cur_price*double.parse(number);
                                                      }
                                                    }
                                                  }
                                                });
                                              },
                                              child: Text("—"),
                                            ),
                                            GestureDetector(
                                              onTap: (){

                                                setState(() {
                                                  if(default_weituo_way != '2'){
                                                    if(market_price != null && double.parse(market_price) > 0){
                                                      market_price = (double.parse(market_price)+0.01).toStringAsFixed(2);
                                                      cur_price = double.parse(market_price);
                                                      input_price = market_price;
                                                      if(my_heyue.length>0){
                                                        if(cur_page ==0){
                                                          max_buy_stock_num = my_heyue[int.parse(default_heyue)]["total_capital"]/cur_price;
                                                        }else{
                                                          max_buy_stock_num = can_sell.toDouble();
                                                        }
                                                        trade_amount = cur_price*double.parse(number);
                                                      }
                                                    }
                                                  }
                                                });
                                              },
                                              child: Text("+"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: ScreenUtil().setWidth(200),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          width: ScreenUtil().setWidth(140),
                                          height: 30,
                                          child: TextField(
                                              onChanged: (e){
                                                setState(() {
                                                  number =e;
                                                  if(my_heyue.length>0){

                                                    if(double.parse(e) <max_buy_stock_num){

                                                      slider = double.parse(e);
                                                    }
                                                    trade_amount = double.parse(e)*cur_price;
                                                  }
                                                });
                                              },
                                              keyboardType: TextInputType.number,
                                              inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
                                              controller: TextEditingController
                                                  .fromValue(TextEditingValue(
                                                  text:
                                                  '${this.number == null ? "" : this.number}',
                                                  selection:
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          affinity:
                                                          TextAffinity
                                                              .downstream,
                                                          offset:
                                                          '${this.number}'
                                                              .length)))),
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: '数量',
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft:
                                                        Radius.circular(0))),

                                                ///设置内容内边距
                                                contentPadding: EdgeInsets.only(
                                                  left: 5,
                                                  top: 0,
                                                  bottom: 0,
                                                ),
                                              ))),
                                      Container(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        width: ScreenUtil().setWidth(60),
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.black87,
                                                    width: 0.5),
                                                bottom: BorderSide(
                                                    color: Colors.black87,
                                                    width: 0.5),
                                                right: BorderSide(
                                                    color: Colors.black87,
                                                    width: 0.5))),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: (){
                                                if(is_disable != true)
                                                  if(number != null && double.parse(number)>0){
                                                    setState(() {
                                                      number = (int.parse(number)-100).toString();
                                                      if(int.parse(number) < 0){
                                                        number = "0";
                                                      }


                                                      if(double.parse(number) <max_buy_stock_num){
                                                        slider = double.parse(number);


                                                      }
                                                      trade_amount = double.parse(number)*cur_price;

                                                      number = (double.parse((double.parse(number)/100).toStringAsFixed(0))*100).toStringAsFixed(0);
                                                    });
                                                  }
                                              },
                                              child: Text("—"),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                if(is_disable != true)
                                                  if(number == null){
                                                    setState(() {
                                                      number = 100.toString();
                                                    });
                                                    return;
                                                  }
                                                if(number != null && double.parse(number)>=0){
                                                  setState(() {
                                                    number = (int.parse(number)+100).toString();



                                                    if(cur_page == 0){
                                                      if(double.parse(number) <max_buy_stock_num){
                                                        slider = double.parse(number);
                                                        trade_amount = double.parse(number)*cur_price;
                                                      }else{
                                                        number =max_buy_stock_num.toStringAsFixed(0);
                                                      }
                                                    }else{
                                                      if(double.parse(number) <can_sell){
                                                        slider = double.parse(number);
                                                        trade_amount = double.parse(number)*cur_price;
                                                      }else{
                                                        number =can_sell.toStringAsFixed(0);
                                                      }
                                                    }



                                                    number = (double.parse((double.parse(number)/100).toStringAsFixed(0))*100).toStringAsFixed(0);

                                                  });
                                                }
                                              },
                                              child: Text("+"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(200),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(5),
                                        child: Text("0"),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(130),
                                        child: Slider(
                                          divisions:100,
                                          inactiveColor: Colors.blue,
                                          value: this.slider,
                                          max: cur_page==0? max_buy_stock_num<=1?1:max_buy_stock_num:can_sell.toDouble(),
                                          min: 0.0,
                                          activeColor: Color(0xffffcc00),
                                          onChanged: (double val) {
                                            this.setState(() {
                                              this.slider = val;
                                              number = val.toStringAsFixed(0);
                                              trade_amount = double.parse(number)*cur_price;
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(65),
                                        child: Text(cur_page==0?max_buy_stock_num.toStringAsFixed(0):can_sell.toStringAsFixed(0)),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Text("交易额 "+getTradeAmount()),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: MaterialButton(
                                    splashColor:Colors.grey,
                                    minWidth: ScreenUtil().setWidth(200),
                                    color: color_list[cur_page]["bg_color"],
                                    textColor: color_list[cur_page]["text_color"],
                                    child: new Text(
                                      color_list[cur_page]["text"],
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: can_tap==true?() {
                                      if(is_disable == true){
                                        EventDioLog("确认","暂无合约，请先申请合约",context,(){Navigator.pop(context);JumpAnimation().jump(new applyHeYue(), context);}).showDioLog();
                                        return ;
                                      }

                                      if(int.parse(number) == 0){
                                        TipDioLog("提示","请入输数量",context).showDioLog();
                                        return;
                                      }

                                      if(int.parse(number)%100 != 0){
                                        TipDioLog("提示","请输入100的倍数",context).showDioLog();
                                        return;
                                      }
                                      int limit_number = cur_page==0?max_buy_stock_num.toInt():can_sell;
                                      if(int.parse(number) > limit_number){
                                        TipDioLog("提示","超过最大购买数量",context).showDioLog();
                                        return;
                                      }
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext contextx){
                                            return Container(
                                              child: Material(
                                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                                child: Center(
                                                  child: Stack(

                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.all(20),
                                                        decoration: BoxDecoration(color: Colors.white),
                                                        width: 300,
                                                        child: Wrap(
                                                          runSpacing: 15,
                                                          children: <Widget>[
                                                            Container(
                                                              alignment: Alignment.center,
                                                              child: Text("确认委托"),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(border: Border(top: BorderSide(width: 0.2,color: Colors.black12))),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Text("股票名称"),
                                                                Text(default_name,style: TextStyle(fontWeight: FontWeight.bold)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Text("股票代码"),
                                                                Text(default_code,style: TextStyle(fontWeight: FontWeight.bold),),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Text("数量"),
                                                                Text(number.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Text("价格"),
                                                                Text(input_price!=null?input_price:cur_price.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Text("方向"),
                                                                Text(color_list[cur_page]["text"],style: TextStyle(fontWeight: FontWeight.bold,color: color_list[cur_page]["color"])),
                                                              ],
                                                            ),

                                                            Container(
                                                              child: Text("是否确认以上委托?"),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 0,
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xfff0f0f0),width: 1),right:BorderSide(color:Color(0xfff0f0f0),width: 1) )),
                                                              child: MaterialButton(
                                                                splashColor:Colors.grey,
                                                                minWidth: 148,
                                                                height:50,
                                                                child: new Text(
                                                                  "取消",
                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                              ),
                                                            ),
                                                            Container(

                                                              decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xfff0f0f0),width: 1))),
                                                              child: MaterialButton(
                                                                splashColor:Colors.grey,
                                                                minWidth: 148,
                                                                height:50,

                                                                child: new Text(
                                                                  "确认",
                                                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                                                                ),
                                                                onPressed: () async{
                                                                  setState(() {

                                                                    can_tap = false;
                                                                  });
                                                                  Navigator.pop(contextx);

                                                                  int member_heyue_id = my_heyue[int.parse(default_heyue)]["id"];
                                                                  String stock_code = default_stock_flag+default_code;
                                                                  String stock_name = default_name;
                                                                  double buy_price;
                                                                  if(input_price == null){
                                                                   buy_price = cur_price;
                                                                  }else{
                                                                   buy_price = double.parse(input_price);
                                                                  }

                                                                  int trade_direction = cur_page==0?1:2;
                                                                  int buy_hand = int.parse(number);
                                                                  int entrust_way = int.parse(default_weituo_way);
                                                                  String url;
                                                                  if(trade_direction == 1){
                                                                    url = "frontend/order/makeOrder";
                                                                  }else{
                                                                    url = "frontend/order/sell_stock";
                                                                  }
                                                                  setState(() {
                                                                    slider =0;
                                                                  });
                                                                  ResultData result = await HttpManager.getInstance().post(Address.BASE_URL+url,params:{"member_heyue_id":member_heyue_id,"stock_code":stock_code,"stock_name":stock_name,"buy_hand":buy_hand,"buy_price":buy_price,"trade_direction":trade_direction,"entrust_way":entrust_way},withLoading: true);
                                                                  if(result.code == 200){
                                                                    Toast.toast(context,msg: "下单成功");
                                                                    getMyHeYue();
                                                                    setState(() {
                                                                      if(trade_direction == 2){
                                                                        can_sell = can_sell - buy_hand;
                                                                      }

                                                                    });
                                                                    childKey.currentState.fun1(default_heyue,5);

                                                                  }else{
                                                                    Toast.toast(context,msg: result.msg);
                                                                  }
                                                                  setState(() {

                                                                    can_tap = true;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        right: 20,
                                                        top: 20,
                                                        child: GestureDetector(
                                                          child: Container(

                                                            child: Icon(Icons.close),
                                                          ),
                                                          onTap: (){
                                                            Navigator.pop(context);
                                                          },
                                                        ),
                                                      )

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                      );
                                    }:null,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: Colors.black26, width: 0.5),
                                  bottom:
                                  BorderSide(color: Colors.black26, width: 0.5),
                                  left: BorderSide(color: Colors.black26, width: 0.5),
                                  right:
                                  BorderSide(color: Colors.black26, width: 0.5)),
                            ),
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: 290,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: trade_detail_list.asMap().keys.map((e) {
                                      FontWeight fw = FontWeight.normal;
                                      if (cur_index == e) {
                                        fw = FontWeight.bold;
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            cur_index = e;
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
                                                      if(default_weituo_way != '2'){
                                                        setState(() {
                                                          market_price = wudang[e]["price"];
                                                          cur_price = double.parse(wudang[e]["price"]);
                                                          input_price = wudang[e]["price"];
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 3, right: 3),
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.32,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Container(
                                                            width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.18,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: <Widget>[
                                                                Text(
                                                                  wudang[e]["text"],
                                                                  style: TextStyle(
                                                                      fontSize: 12),
                                                                ),
                                                                Text(
                                                                  wudang[e]["price"],
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      color:
                                                                      default_color),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            wudang[e]["number"],
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
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(260),
                      child: Column(
                        children: <Widget>[
                          order(code:widget.stock_code,key: childKey,data: my_heyue,f: (e,c){
                            setState(() {
                              if(widget.stock_code == "null"){
                                  widget.stock_code = e;
                                  getTradeData();
                              }
                                can_sell = c;
                            });
                          },d: (code){
                            setState(() {
                              widget.stock_code = code;
                              getTradeData();
                            });
                          },),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: this.is_search ,
                  child: Positioned(


                    bottom: 0,
                    right: 0,
                    top: 0,
                    left: 0,
                    child:   Opacity(
                      opacity: 0.5,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: this.is_search ,
                  child: Positioned(
                    top: 50,
                    child: Container(
                      width: ScreenUtil().setWidth(417),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Container(
                          height: 30,
                          width: ScreenUtil().setWidth(410),
                          child: TextField(
                            onChanged:(e){
                              setState(() async {
                                setState(() {
                                  search_code = e;
                                });
                                if(e.length>=3){
                                  ResultData result =  await HttpManager.getInstance().get("stock/searchStock",params: {"stock_code":e},withLoading: false);
                                  Map res = result.data;
                                  Map res1 =  json.decode(res["data"]);
                                  Map res2 = res1["showapi_res_body"];
                                  List res3 = res2["list"];
                                  setState(() {
                                      stock_list = res3;
                                    if(stock_list.length>0){
                                      is_search = true;
                                    }else{
                                      is_search = false;
                                    }
                                  });
                                }else{
                                  setState(() {
                                    is_search = false;
                                  });
                                }
                              });
                            },
                            controller: TextEditingController
                                .fromValue(TextEditingValue(
                                text:
                                '${this.search_code == null ? "" : this.search_code}',
                                selection:
                                TextSelection.fromPosition(
                                    TextPosition(
                                        affinity:
                                        TextAffinity
                                            .downstream,
                                        offset:
                                        '${this.search_code}'
                                            .length)))),

                            /// 设置字体


                            style: TextStyle(
                              fontSize: 13,
                            ),
                            /// 设置输入框样式
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: 0,
                                bottom: 0,
                                left: 10
                              ),
                              filled:true, //一定加入个属性不然不生效
                              fillColor: Colors.white,
                              hintText: "请输入验证码",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                // color: Colors.white,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: Color(0xff9e51ff),), //这个不生效
                              ),
                            ),
                          ),
                        )],
                      ),
                    )
                  ),
                ),
                Visibility(
                  visible: this.is_search ,
                  child: Container(
                    margin: EdgeInsets.only(top: 90),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              is_search = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10,top: 10),
                            alignment: Alignment.topRight,
                            child: Text("关闭"),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getStockList(),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
  List<MaterialButton> getStockList(){

    return stock_list.asMap().keys.map((e){
      return MaterialButton(onPressed: () async {
          widget.stock_code = stock_list[e]["market"].toString()+stock_list[e]["code"];
         setState(() {
           is_search = false;
         });
         getTradeData();
         sunKey.currentState.getOrderList(my_heyue[int.parse(default_heyue)]["id"]);
      },child: Container(

        padding: EdgeInsets.only(top: 5,bottom: 5),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(stock_list[e]["name"],style: TextStyle(fontWeight: FontWeight.bold),)
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 3),
                  padding: EdgeInsets.only(top: 1,bottom: 1,left: 3,right: 3),
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(stock_list[e]["market"].toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 9),),
                ),
                Text(stock_list[e]["code"])
              ],
            )
          ],
        ),
      ),);
    }).toList();
  }
  void onPageChanged(int page) {
    setState(() {
      this.cur_index = page;
    });
  }

  Future getTradeData() async {

    if(widget.stock_code != "null"){
      ResultData dd = await HttpManager.getInstance().get("stock/getTradeData/"+widget.stock_code,withLoading: false);
      Map s1 =  json.decode(dd.data["data"]);
      Map s2 = json.decode(dd.data["data1"]);
      List list = s1["showapi_res_body"]["list"];
      Map map1 = list[0];
      List list1 = s2["showapi_res_body"]["list"];

      setState(() {
          detail = list1;
          default_stock_flag = map1["market"];
          default_name = map1["name"];
          default_code = map1["code"];
        // search_code = default_code;
          defalut_date = map1["date"] + " " + map1["time"];
          default_price = map1["nowPrice"];
          market_price = default_price;
          cur_price = double.parse(default_price);
         if(my_heyue.length>0){
           max_buy_stock_num = my_heyue[int.parse(default_heyue)]["total_capital"]/cur_price;

         }else{
           max_buy_stock_num = 0;
         }
          if (Util().checkStockTradeTime()) {
            defalut_status = '交易中';
          }
          if (double.parse(map1["diff_rate"]) > 0.00) {
            default_diff_money = "+" + map1["diff_money"];
            default_diff = "+" + map1["diff_rate"] + "%";
            default_color = Colors.red;
          } else {
            default_diff_money = map1["diff_money"];
            default_diff = map1["diff_rate"] + "%";
            default_color = Color(0xff09B971);
          }

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

    }

  }

  formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      //小数点后有几位小数
      return num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    }
  }

  guTransToShou(String gu) {
    int a = int.parse(gu);
    num b = (a / 100).round();
    return b.toString();
  }

  getMyHeYue() async{
    ResultData result = await HttpManager.getInstance().get(Address.BASE_URL+"frontend/selectMemberHeYueByCase",withLoading: false);
   List a = result.data;

    if(a !=null && a.length>0){

      setState(() {
       my_heyue = a;
       is_disable = false;

      if(cur_price != 0){
        max_buy_stock_num = a[0]["total_capital"]/cur_price;
      }
     });
     int i = 0;
     my_heyue_list = [];
     a.forEach((element) {
       if(i > a.length){
         return;
       }
       my_heyue_list.add(DropdownMenuItem(value: i.toString(), child: Container(padding:EdgeInsets.only(left: 5,right: 60),child: Text("操盘金额:"+element["total_capital"].toString()))));
       i++;
     });
   }

  }
}
