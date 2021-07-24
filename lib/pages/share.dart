import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/utils/Toast.dart';

class share extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return share_();
  }
}
class share_ extends State<share>{
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
    // TODO: implement build
    return Scaffold(


      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(ScreenUtil().setHeight(45)),
        child: AppBar(

          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 20.0,
            color: Colors.black, //修改颜色
          ),
          backgroundColor: Colors.white,
          title: Text("邀请赢好礼",style: TextStyle(color:Colors.black,fontSize: ScreenUtil().setSp(18),),),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset("img/poster.png",fit: BoxFit.fill,width: ScreenUtil().setWidth(312),height: ScreenUtil().setHeight(533),),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  color: Colors.yellow,
                  splashColor: Colors.grey,
                  onPressed: (){},
                  child: Text("分享海报邀请"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: MaterialButton(
                    color: Colors.yellow,
                    splashColor: Colors.grey,
                    onPressed: (){
                      Toast.toast(context,msg: "已复制到剪切板");
                    },
                    child: Text("复制邀请链接"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}