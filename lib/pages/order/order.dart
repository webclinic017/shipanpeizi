
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/order/canceled.dart';
import 'package:flutterapp2/pages/order/entrust.dart';
import 'package:flutterapp2/pages/order/holdOrder.dart';

import 'deal.dart';

class order extends StatefulWidget{
  @override
  _order createState() => _order();
  
}
class _order extends State<order>{
  List<String> containers = ["持仓","已成交","委托中","已撤单"];
  int page = 0;
  TextStyle checked_text_style =
  TextStyle(fontSize:16,color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle unchecked_text_style = null;
  BoxDecoration checked_border_style = BoxDecoration(
      border: Border(
          top: BorderSide(
            // 设置单侧边框的样式
              color: Colors.yellow,
              width: 1.5,
              style: BorderStyle.solid)));
  BoxDecoration unchecked_border_style = null;
  PageController controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("订单中心",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(
          size: 12.0,
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(

            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      // 设置单侧边框的样式
                        color: Colors.grey,
                        width: 0.1,
                        style: BorderStyle.solid))),
            padding: EdgeInsets.only(left: 10,top: 10,),
            child: Row(
                children: containers.asMap().keys.map((e) {
                  TextStyle cur_ts;
                  BoxDecoration cur_bd;
                  if(e == page){
                    cur_ts = checked_text_style;
                    cur_bd = checked_border_style;
                  }else{
                    cur_ts = unchecked_text_style;
                    cur_bd = unchecked_border_style;
                  }
                  return Container(

                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      children: <Widget>[
                        Container(  padding: EdgeInsets.only(bottom: 5),child: Text(containers[e],style: cur_ts,),),
                        Container(decoration: cur_bd,width: 20,)
                      ],
                    ),
                  );
                }).toList()
            ),
          ),

          Expanded(

            child: PageView(
              controller: controller,
              onPageChanged: onPageChanged,
              children: <Widget>[
                holdOrder(),
                deal(),
                entrust(),
                canceled(),
              ],
            ),
          )
        ],
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
