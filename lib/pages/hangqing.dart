import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutterapp2/pages/hangqing/StockRankList.dart';
import 'package:flutterapp2/pages/searchStock.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/request.dart';

import 'ChildItemView.dart';
class hangqing extends StatefulWidget{
  Function fn;
  hangqing({this.page,this.index});
  int page =0;
  int index = 0;
  Timer t;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new hangqing_();
  }

}
class hangqing_ extends State<hangqing>{
  List<String> containers = ["沪深","自选"];
  int page = 0;

  List<TextStyle> ts = [TextStyle()];
  @override
  void initState() {
    super.initState();
    page = widget.page==2?1:0;
    controller = new PageController(initialPage: widget.index);

  }

  TextStyle checked_text_style =
  TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15,right: 15, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
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
                            Container(child: Text(containers[e],style: cur_ts,),),
                            Container(decoration: cur_bd,width: 20,)
                          ],
                        ),
                      );
                    }).toList()
                ),
                GestureDetector(
                  onTap: (){
                    JumpAnimation().jump(searchStock(), context);
                  },
                  child: Icon(Icons.search,size: 30),
                )
              ],
            ),
          ),
          Expanded(

            child: PageView(
              controller: controller,
              onPageChanged: onPageChanged,
              children: <Widget>[
                StockRankList(),
                ChildItemView(),
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