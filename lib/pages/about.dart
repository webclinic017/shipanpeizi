import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

class about extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return about_();
  }
}

class about_ extends State<about>{
  String version;

  @override
  void initState() {
    // TODO: implement initState
    PackageInfo packageInfo =  PackageInfo.fromPlatform() as PackageInfo;
    setState(() {
      version = packageInfo.version;
    });

  }
  @override
  Widget build(BuildContext context) {



    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          size: 25.0,
          color: Colors.white, //修改颜色
        ),
        backgroundColor: Color(0xfffa2020),
        title: Text("修改密码",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.asset("img/logo.png"),
          ),
          Container(
            child: Text(version),
          )

        ],
      ),
    );
  }

}