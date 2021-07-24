import 'package:flutter_easyloading/flutter_easyloading.dart';

bool loadingStatus = false;

class LoadingUtils {

  static show(String msg) {
    EasyLoading.show();
  }

  static dismiss() {
    EasyLoading.dismiss();
  }

  static error() {
    EasyLoading.showError("网络请求错误");
  }
}