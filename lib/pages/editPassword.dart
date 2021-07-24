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

import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class editPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<editPassword> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
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
          title: Text("修改密码",style: TextStyle(color:Colors.black,fontSize: ScreenUtil().setSp(18),),),
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
                          obscureText: true,
                          onChanged: (e) {
                            setState(() {
                              old_pwd = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                  '${this.old_pwd == null ? "" : this.old_pwd}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.old_pwd}'.length)))),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),

                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "请输入旧密码",


                          ),
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
                              new_pwd = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                      '${this.new_pwd == null ? "" : this.new_pwd}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.new_pwd}'.length)))),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            hintText: "请输入新密码",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                          ),
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
                              re_pwd = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                  '${this.re_pwd == null ? "" : this.re_pwd}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.re_pwd}'.length)))),
                          decoration: InputDecoration(

                            hintText: "再次输入新密码",

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
                    if (old_pwd == null || new_pwd == null || re_pwd == null) {
                      Toast.toast(context, msg: "请输入完整信息!");
                      return;
                    }
                    if(new_pwd != re_pwd){
                      Toast.toast(context, msg: "两次输入密码不一致!");
                    }

                    ResultData result = await HttpManager.getInstance().post(
                        "member/updatePassword",
                        params: {"password": new_pwd,"old_pwd":old_pwd},
                        withLoading: true);

                    if (result.code == 200) {
                      Toast.toast(context, msg: "修改成功");
                      setState(() {
                        new_pwd = "";
                        old_pwd = "";
                        re_pwd = "";
                      });
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
                          ),
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
}
