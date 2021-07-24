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
void main() {
  runApp( new BotomeMenumPage());
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
class BotomeMenumPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
      navigatorKey: Rute.navigatorKey,
      routes: {
        '/': (BuildContext context) => new IndexPage(),
        '/login': (BuildContext context) => new Login(),
      },
        title: 'Flutter Demo',
        theme: new ThemeData(
        primarySwatch: Colors.blue,


    ),
    );

  }

}



