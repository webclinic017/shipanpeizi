import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/pages/ChildItemView.dart';
import 'package:flutterapp2/pages/Login.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import '../main.dart';
import 'ResultData.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  BuildContext context;
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    try {

      if (option.contentType != null && option.contentType.contains("text")) {
        return new ResultData(response.data["data"], true,200, response.data["msg"]);
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {


        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
        int code = response.data["code"];

        if (code == 200) {
          return ResultData(response.data["data"], true,code, response.data["msg"]);
        }else if(code == 506 || code == 501){

              TokenStore().setToken("is_login", "0");
              TokenStore().clearToken("token");
              Rute.navigatorKey.currentState.pushNamedAndRemoveUntil("/login",
              ModalRoute.withName("/"));

        } else {
          return new ResultData(response.data["data"], false,code, response.data["msg"]);
        }
      }
    } catch (e) {
      print(e.toString() + option.path);

      return new ResultData(response.data["data"], false, response.statusCode,response.data["msg"]
        );
    }

    return new ResultData(response.data["data"], false, response.statusCode,response.data["msg"]
     );
  }
}