import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/order/deal.dart';
import 'package:flutterapp2/utils/NumUtil.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:flutterapp2/utils/Util.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
GlobalKey<_holdOrder> sunKey = new GlobalKey();

class holdOrder extends StatefulWidget{


Function b;
Function d;
String code;
  holdOrder({
    Key key,
    this.heyue_id,
    this.b,
    this.d,
    this.code
  }) : super(key: key);
  int heyue_id;
  bool is_out = false;

  @override
  _holdOrder createState() => _holdOrder();
}
class _holdOrder extends State<holdOrder>{
  Color rase_color = Colors.red;
  Color down_color = Colors.blue;
  List order_list = [];
  WebSocketChannel channel;
  Future f;
  Timer timer_;
  int page = 1;
  BuildContext c;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    f = getOrderList(widget.heyue_id);
   f.whenComplete((){
     bool is_trade = Util().checkStockTradeTime();
     if(is_trade){
       sendmsg();
     }

   });
  }
  onDone(){
      if(widget.is_out == false){
        sendmsg();
      }
  }
  void sendmsg()async{

    channel = IOWebSocketChannel.connect(Address.WEBSOCKET_GET_ORDER_URL+widget.heyue_id.toString());

    timer_ = Timer.periodic(Duration(seconds: 5), (t){
      try{
        channel.sink.add("ping");
      }catch(Exception){

      }

    });
    channel.stream.listen(this.onData, onError: onError, onDone: onDone);
  }
  onError(err){
    debugPrint(err.runtimeType.toString());
    WebSocketChannelException ex = err;
    debugPrint(ex.message);
  }

  onData(event){
    if(event != "ping"){
      Map map = jsonDecode(event);

      List s = [];

      map.forEach((key, value) {
        int i =0;
        Map map = jsonDecode(value);
        for(int i=0;i<order_list.length;i++){
          ///根据索引获取List中的数据
          if(order_list[i]["id"] == int.parse(key)){
            setState(() {
              order_list[i]["profit"] = map["profit"];
              order_list[i]["trade_price"] = map["trade_price"];
              order_list[i]["now_price"] = map["now_price"];
              order_list[i]["profit_rate"] = map["profit_rate"];
              order_list[i]["market_value"] = map["market_value"];
            });

          }
        }
      });
    }

  }
  getOrderList (i)async{

    ResultData result = await HttpManager.getInstance().get("frontend/order/findOrderByCase",params:{"stock_status":2,"heyue_id":i,"page":page.toString(),"sort":"-id","limit":"5","cancel_status":0},withLoading: false);
    List s = result.data;

    setState(() {
       if(page == 1){
         order_list = s;
       }else{
         if(s.length>0){
           s.forEach((element) {
             order_list.add(element);
           });
         }
       }
     });
    int can_sell =0;
    if(widget.code != "null"){
      if(s != null){
        if(s.length>0){
          s.forEach((element) {
            if(element["stock_code"] == widget.code){
              can_sell = element["can_sell"];
            }
          });
        }
      }
     }else{
      if(order_list.length>0){
        can_sell = order_list[0]["can_sell"];
      }
    }

     if(order_list.length>0){
      widget.b(order_list[0]["stock_code"],can_sell);
     }else{
       widget.b('sh600000',0);
     }

  }

  @override
  void dispose() {



       widget.is_out = true;

  if(timer_ != null){
    timer_.cancel();
    channel.sink.close();
  }

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      c = context;
    });
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return EasyRefresh(

      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: ScreenUtil().setWidth(140),
                  child: Text("名称|市值"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(95),
                  child: Text("浮动盈亏"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(95),
                  child: Text("持仓|可用"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(75),
                  child: Text("成本|现价"),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Divider(),
          ),

          Wrap(
            runSpacing: 5,
            children: getList(),
          ),

        ],
      ),
      onRefresh: ()async{

        getOrderList(widget.heyue_id);
      },
      loadMore: ()async{

    setState(() {
      page++;
    });
    getOrderList(widget.heyue_id);
      },
      refreshHeader: MaterialHeader(
        key: null,
      ),
      refreshFooter: MaterialFooter(key: null),
    );
  }
  getList(){
    return order_list.asMap().keys.map((e){
      Color cur_color = down_color;
     double profit = NumUtil.multiply(NumUtil.subtract(order_list[e]["now_price"], order_list[e]["buy_price"]), order_list[e]["buy_hand"]);
       profit = NumUtil.getNumByValueDouble(profit, 2);
       double profit_rate = NumUtil.subtract(order_list[e]["now_price"], order_list[e]["buy_price"]);
       profit_rate = NumUtil.divide(profit_rate, order_list[e]["buy_price"]);
      profit_rate = profit_rate*100;
      profit_rate = NumUtil.getNumByValueDouble(profit_rate, 2);
      if(profit>0){
        cur_color = rase_color;
      }else if(profit <0){
        cur_color = down_color;
      }else{
        cur_color = Colors.black;
      }
      return Column(
        children: <Widget>[
          Ink(
            padding: EdgeInsets.only(bottom: 5),
           child: InkWell(
             splashColor: Colors.black26,
             onTap: (){
               setState(() {

                 widget.d(order_list[e]["stock_code"]);
                 widget.b(order_list[e]["stock_code"],order_list[e]["can_sell"]);
                });
             },
             child: Container(


               child:  Row(
                 children: <Widget>[
                   Container(
                     padding: EdgeInsets.only(left: 10),
                     width: ScreenUtil().setWidth(140),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(order_list[e]["stock_name"],style: TextStyle(color: cur_color),),
                         Text(NumUtil.getNumByValueDouble(NumUtil.multiply(order_list[e]["now_price"], order_list[e]["buy_hand"]).toDouble(), 2).toString(),style: TextStyle(color: cur_color)),
                       ],
                     ),
                   ),
                   Container(
                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(95),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         Text(profit.toString(),style: TextStyle(color: cur_color),),
                        Text(profit_rate.toString()+"%" ,style: TextStyle(color: cur_color)),
                       ],
                     ),
                   ),
                   Container(
                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(95),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         Text(order_list[e]["buy_hand"].toString(),style: TextStyle(color: cur_color)),
                         Text((order_list[e]["can_sell"]).toString(),style: TextStyle(color: cur_color),),

                       ],
                     ),
                   ),
                   Container(
                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(75),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         Text(order_list[e]["buy_price"].toString(),style: TextStyle(color: cur_color),),
                         Text(order_list[e]["now_price"].toString(),style: TextStyle(color: cur_color)),
                       ],
                     ),
                   )
                 ],
               ),
             ),
           ),
          ),

          Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Divider(),
          )
        ],
      );
    }).toList();
  }
}