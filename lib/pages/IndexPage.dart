import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/ChildItemView.dart';
import 'package:flutterapp2/pages/heyue/applyHeYue.dart';
import 'package:flutterapp2/pages/introduction.dart';
import 'package:flutterapp2/pages/rule.dart';
import 'package:flutterapp2/pages/searchStock.dart';
import 'package:flutterapp2/pages/trade/trade.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/NumUtil.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:flutterapp2/utils/Util.dart';
import 'package:flutterapp2/utils/request.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

import '../main.dart';
import 'Mine.dart';
import 'hangqing.dart';
import 'heyue.dart';
import 'news.dart';
import 'order/order.dart';
class IndexPage extends StatefulWidget {
  Function fun;
  IndexPage({this.fun});
  @override
  _IndexPage createState() => _IndexPage();
}

class _IndexPage extends State<IndexPage>{
  String gonggao = "";
  void initState() {
    // TODO: implement initState
    super.initState();
    getDaPanData();
    controller = new PageController(initialPage: this.page);
    bool is_trade = Util().checkStockTradeTime();
    getRankList();
    getConfig();
    if(is_trade){
      timer_ = Timer.periodic(Duration(seconds: 5), (t){
        try{
          getDaPanData();
        }catch(Exception){
        }
      });
    }
  }
  getConfig()async{
    ResultData res = await HttpManager.getInstance().get("getConfig",withLoading: false);
    List s = res.data;
    setState(() {
      s.forEach((element) {

        if(element["en_name"] == "gonggao"){
          setState(() {
            gonggao = element["value"];
          });
        }

      });
    });
  }
  @override
  void dispose() {
    if(timer_ != null){
      timer_.cancel();
    }
    super.dispose();
  }
  final SystemUiOverlayStyle _style =SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  List img_url = [
    "img/nav1.png",
    "img/nav3.png",
    "img/nav4.png"
  ];
  List texts = [
    {"name": "上证指数", "value": "","rate":"","color":Colors.black},
    {"name": "深圳成指", "value": "","rate":"","color":Colors.black},
    {"name": "创业板指", "value": "","rate":"","color":Colors.black}
  ];
  double appBarAlpha = 0;
  Timer timer_;
  int page = 0;
  List list = [];
  PageController controller;
  getRankList()async{
   ResultData data = await HttpManager.getInstance().get("frontend/getRankList",withLoading: false,no_header: false);
    setState(() {
     list = data.data;
   });
  }
  Future<void> onTap(int index) async {
    if(page != index){
      controller.jumpToPage(index);
    }
  }
  Future getDaPanData() async {
    try {
      ResultData res =await HttpManager.getInstance().get("stock/getDaPanData",withLoading: false);
     Map d =  json.decode(res.data["data"]);

      List list = d["showapi_res_body"]["indexList"];
      int i = 0;
      list.forEach((element) {
        setState(() {
          if (double.parse(element["diff_rate"]) > 0.00) {
            texts[i]["color"] = Color(0xffE63A3C);
            texts[i]["rate"] = "+" + element["diff_rate"] + "%";

          } else {
            texts[i]["color"] = Color(0xff09B971);
            texts[i]["rate"] = element["diff_rate"] + "%";

          }
          texts[i]["value"] = element["nowPrice"];
        });
        if (i > 2) {
          return;
        }
        i++;
      });
    } catch (e) {
      print(e);
    }
  }
  getTableList(){

    List<TableRow> d = [];
  d.add(TableRow(
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

//        Text(
//          '盈利额',
//          style: TextStyle(
//              color: Color(0xff959ca7),
//              fontWeight: FontWeight.w100),
//        ),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Text(
            '盈利率',
            style: TextStyle(
                color: Color(0xff959ca7),
                fontWeight: FontWeight.w100),
          ),
        ),
      ]));
    if(list != null)
    list.forEach((element) {
      Color cur_color = Colors.black;
     double rate = element["profit_rate"];
     rate = NumUtil.getNumByValueDouble(rate, 2);
     rate = rate * 100;
     if(rate >0){
       cur_color = Colors.red;
     }else if(rate < 0){
       cur_color = Colors.green;
     }
      d.add(TableRow(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  element["member"]["username"].toString().replaceRange(3, 7, "*"*4),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Padding(child: Text(element["heyue"]["name"].toString()+element["leverage"]["name"].toStringAsFixed(0)+"倍",
                    style: TextStyle(

                      color: Color(0xff959ca7),
                    )),padding: EdgeInsets.only(bottom: 10),)
              ],
            ),
//            Container(
//              margin: EdgeInsets.only(top: 10),
//              child: Text(NumUtil.getNumByValueDouble(element["profit_"], 2).toString(),
//                  style: TextStyle(
//                      fontWeight: FontWeight.bold,
//                      fontSize: 18)),
//            ),
            Container(
              margin: EdgeInsets.only(top: 10,left: 30),
              child: Text(NumUtil.getNumByValueDouble(rate, 2).toString()+"%",
                  style: TextStyle(
                      color: cur_color,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
          ]));
    });
    return d;
  }
  int flag = 1;
  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomNavItems = [
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.home,color: Colors.blueAccent),
        backgroundColor: Colors.black,
        icon: Icon(Icons.home),
        title: Text("首页"),
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(const IconData(0xe66c, fontFamily: 'iconfont'),color: Colors.blueAccent),
        backgroundColor: Colors.black,
        icon: Icon(const IconData(0xe66c, fontFamily: 'iconfont')),
        title: Text("行情"),
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(const IconData(0xe60d, fontFamily: 'iconfont'),color: Colors.blueAccent,),
        backgroundColor: Colors.black,
        icon: Icon(const IconData(0xe60d, fontFamily: 'iconfont')),
        title: Text("合约"),
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.person,color: Colors.blueAccent,),
        backgroundColor: Colors.black,
        icon: Icon(Icons.person),
        title: Text("我的"),
      ),
    ];
    SystemChrome.setSystemUIOverlayStyle(_style);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(


            selectedFontSize:12.0,           //选中时的大小
            unselectedFontSize:12.0,      //未选中时的大小
            type: BottomNavigationBarType.fixed,  //固定导航栏颜色
            items: bottomNavItems,
            onTap: onTap,
            currentIndex: page
        ),
      body: PageView(
        children: <Widget>[
          FlutterEasyLoading(
            child: Stack(
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
                                    return Image.asset(img_url[index],fit: BoxFit.fill,);
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
                                      GestureDetector(
                                        onTap: (){
                                          JumpAnimation().jump(news(), context);
                                        },
                                        child: Container(
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
                                                  "7x24快讯",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          JumpAnimation().jump(trade("null"), context);
                                          return;
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

                                      GestureDetector(
                                        onTap: (){
                                          controller.jumpToPage(1);
                                        },
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Image.asset(
                                                  "img/4.png",
                                                  width: 45,
                                                ),
                                              ),
                                              Container(
                                                child: Text("行情",
                                                    style: TextStyle(fontSize: 12)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: (){
                                          JumpAnimation().jump(rule(), context);
                                        },
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Image.asset(
                                                  "img/6.png",
                                                  width: 45,
                                                ),
                                              ),
                                              Container(
                                                child: Text("交易规则",
                                                    style: TextStyle(fontSize: 12)),
                                              ),
                                            ],
                                          ),
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

                              Row(

                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 3,right: 3),
                                    child: Text("公告:"),
                                  ),
                                  Container(
                                    width: 318,
                                    height:30,
                                    child: new MarqueeWidget(
                                      text: gonggao,
                                      textStyle: new TextStyle(fontSize: 15.0),
                                      scrollAxis: Axis.horizontal,
                                    ),
                                  ),
                                ],
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
                                  children: getTableList(),
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
                  top: 37,
                  left: 15,
                  child: Center(
                      child: Wrap(
                        spacing: 40,
                        children: <Widget>[
                          Container(
                            width: 120,
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
                                        child: Text(texts[index]["value"]+" "+texts[index]["rate"],
                                            style: TextStyle(color: texts[index]["color"])),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(right: 10),
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
          ),
          hangqing(index: 0),
          heyue(),
          Mine()
        ],
        controller: controller,
        onPageChanged: onPageChanged,
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
