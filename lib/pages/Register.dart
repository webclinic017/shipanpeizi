import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Login.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'agree.dart';
class Register extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Register_();
  }
}

class Register_ extends State<Register>{
  static TextEditingController _controller = TextEditingController();
  String phone;
  String password;
  String verify_code;
  FocusNode _commentFocus;
  String buttonText = "获取验证码";
  bool enabled = true;
  int _timeCount = 60;
  Timer _timer;
  String invite_code;
  String nickname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = "";
    _commentFocus = FocusNode();
  }
  static bool checkExist(value) {
    if (value == null || value == "") {
      return false;
    }
    return true;
  }
  void sendsms() async{
    if(!checkExist(phone)){
      Toast.toast(context,msg: "请输入手机号");
      return ;
    }

    ResultData res_ = await HttpManager.getInstance().get("member/register/senCode",params: {"phone":phone},withLoading: false,no_header: false);

    if(res_.code == 200){
      Toast.toast(context,msg: "发送成功");
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) => {
        setState(() {
          if(_timeCount <= 0){
            setState(() {
              enabled = true;
            });
            buttonText = '重新获取';
            _timer.cancel();
            _timeCount = 60;
          }else {
            setState(() {
              enabled = false;
            });
            _timeCount -= 1;
            buttonText = "$_timeCount" + 's';
          }
        })
      });
    }else{
      Toast.toast(context,msg: res_.msg);
    }
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
                  margin: EdgeInsets.only(left: 5),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 5),
                  child: Text("注册",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 25,right: 35),
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
                            hintText: "输入账号/手机号",
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 15,right: 35),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5,color: Color(0xffadadad)))),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.person,color: Color(0xffadadad),),
                      Expanded(
                        child: TextField(

                          onChanged:(e){
                            setState(() {
                              nickname = e;
                            });
                          },
                          controller:  _controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "输入昵称",
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 15,right: 35),
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

               Stack(
                 children: <Widget>[
                   Container(
                     margin: EdgeInsets.only(left: 35,top: 15,right: 35),
                     decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5,color: Color(0xffadadad)))),
                     child: Row(
                       children: <Widget>[
                         Icon(Icons.comment,color: Color(0xffadadad),),
                         Expanded(
                           child: TextField(

                             onChanged:(e){
                               setState(() {
                                 verify_code = e;
                               });
                             },
                             controller: TextEditingController
                                 .fromValue(TextEditingValue(
                                 text:
                                 '${this.verify_code == null ? "" : this.verify_code}',
                                 selection:
                                 TextSelection.fromPosition(
                                     TextPosition(
                                         affinity:
                                         TextAffinity
                                             .downstream,
                                         offset:
                                         '${this.verify_code}'
                                             .length)))),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: 10),
                               hintText: "输入验证码",
                               border: InputBorder.none,
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                   Positioned(
                     height: 55,
                     bottom: 0,
                     right: 30,
                     child: MaterialButton(

                       onPressed: enabled ? sendsms : null,
                       splashColor: Colors.grey,
                       child: Text(buttonText,style: TextStyle(color: Colors.yellow,fontSize: 17),),
                     ),
                   )
                 ],
               ),
                Container(
                  margin: EdgeInsets.only(left: 35,top: 15,right: 35),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5,color: Color(0xffadadad)))),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.code,color: Color(0xffadadad),),
                      Expanded(
                        child: TextField(
                          onChanged:(e){
                            setState(() {
                              invite_code = e;
                            });
                          },
                          controller: TextEditingController
                              .fromValue(TextEditingValue(
                              text:
                              '${this.invite_code == null ? "" : this.invite_code}',
                              selection:
                              TextSelection.fromPosition(
                                  TextPosition(
                                      affinity:
                                      TextAffinity
                                          .downstream,
                                      offset:
                                      '${this.invite_code}'
                                          .length)))),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "输入邀请码",
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
               Container(
                  margin: EdgeInsets.only(left: 35,top: 25,right: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          JumpAnimation().jump(agree(), context);
                        },
                        child: Text("注册代表您同意《协议》",style: TextStyle(color: Colors.blueAccent),),

                      ),

                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 35,top: 35,right: 35),
              child: GestureDetector(
                onTap: () async {
                  if(!checkExist(nickname) || !checkExist(phone) || !checkExist(password) || !checkExist(invite_code) || !checkExist(verify_code)){
                         Toast.toast(context,msg: "请输入完整信息");
                         return;
                  }
                  ResultData result = await HttpManager.getInstance().post("member/register",params: {"nickname":nickname,"username":phone,"password":password,"invite_code":invite_code,"verify_code":verify_code},withLoading: true,no_header: false);
                  if(result.code == 200){
                    Toast.toast(context,msg: "注册成功");
                    JumpAnimation().jump(Login(), context);
                    //成功
                  }else{
                    Toast.toast(context,msg: result.msg);
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
                  child: Text("注册",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}