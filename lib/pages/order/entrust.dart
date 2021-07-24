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
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/NumUtil.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
final GlobalKey<_entrust> entrustKey = GlobalKey();
class entrust extends StatefulWidget{


  Function b;
  Function d;


  entrust({
    Key key,
    this.heyue_id,
    this.b,
    this.d,
  }) : super(key: key);
  int heyue_id;
  bool is_out = false;

  @override
  _entrust createState() => _entrust();
}
class _entrust extends State<entrust>{
  Color rase_color = Colors.red;
  Color down_color = Colors.blue;
  List order_list = [];
  WebSocketChannel channel;
  Future f;
  Timer timer_;
  int page = 1;
  bool flag = true;
  BuildContext c;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    f = getOrderList(widget.heyue_id);
    f.whenComplete(() => null);
  }

  getOrderList (i)async{
    ResultData result = await HttpManager.getInstance().get("frontend/order/findOrderByCase",params:{"stock_status":1,"heyue_id":i,"page":page.toString(),"sort":"-id","limit":"5","cancel_status":0},withLoading: false);
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
                  width: ScreenUtil().setWidth(160),
                  child: Text("名称"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(55),
                  child: Text("数量"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(55),
                  child: Text("委托价"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(55),
                  child: Text("方向"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(55),
                  child: Text("操作"),
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
String di;

      if(order_list[e]["trade_direction"] == 1){
        di = '买';
        cur_color = rase_color;
      }else {
        di = '卖';
        cur_color = down_color;
      }
      return Column(
        children: <Widget>[
          Container(


            child:  Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: ScreenUtil().setWidth(160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(order_list[e]["stock_name"],style: TextStyle(color: cur_color),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(

                            padding: EdgeInsets.only(left: 5,right: 5),
                            color: Color(0xffffe5ee),
                            child: Text(di,style: TextStyle(color: Colors.black,fontSize: 11),),
                          ),
                          Text(order_list[e]["make_order_date"],style: TextStyle(color: cur_color,fontSize: 11),)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(order_list[e]["buy_hand"].toString(),style: TextStyle(color: cur_color),),
                      //Text(NumUtil.getNumByValueDouble(NumUtil.multiply(order_list[e]["profit_rate"], 100), 3).toString()+"%" ,style: TextStyle(color: cur_color)),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(order_list[e]["buy_price"].toString(),style: TextStyle(color: cur_color),),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(di,style: TextStyle(color: cur_color),),
                    ],
                  ),
                ),
                Container(

                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(55),
                  child: Ink(
                    color: Colors.blueAccent,
                    child: flag == true? InkWell(

                      onTap: ()async{
                        setState(() {
                          flag = false;
                        });
                        ResultData res = await HttpManager.getInstance().post("frontend/order/apply_cancel",params: {"id":order_list[e]['id']},withLoading: true);
                        if(res.code != 200){
                          Toast.toast(this.c,msg: res.msg);
                          setState(() {
                            flag = true;
                          });
                          return;
                        }else{
                          Toast.toast(this.c,msg: '操作成功');
                          getOrderList(widget.heyue_id);
                        };
                      },
                      splashColor: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                        child: Text("撤单",style: TextStyle(color: Colors.white),),
                      ),
                    ):null,
                  ),
                )
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