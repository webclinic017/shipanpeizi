import 'dart:convert';

import 'package:http/http.dart' as http;
class request{
  //String url = "http://192.168.1.4:86";
  String url = "http://8.134.69.19:81";
  request();
  Future<String>  getIPAddress(String period,String stock_code) async {
   String usrls;
    if(period == "1"){
      usrls = url+'/stock/getTimeSharingData/'+stock_code;
    }else{
      usrls = url+'/stock/getKdata/'+period+"/"+stock_code;
    }

    String result;
    var response = await http.get(usrls).timeout(Duration(seconds: 7));

    if (response.statusCode == 200) {
      result = Utf8Decoder().convert(response.bodyBytes);
    } else {
      return Future.error("获取失败");
    }
    return result;
  }
  Future getDaPanData() {
    var result = send_get('/stock/getDaPanData');
    return result;
  }
  Future<String> send_get(String url_) async{
    String result;
    var response = await http.get(url+url_).timeout(Duration(seconds: 7));
    if (response.statusCode == 200) {
      result = Utf8Decoder().convert(response.bodyBytes);
    } else {
      return Future.error("获取失败");
    }
    return result;
  }
}