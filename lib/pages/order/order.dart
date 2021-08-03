
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/order/canceled.dart';
import 'package:flutterapp2/pages/order/entrust.dart';
import 'package:flutterapp2/pages/order/holdOrder.dart';

import 'deal.dart';

GlobalKey<_order> childKey = GlobalKey();
class order extends StatefulWidget{
  List data = [];

Function f;
Function d;
String code;
  order({
    Key key,
    this.data,
    this.f,
    this.d,
    this.code
  }) : super(key: key);
  @override
  _order createState() => _order();
  
}

class _order extends State<order>{
  int index=0;
  void fun1(i,pages){

    if(pages ==5){
      controller.jumpToPage(2);
      page = 2;
    }else{
      setState(() {
        index = i;
      });

      if(dealKey.currentState != null){
        dealKey.currentState.getOrderList(widget.data[index]["id"]);
      }
      if(sunKey.currentState != null){
        sunKey.currentState.getOrderList(widget.data[index]["id"]);
      }
      if(entrustKey.currentState != null){
        entrustKey.currentState.getOrderList(widget.data[index]["id"]);
      }
      if(canceledKey.currentState != null){
        canceledKey.currentState.getOrderList(widget.data[index]["id"]);
      }

    }
  }
  List<String> containers = ["持仓","平仓","委托","已撤"];
  int page = 0;
  List<DropdownMenuItem<String>> my_heyue_list = [];

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
  List my_heyue = [];
  bool is_disable = true;
  String default_heyue = '0';
  @override
  void initState(){
    super.initState();
    setState(() {
      controller = new PageController(initialPage: this.page);
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);
    return Expanded(
      child: Column(
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
            child: Column(
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
                            Container(  padding: EdgeInsets.only(bottom: 5),child: Text(containers[e],style: cur_ts,),),
                            Container(decoration: cur_bd,width: 20,)
                          ],
                        ),
                      );
                    }).toList()
                )
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: onPageChanged,
              children: <Widget>[
                widget.data.length>0? holdOrder(code:widget.code,heyue_id: widget.data[index]["id"],key: sunKey,b: widget.f,d:widget.d):Container(),
                widget.data.length>0? deal(heyue_id: widget.data[index]["id"],key: dealKey,b: widget.f,d:widget.d):Container(),
                widget.data.length>0? entrust(heyue_id: widget.data[index]["id"],key: entrustKey,b: widget.f,d:widget.d):Container(),
                widget.data.length>0? canceled(heyue_id: widget.data[index]["id"],key: canceledKey,b: widget.f,d:widget.d):Container(),

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
