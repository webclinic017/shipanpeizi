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
import 'package:flutterapp2/utils/NumUtil.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
final GlobalKey<_deal> dealKey = GlobalKey();
class deal extends StatefulWidget{


  Function b;
  Function d;


  deal({
    Key key,
    this.heyue_id,
    this.b,
    this.d,
  }) : super(key: key);
  int heyue_id;
  bool is_out = false;

  @override
  _deal createState() => _deal();
}
class _deal extends State<deal>{
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
f.whenComplete(() => null);
  }

  getOrderList (i)async{
    ResultData result = await HttpManager.getInstance().get("frontend/order/findOrderByCase",params:{"stock_status":4,"heyue_id":i,"page":page.toString(),"sort":"-id","limit":"5","cancel_status":0},withLoading: false);
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
                  width: ScreenUtil().setWidth(100),
                  child: Text("名称"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(100),
                  child: Text("盈亏"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(100),
                  child: Text("卖出价"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(100),
                  child: Text("数量"),
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
          )
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

      if(order_list[e]["profit"]>0){
        cur_color = rase_color;
      }else if(order_list[e]["profit"] <0){
        cur_color = down_color;
      }else{
        cur_color = Colors.black;
      }
      return Column(
        children: <Widget>[
          Container(


            child:  Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: ScreenUtil().setWidth(100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(order_list[e]["stock_name"],style: TextStyle(color: cur_color),),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(NumUtil.getNumByValueDouble(double.parse(order_list[e]["profit"].toString()),2).toString(),style: TextStyle(color: cur_color),),
                      //Text(NumUtil.getNumByValueDouble(NumUtil.multiply(order_list[e]["profit_rate"], 100), 3).toString()+"%" ,style: TextStyle(color: cur_color)),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(order_list[e]["sell_price"].toString(),style: TextStyle(color: cur_color),),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(order_list[e]["sell_hand"].toString(),style: TextStyle(color: cur_color),),
                    ],
                  ),
                ),
              ],
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