import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/pages/pay.dart';

import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';



class recharge extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<recharge> {
  String old_pwd;
  String new_pwd;
  String re_pwd;

  bool check = false;
  double give_money =0;
  FocusNode _commentFocus;
  bool is_show = true;
  int yj ;
  int pay_type = 1;
  double rate = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    getrate();
  }

//  getrate() async{
//    ResultData result = await HttpManager.getInstance().get("getrate",withLoading: false);
//    setState(() {
//      rate = double.parse(result.data["data"])/100;
//
//    });
//  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.black, //修改颜色
          ),
          backgroundColor: Colors.white,
          title: Text("充值",style: TextStyle(fontSize: ScreenUtil().setSp(18),color: Colors.black),),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("选择支付方式"),
                      ),
                      Container(
                        color: Colors.white,
                        child: Wrap(
                          direction: Axis.vertical,
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(399),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset("img/yl.jpg",fit: BoxFit.fill,width: ScreenUtil().setWidth(70),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("银联支付"),
                                          Text("网银支付,安全快捷",style: TextStyle(color: Colors.grey),),
                                        ],
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value:1,
                                    groupValue:this.pay_type,
                                    onChanged:(v){
                                      setState(() {
                                        this.pay_type = v;
                                      });
                                    },
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("请输入充值金额(元)"),
                      ),
                      Expanded(
                        child: TextField(
                          //限制2长度],//只允许输入数字
                          onChanged: (e) {

                            setState(() {
                              is_show = true;
                              yj = int.parse(e);
                              int w = DateTime.now().weekday;

                              give_money = yj*rate;
                            });

                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                  '${this.yj == null ? "" : this.yj}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity:
                                          TextAffinity.downstream,
                                          offset: '${this.yj}'.length)))),
                          keyboardType: TextInputType.number,
                          //键盘类型，数字键盘

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "",
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(0))),
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  ),
                ),
//                Container(
//                  padding: EdgeInsets.only(left: 10,top: 10),
//                  child: Text("赠送金额:"+give_money.toStringAsFixed(2)+"元",style: TextStyle(color: Colors.red),),
//                ),
                Container(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    disabledColor: Colors.grey,
                    minWidth: ScreenUtil().setWidth(390),
                    color: Colors.yellow,
                    onPressed: is_show?() async {


                      if(yj != null){
                        if(yj<1){
                          Toast.toast(context,msg: "请输入正确金额");
                          return;
                        }

                      }else{
                        Toast.toast(context,msg: "请输入正确金额");
                        return;
                      }

//                      setState(() {
//                        is_show = false;
//                      });

//                      ResultData res = await HttpManager.getInstance().post("recharge/wechat",params: {"price":yj,"type":pay_type,"from":"weixinh5"},withLoading: false);
//
//                      Map data = jsonDecode(res.data["data"]);
//                      int type_ = data["type"];

                      JumpAnimation().jump(pay(yj.toDouble()), context);

//                      if(data["code"] == 200){
//                        if(type_ == 1){
//                          Future s=   tobias.aliPay(data['url']) ;
//                        }else{
//                          JumpAnimation().jump(pay(data["data"]), context);
//                        }
//
//                      }else{
//                        sleep(Duration(seconds: 1));
//                        Toast.toast(context,msg: data["data"],showTime: 2000);
//                      }
                    }:null,
                    child: Text("立即充值",style: TextStyle(color: Colors.black),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("提示:充值无手续费，最低充值1元"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  alignment: Alignment.center,
                  child: Text("预存款须知",style: TextStyle(color: Colors.orangeAccent),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,bottom: 10),
                  child: Text("1、为了尽可能防范套现和洗钱，充值金额100%须用于消费。",style: TextStyle(fontSize: 12),),
                ),


                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("3、转账时请务必填写正确的金额，存款才能秒到。",style: TextStyle(fontSize: 12),),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }
}
