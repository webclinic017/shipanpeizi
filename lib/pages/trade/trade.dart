import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/heyue/applyHeYue.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
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
  String market_price;
  String number = "0";
  double screenwidth;
  int cur_index = 0;
  int cur_page = 0;
  double slider = 0;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
    my_heyue_list.add(DropdownMenuItem(value: '0', child: Container(padding:EdgeInsets.only(left: 5,right: 60),child: Text('请选择合约'),)));
    weituo_way.add(DropdownMenuItem(value: '1', child: Container(padding:EdgeInsets.only(left: 0,right: 0),child: Text('限价委托'),)));
    weituo_way.add(DropdownMenuItem(value: '2', child: Container(padding:EdgeInsets.only(left: 0,right: 0),child: Text('市价委托'),)));
    getTradeData();
    getMyHeYue();
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
                print("hhh");
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
                              if(e != "0"){
                                max_buy_stock_num = my_heyue[int.parse(e)-1]["total_capital"]/cur_price;
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
                  margin: EdgeInsets.only(top: 30),
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
                                    market_price = '市价';
                                    is_readOnly = true;
                                    if(default_heyue != '0'){
                                      max_buy_stock_num = my_heyue[int.parse(default_heyue)-1]["total_capital"]/cur_price;
                                      trade_amount = double.parse(number)*cur_price;
                                    }
                                  }else{
                                    market_price = default_price;
                                    cur_price = double.parse(market_price);
                                    trade_amount = double.parse(number)*cur_price;
                                    is_readOnly = false;
                                  }
                                  default_weituo_way = e;
                                });

                              }),
                            ),

                            Container(
                              width: ScreenUtil().setWidth(200),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "涨停: 12.18",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  Text(
                                    "跌停: 9.96",
                                    style: TextStyle(fontSize: 11),
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

                                      /// 设置外边距

                                      child: TextField(
                                          keyboardType: TextInputType.number,
                                          readOnly: is_readOnly,
                                          inputFormatters: [
                                            //限制小数位数
                                            MyNumberTextInputFormatter(digit: 3)
                                          ],
                                          onChanged:(e){
                                            if(default_heyue != "0"){
                                              setState(() {
                                                max_buy_stock_num = my_heyue[int.parse(default_heyue)-1]["total_capital"]/double.parse(e);
                                                trade_amount = double.parse(number)*double.parse(e);
                                              });
                                            }
                                            setState(() {
                                              market_price = e;
                                              cur_price = double.parse(market_price);
                                            });
                                          },
                                          controller: TextEditingController
                                              .fromValue(TextEditingValue(
                                              text:
                                              '${this.market_price == null ? "" : this.market_price}',
                                              selection:
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      affinity:
                                                      TextAffinity
                                                          .downstream,
                                                      offset:
                                                      '${this.market_price}'
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
                                                  if(default_heyue != '0'){
                                                    max_buy_stock_num = my_heyue[int.parse(default_heyue)-1]["total_capital"]/cur_price;

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

                                                  if(default_heyue != '0'){
                                                    max_buy_stock_num = my_heyue[int.parse(default_heyue)-1]["total_capital"]/cur_price;
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
                                              if(default_heyue != "0"){

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
                                            if (default_heyue != "0")
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
                                            if (default_heyue != "0")
                                              if(number == null){
                                                setState(() {
                                                  number = 100.toString();

                                                });
                                                return;
                                              }
                                            if(number != null && double.parse(number)>=0){
                                              setState(() {
                                                number = (int.parse(number)+100).toString();


                                                if(double.parse(number) <max_buy_stock_num){
                                                  slider = double.parse(number);
                                                  trade_amount = double.parse(number)*cur_price;
                                                }else{
                                                  number = max_buy_stock_num.toStringAsFixed(0);
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
                                      max: max_buy_stock_num,
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
                                    child: Text(max_buy_stock_num.toStringAsFixed(0)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Text("交易额 "+trade_amount.toStringAsFixed(2)),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: MaterialButton(
                                splashColor:Colors.grey,
                                minWidth: ScreenUtil().setWidth(200),
                                color: color_list[cur_page]["bg_color"],
                                textColor: color_list[cur_page]["text_color"],
                                child: new Text(
                                  color_list[cur_page]["text"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  if(is_disable == true){
                                    EventDioLog("确认","暂无合约，请先申请合约",context,(){Navigator.pop(context);JumpAnimation().jump(new applyHeYue(), context);}).showDioLog();
                                    return ;
                                  }
                                  if(default_heyue == "0"){
                                    TipDioLog("提示","请选择合约",context).showDioLog();
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
                                  if(int.parse(number) > max_buy_stock_num){
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
                                                            Text(cur_price.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
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
                                                              Navigator.pop(contextx);
                                                              int member_heyue_id = my_heyue[int.parse(default_heyue)-1]["id"];
                                                              String stock_code = default_code;
                                                              String stock_name = default_name;
                                                              double buy_price = cur_price;
                                                              int trade_direction = cur_page==0?1:2;
                                                              int buy_hand = int.parse(number);
                                                              int entrust_way = int.parse(default_weituo_way);
                                                              ResultData result = await HttpManager.getInstance().post(Address.BASE_URL+"frontend/order/makeOrder",params:{"member_heyue_id":member_heyue_id,"stock_code":stock_code,"stock_name":stock_name,"buy_hand":buy_hand,"buy_price":buy_price,"trade_direction":trade_direction,"entrust_way":entrust_way},withLoading: true);
                                                              if(result.code == 200){
                                                                Toast.toast(context,msg: "下单成功");
                                                              }else{
                                                                Toast.toast(context,msg: result.msg);
                                                              }
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
                                },
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
                                                            0.21,
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
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this.cur_index = page;
    });
  }

  Future getTradeData() async {
    try {
      String result;
      result = await request().send_get('/stock/getTradeData/'+widget.stock_code);
      Map parseJson = json.decode(result);
      Map dat1 = json.decode(parseJson["data"]["data"]);
      Map dat2 = json.decode(parseJson["data"]["data1"]);
      List list = dat1["showapi_res_body"]["list"];
      Map map1 = list[0];
      List list1 = dat2["showapi_res_body"]["list"];

      setState(() {
        detail = list1;
        default_stock_flag = map1["market"];
        default_name = map1["name"];
        default_code = map1["code"];
        defalut_date = map1["date"] + " " + map1["time"];
        default_price = map1["nowPrice"];
        market_price = default_price;
        cur_price = double.parse(default_price);
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
    } catch (e) {
      print(e);
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
     });
     int i = 1;
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
