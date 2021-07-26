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
import 'package:flutterapp2/pages/indexPageBack.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Register.dart';
import 'forgetPassword.dart';

class Login extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<Login>{

  String phone;
  String password;
  FocusNode _commentFocus;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();

  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5,top: 25),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 25),
                  child: Text("登录",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 55,right: 35),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5,color: Color(0xffadadad)))),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.mobile_screen_share,color: Color(0xffadadad),),
                      Expanded(
                        child: TextField(
                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(11)],//限制长度],//只允许输入数字

                          onChanged:(e){
                            setState(() {
                              phone = e;
                            });
                          },
                          controller: TextEditingController
                              .fromValue(TextEditingValue(
                              text:
                              '${this.phone == null ? "" : this.phone}',
                              selection:
                              TextSelection.fromPosition(
                                  TextPosition(
                                      affinity:
                                      TextAffinity
                                          .downstream,
                                      offset:
                                      '${this.phone}'
                                          .length)))),
                          keyboardType: TextInputType.number,//键盘类型，数字键盘

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "输入账号",
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 25,right: 35),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5,color: Color(0xffadadad)))),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.lock,color: Color(0xffadadad),),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          onChanged:(e){
                            setState(() {
                              password = e;
                            });
                          },
                          controller: TextEditingController
                              .fromValue(TextEditingValue(
                              text:
                              '${this.password == null ? "" : this.password}',
                              selection:
                              TextSelection.fromPosition(
                                  TextPosition(
                                      affinity:
                                      TextAffinity
                                          .downstream,
                                      offset:
                                      '${this.password}'
                                          .length)))),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "输入密码",
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 55,right: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          JumpAnimation().jump(Register(), context);
                        },
                        child: Text("账号注册"),

                      ),
                      GestureDetector(
                        onTap: (){
                          JumpAnimation().jump(forgetPassword(), context);
                        },
                        child: Text("忘记密码"),

                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 35,top: 55,right: 35),

              child: GestureDetector(
                onTap: (){

                },
                child: GestureDetector(
                  onTap: () async {
                    if(phone == null || password == null){
                      Toast.toast(context,msg: "请输入完整信息");
                      return;
                    }
                    ResultData result = await HttpManager.getInstance().post(Address.BASE_URL+"login",params: {"username":phone,"password":password},withLoading: true,no_header: false);
                    if(result.code == 200){
                      String token = result.data;

                      TokenStore().setToken("token",token);
                      TokenStore().setToken("is_login","1");
                      JumpAnimation().jump(IndexPage(), context);
                      //成功git
                    }else if(result.code == 407){
                      Toast.toast(context,msg: "账户已被禁用");
                    }else if(result.code == 406){
                      Toast.toast(context,msg: "用户名或密码错误");
                    }

                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 8,bottom: 8),
                    decoration: BoxDecoration(color: Color(0xffffe100),boxShadow:[
                      BoxShadow(
                        offset: Offset(3.0, 3.0),
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],borderRadius: BorderRadius.circular(45)),
                    child: Text("登录",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}