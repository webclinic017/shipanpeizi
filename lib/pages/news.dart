import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class news extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return news_();
  }
}
class news_ extends State<news>{
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
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        title: Text("新闻资讯",style: TextStyle(color:Colors.black,fontSize: ScreenUtil().setSp(18),),),
      ),
      body: Container(
          alignment: Alignment.center,
          child: WebView(
            initialUrl: Uri.dataFromString('<html><body><iframe frameborder="0" width="100%" height="2000" scrolling="no" src="https://www.jin10.com/example/jin10.com.html?fontSize=14px&theme=white"></iframe></body></html>', mimeType: 'text/html').toString(),
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }

}