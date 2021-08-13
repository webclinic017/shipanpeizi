import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/Login.dart';
import 'package:flutterapp2/pages/agree.dart';
import 'package:flutterapp2/pages/editCard.dart';
import 'package:flutterapp2/pages/editPassword.dart';
import 'package:flutterapp2/pages/recharge.dart';
import 'package:flutterapp2/pages/share.dart';
import 'package:flutterapp2/pages/stock.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/pages/withdraw.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:package_info/package_info.dart';
import 'fund/fund.dart';
import 'heyue.dart';
import 'package:url_launcher/url_launcher.dart';
class Mine extends StatefulWidget {
  String _title;
  @override
  _Mine createState() => _Mine();
}

class _Mine extends State<Mine>{
  final SystemUiOverlayStyle _style =SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  String version = "";
  Map user_info = new Map();
  Map user_message_cate = {
    "account": "0",
    "validContract": "0",
    "deposit": "0"
  };
  String kefu = '';
  Map lang = {"account": "余额", "validContract": "有效合约", "deposit": "保证金"};
  List list_cate = [{"name":"实名与银行卡","url":new editCard()}, {"name":"修改密码","url":new editPassword()}, {"name":"用户协议","url":new agree()}, {"name":"退出登录","url":new stock("333")}];
  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }
  @override
  void initState() {

    super.initState();
    user_info["img"] = "img/logo.png";
    user_info["userName"] = "";
    getMemberInfo();
    getConfig();
    getVersion();
  }
  getConfig()async{
    ResultData res = await HttpManager.getInstance().get("getConfig",withLoading: false);
    List s = res.data;
    setState(() {
      s.forEach((element) {

        if(element["en_name"] == "kefu"){
          setState(() {
            kefu = element["value"];
          });
        }

      });
    });
  }
  getMemberInfo()async{
   ResultData data = await HttpManager.getInstance().get("member/getMemberInfo",withLoading: false);

    Map a = data.data;
   setState(() {
     user_message_cate["account"] = a["amount"].toString();
     user_message_cate["validContract"] = a["count"].toString();
     user_message_cate["deposit"] = a["deposit"].toString();
     user_info["userName"] = a["nickname"];
   });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(_style);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: Text(
          "我的",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            alignment:Alignment.bottomLeft,
            icon: Icon(
             const IconData(0xe61c, fontFamily: 'iconfont'),
              color: Colors.black,
            ),
            tooltip: "Alarm",
            onPressed: () {
              launch("tel://$kefu");
            },
          ),
//          IconButton(
//            icon: Icon(
//              IconData(0xe615, fontFamily: 'iconfont'),
//              color: Colors.black,
//            ),
//            tooltip: "Home",
//            onPressed: () {
//              print("Home");
//            },
//          ),
        ],
      ),
      body: MediaQuery.removePadding(context: context,
        removeTop: true,
        child:
      ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        user_info['img'],
                        fit: BoxFit.fill,
                        width: 60,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin:EdgeInsets.only(bottom: 5),
                            child: Text(
                              user_info["userName"],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                "img/member_back.png",
                                width: 70,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                left: 30,
                                top: 6,
                                child: Text(
                                  "VIP1",
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Image.asset(
                  "img/arrow.png",
                  width: 7,
                  color: Colors.black,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child:
            Wrap(alignment: WrapAlignment.spaceAround, children: getRow()),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(bottom: 15, top: 15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        JumpAnimation().jump(recharge(), context);
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "img/recharge.png",
                            width: 50,
                          ),
                          Text("充值")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>JumpAnimation().jump(withdraw(), context),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "img/withdraw.png",
                            width: 50,
                          ),
                          Text("提现")
                        ],
                      ),
                    ), //launch("tel://$kefu");
                    GestureDetector(
                      onTap: (){
                        launch("tel://$kefu");
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "img/daili.png",
                            width: 50,
                          ),
                          Text("客服")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        JumpAnimation().jump(fund(), context);
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "img/detail.png",
                            width: 50,
                          ),
                          Text("资金明细")
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              //JumpAnimation().jump(share(), context);
            },
            child: Container(
              padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
              child: Image.asset(
                "img/fanyong.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(

            child: Column(children: getCate()),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
           alignment: Alignment.center,
            child: Wrap(

              spacing: 11,
              crossAxisAlignment:WrapCrossAlignment.center,
              children: <Widget>[
                Text("当前版本:",style: TextStyle(color: Colors.grey,fontSize: 12),),
                Text("v"+version,style: TextStyle(color: Colors.grey,fontSize: 12)),

              ],
            ),
          ),
          Container(
            height: 100,
          )
        ],
      ),
      )
    );
  }

  List getRow() {
    return user_message_cate.keys.map((e) {
      return Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: <Widget>[
          Text(user_message_cate[e],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          Text(lang[e]),
        ],
      );
    }).toList();
  }

  List getCate() {
    return list_cate.asMap().keys.map((e) {
      if(e == list_cate.length -1){
        return Column(
          children: <Widget>[
            InkWell(
              splashColor: Colors.black26,
              onTap:() async{

                TokenStore().setToken("is_login","0");
                TokenStore().setToken("token", "");

               JumpAnimation().jump(Login(), context);
              },
              child:  Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(list_cate[e]["name"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    Image.asset(
                      "img/arrow.png",
                      width: 7,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),

            Container(

              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xFFDCDCDC), width: 0.2))),
            )
          ],
        );
      }else{
        return Column(
          children: <Widget>[
            InkWell(
              splashColor: Colors.black26,
              onTap:() {
                JumpAnimation().jump(list_cate[e]['url'], context);
              },
              child:  Container(

                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(list_cate[e]["name"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    Image.asset(
                      "img/arrow.png",
                      width: 7,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),

            Container(

              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xFFDCDCDC), width: 0.2))),
            )
          ],
        );
      }

    }).toList();
  }
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child, // child is the value returned by pageBuilder
    );
  }
}
