import 'DataHelper.dart';
import 'HttpManager.dart';
import 'Address.dart';

class Api {
  ///示例请求
  static request(String param) {
    var params = DataHelper.getBaseMap();
    params['param'] = param;
    return HttpManager.getInstance().get(Address.TEST_API, params: params);
  }
}