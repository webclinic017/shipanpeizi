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
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class pay extends StatefulWidget {
double money;
  pay(this.money);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<pay> {
  String bank_card="";
  String bank_user = "";
  String bank_branch ="";
  bool check = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConfig();
  }
  getConfig()async{
    ResultData res = await HttpManager.getInstance().get("getConfig",withLoading: false);
    List s = res.data;
    setState(() {
      s.forEach((element) {

       if(element["en_name"] == "bank_card"){
         setState(() {
           bank_card = element["value"];
         });
       }
        if(element["en_name"] == "bank_user"){
          setState(() {
            bank_user = element["value"];
          });
        }
        if(element["en_name"] == "bank_branch"){
          setState(() {
            bank_branch = element["value"];
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          elevation: 1,
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
            Container(
              margin: EdgeInsets.only(top: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Wrap(
                      direction: Axis.vertical,
                      spacing: 35,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: <Widget>[
                        Text("银行卡号:",style: TextStyle(fontSize: 17),),
                        Text("开户行:",style: TextStyle(fontSize: 17),),
                        Text("持卡人:",style: TextStyle(fontSize: 17),),
                        Text("支付金额:",style: TextStyle(fontSize: 17),),
                      ],
                    ),
                  ),
                  Container(
                    child: Wrap(
                      direction: Axis.vertical,
                      spacing: 35,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(bank_card,style: TextStyle(fontSize: 17),),
                            GestureDetector(
                              onTap: (){
                                Future res = Clipboard.setData(ClipboardData(text: bank_card));
                                res.whenComplete(() =>Toast.toast(context,msg: "复制成功"));
                              },
                              child: Container(

                                padding: EdgeInsets.only(left: 5),
                                child:Text("复制",style: TextStyle(color: Colors.blue),),

                              ),
                            ),
                          ],
                        ),
                        Text(bank_branch,style: TextStyle(fontSize: 17),),
                        Text(bank_user,style: TextStyle(fontSize: 17),),
                        Text(widget.money.toString()+"元",style: TextStyle(fontSize: 17),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 60),
              child: MaterialButton(
                minWidth: 200,
                color: Colors.yellow,
                onPressed: ()async{
                  ResultData res = await HttpManager.getInstance().post("recharge/dorecharge",params:{"amount":widget.money},withLoading: false);

                  Toast.toast(context,msg: "申请成功");
                  JumpAnimation().jump(new IndexPage(), context);

                },
                child: Text("提交支付申请",style: TextStyle(color: Colors.black),),
              ),
            )

          ],
        ),
      ),
    );
  }
}
