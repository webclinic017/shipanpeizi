import 'package:flutter/material.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/pages/ChildItemView.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Login.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/pages/hangqing.dart';
import 'package:flutterapp2/pages/heyue.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';

class IndexPageBack extends StatefulWidget{
  IndexPageBack();
  @override
  BotomeMenumPageState createState() => BotomeMenumPageState();
}

class BotomeMenumPageState extends State<IndexPageBack>{
  PageController controller;
  BotomeMenumPageState();
  int page = 0;
  int flag = 1;
  GlobalKey<NavigatorState> navigatorKey;
  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
    controller = new PageController(initialPage: this.page);
  }
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  Future<void> onTap(int index) async {
    var is_login = await TokenStore().getToken("is_login");
    if((index == 2 && is_login == null) || (index == 2 && is_login == "0")){
      Rute.navigatorKey.currentState.pushNamedAndRemoveUntil("/login",
          ModalRoute.withName("/"));
      return;
    }

    if(page != index){
      controller.jumpToPage(index);
    }
  }
  bool is_self;
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    //底部导航栏显示的内容
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

    return MaterialApp( //注意这里
      navigatorKey: Rute.navigatorKey, //设置在这里
      routes:{
        "/login":(context) => Login(), //注册首页路由
        "/index":(context)=>IndexPage(),
        "/mine":(context)=>Mine()
      },
      theme: ThemeData(
        highlightColor: Color.fromRGBO(255,255,255,.05),   //点击高亮颜色
        splashColor: Color.fromRGBO(255,255,255,.05),    //水波纹样式
      ),
      title: '盈满资管',
      home: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            IndexPage(fun: (int pages){

              setState(() {
                this.page = pages;
                flag=2;
              });
              this.controller.jumpToPage(pages);
            },),
            hangqing(page:this.flag,index: 1),
            heyue(),
            Mine()
          ],
          controller: controller,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(


            selectedFontSize:12.0,           //选中时的大小
            unselectedFontSize:12.0,      //未选中时的大小
            type: BottomNavigationBarType.fixed,  //固定导航栏颜色
            items: bottomNavItems,
            onTap: onTap,
            currentIndex: page
        ),
      ),
    );

  }
  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }


}