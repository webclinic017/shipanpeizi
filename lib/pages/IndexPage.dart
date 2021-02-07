import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/pages/heyue/applyHeYue.dart';
import 'package:flutterapp2/pages/searchStock.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';

import 'order/order.dart';
class IndexPage extends StatefulWidget {
  @override
  _IndexPage createState() => _IndexPage();
}

class _IndexPage extends State<IndexPage> with AutomaticKeepAliveClientMixin{
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  final SystemUiOverlayStyle _style =SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  @override
  bool get wantKeepAlive => true;
  List img_url = [
    "https://peizi-2.oss-accelerate.aliyuncs.com/1588219664581image_2020_04_30T04_05_50_199Z.png?Expires=3788006400&OSSAccessKeyId=LTAI4Fi415FQnA2BE3JUnrwA&Signature=lkWJi7hJ6NMHje1KXt1qNQOaOe8%3D",
    "https://peizi-2.oss-accelerate.aliyuncs.com/15844081814292.png?Expires=3788006400&OSSAccessKeyId=LTAI4Fi415FQnA2BE3JUnrwA&Signature=ymMEuH%2F9rBiWlAPAnZTUT5BLQM8%3D",
    "https://peizi-2.oss-accelerate.aliyuncs.com/15844081821324.png?Expires=3788006400&OSSAccessKeyId=LTAI4Fi415FQnA2BE3JUnrwA&Signature=r6V02%2Bv%2FNY9RPwrLQPJMXeaPsN0%3D",
    "https://peizi-2.oss-accelerate.aliyuncs.com/15844081810541.png?Expires=3788006400&OSSAccessKeyId=LTAI4Fi415FQnA2BE3JUnrwA&Signature=EViy1v95ZTEAyPYSjdSJq3Jh3uA%3D"
  ];
  List texts = [
    {"name": "上证指数", "value": "2268.1 2.1%"},
    {"name": "深圳成指", "value": "5123.3 24.1%"}
  ];
  double appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(_style);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification sn) {
                  if (sn is ScrollNotification && sn.depth == 0) {
                    double alpha = sn.metrics.pixels / 100;
                    if (alpha < 0) {
                      alpha = 0;
                    } else if (alpha > 1) {
                      alpha = 1;
                    }
                    setState(() {
                      appBarAlpha = alpha;
                    });
                  }
                },
                child: Scaffold(
                  body: Center(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 240,
                          child: Swiper(
                            itemCount: img_url.length,
                            autoplay: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                img_url[index],
                                fit: BoxFit.fill,
                              );
                            },
                            pagination: SwiperPagination(
                                alignment: Alignment.bottomRight,
                                margin: EdgeInsets.only(right: 15),
                                builder: DotSwiperPaginationBuilder(
                                    color: Color.fromRGBO(200, 200, 200, 0.5),
                                    size: 8.0,
                                    activeSize: 10.0)),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 45,
                              runSpacing: 20,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "img/1.png",
                                          width: 45,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "自选股",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    JumpAnimation().jump(order(), context);
                                  },
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                            "img/2.png",
                                            width: 45,
                                          ),
                                        ),
                                        Container(
                                          child: Text("持仓",
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "img/3.png",
                                          width: 45,
                                        ),
                                      ),
                                      Container(
                                        child: Text("代理中心",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "img/4.png",
                                          width: 45,
                                        ),
                                      ),
                                      Container(
                                        child: Text("自选股",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "img/5.png",
                                          width: 45,
                                        ),
                                      ),
                                      Container(
                                        child: Text("充值返现",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "img/6.png",
                                          width: 45,
                                        ),
                                      ),
                                      Container(
                                        child: Text("自选股",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "img/7.png",
                                          width: 45,
                                        ),
                                      ),
                                      Container(
                                        child: Text("公司介绍",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "img/8.png",
                                          width: 45,
                                        ),
                                      ),
                                      Container(
                                        child: Text("在线客服",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              // 边框，
                              // border: Border.all(color: Colors.yellowAccent, style: BorderStyle.solid, width: 2),
                              // 背景图

                              // 边框圆角
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            JumpAnimation().jump(applyHeYue(), context);
                          },
                          child: Container(
                              child: Image.asset(
                                "img/heyue.png",
                                fit: BoxFit.fill,
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.all(7),
                          child: Text(
                            "昨日-收益榜",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),

                          child: Table(

                            columnWidths: const {
                              0: FixedColumnWidth(180.0),
                              1: FixedColumnWidth(80.0),
                              2: FixedColumnWidth(60.0),
                            },
                            children: [

                              TableRow(
                                  //第一行样式 添加背景色
                                  children: [
                                    //增加行高
                                    SizedBox(
                                      height: 30.0,
                                      child: Text(
                                        '用户|合约',
                                        style: TextStyle(
                                            color: Color(0xff959ca7),
                                            fontWeight: FontWeight.w100),
                                      ),
                                    ),

                                    Text(
                                      '盈利额(万)',
                                      style: TextStyle(
                                          color: Color(0xff959ca7),
                                          fontWeight: FontWeight.w100),
                                    ),
                                    Text(
                                      '盈利率',
                                      style: TextStyle(
                                          color: Color(0xff959ca7),
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ]),

                              TableRow(
                                  children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text(
                                      '138****2911',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Padding(child: Text('按天10倍',
                                        style: TextStyle(

                                          color: Color(0xff959ca7),
                                        )),padding: EdgeInsets.only(bottom: 10),)
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("79.21",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("9.33%",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ]),
                              TableRow(children: [
//
                                Wrap(
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text(
                                      '138****2911',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Padding(child: Text('按天10倍',
                                        style: TextStyle(

                                          color: Color(0xff959ca7),
                                        )),padding: EdgeInsets.only(bottom: 10),),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("79.21",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("9.33%",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ]),
                              TableRow(children: [
//                                    SizedBox(
//                                      height: 40.0,
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.values[0],
//                                        children: <Widget>[
//                                          Container(child: Text("138****1213"),),
//                                          Container(child: Text("按天10倍"),)
//                                        ],
//                                      ),
//                                    ),
                                Wrap(
                                  spacing: 5,
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text(
                                      '138****2911',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Padding(child: Text('按天10倍',
                                        style: TextStyle(

                                          color: Color(0xff959ca7),
                                        )),padding: EdgeInsets.only(bottom: 10),),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("79.21",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("9.33%",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ]),
                              TableRow(children: [
//                                    SizedBox(
//                                      height: 40.0,
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.values[0],
//                                        children: <Widget>[
//                                          Container(child: Text("138****1213"),),
//                                          Container(child: Text("按天10倍"),)
//                                        ],
//                                      ),
//                                    ),
                                Wrap(
                                  spacing: 5,
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text(
                                      '138****2911',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Padding(child: Text('按天10倍',
                                        style: TextStyle(

                                          color: Color(0xff959ca7),
                                        )),padding: EdgeInsets.only(bottom: 10),),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("79.21",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("9.33%",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Color(0xFF515151)),
            ),
          ),
          Positioned(
            top: 30,
            left: 15,
            child: Center(
                child: Wrap(
              spacing: 40,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 80,
                  child: Swiper(
                    itemCount: 2,
                    scrollDirection: Axis.vertical,
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Text(
                                texts[index]["name"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            Container(
                              child: Text(texts[index]["value"],
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 8),
                    width: 190,
                    height: 30,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.search,
                              color: Color.fromRGBO(255, 255, 255, 0.3),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              JumpAnimation().jump(searchStock(), context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "输入股票名称/代码",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.3)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        // 边框，
                        //border: Border.all(color: Colors.yellowAccent, style: BorderStyle.solid, width: 2),
                        // 背景图

                        // 边框圆角
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        // 子 weight
                      ),
                    )),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
