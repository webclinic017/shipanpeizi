import 'dart:async';
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
import 'Login.dart';

class forgetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<forgetPassword> {
  String phone;
  String password;
  String re_pwd;
  String validate_code;
  String key = "";
  String buttonText = "获取验证码";
  bool enabled = true;

  Timer _timer;
  int _timeCount = 60;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKey();
  }
  getKey() async {

  }
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
          title: Text("忘记密码",style: TextStyle(fontSize: ScreenUtil().setSp(18),color: Colors.black),),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 25, right: 5),

                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(

                          onChanged: (e) {
                            setState(() {
                              phone = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                  '${this.phone == null ? "" : this.phone}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.phone}'.length)))),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),

                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "请输入手机号",


                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 25, right: 5),

                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[

                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (e) {
                                setState(() {
                                  validate_code = e;
                                });
                              },
                              controller: TextEditingController.fromValue(
                                  TextEditingValue(
                                      text:
                                      '${this.validate_code == null ? "" : this.validate_code}',
                                      selection: TextSelection.fromPosition(
                                          TextPosition(
                                              affinity: TextAffinity.downstream,
                                              offset: '${this.validate_code}'.length)))),
                              decoration: InputDecoration(

                                hintText: "请输入验证码",
                                hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 10),

                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        height: ScreenUtil().setHeight(50),
                        top: 0,
                        right: 0,
                        child: MaterialButton(

                          disabledColor: Colors.grey,
                          color: Colors.orange,
                          onPressed: enabled ? ontap : null,
                          splashColor: Colors.grey,
                          child: Text(buttonText,style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ),
                Container(

                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 25, right: 5),

                  child: Row(

                    children: <Widget>[

                      Expanded(
                        child: TextField(
                          obscureText: true,
                          onChanged: (e) {
                            setState(() {
                              password = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                  '${this.password == null ? "" : this.password}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.password}'.length)))),
                          decoration: InputDecoration(

                            hintText: "请输入新密码",

                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),

                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),

                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 25, right: 5),
              child: GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () async {
                    if(!checkExist(validate_code) || !checkExist(password)){
                      Toast.toast(context,msg: "请输入完整信息");
                      return;
                    }
                    if(!isChinaPhoneLegal(phone)){
                      Toast.toast(context,msg: "请输入正确手机号");
                      return;
                    }


                    ResultData result = await HttpManager.getInstance().post(
                        "member/register/forget_password",
                        params: {"phone": phone.toString(),"captcha":validate_code.toString(),"password":password.toString()},
                        withLoading: true);
                    print(result.data);
                    if (result.code == 200) {
                      Toast.toast(context, msg: "修改成功");
                      JumpAnimation().jump(Login(), context);
                    } else {
                      Toast.toast(context, msg: result.msg);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    decoration:
                        BoxDecoration(color: Colors.yellow, boxShadow: []),
                    child: Text(
                      "确认",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  static bool checkExist(value) {
    if (value == null || value == "") {
      return false;
    }
    return true;
  }
  static bool isChinaPhoneLegal(String str) {
    return true;
  }
  void ontap() async{
    if(!checkExist(phone)){
      Toast.toast(context,msg: "请输入手机号");
      return ;
    }
    if(!isChinaPhoneLegal(phone) ){
      Toast.toast(context,msg: "请输入正确手机号");
      return;
    }

    ResultData res_ = await HttpManager.getInstance().get("member/register/senCode",params: {"phone":phone});

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
}
