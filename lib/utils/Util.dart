import 'package:date_format/date_format.dart';
import 'package:flutterapp2/chart/utils/date_format_util.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
class Util{
  Util();
  bool checkStockTradeTime(){
    initializeDateFormatting();
    DateTime victoryDay = DateTime.now();
   String zhou = DateFormat('EEE',"zh_CN").format(victoryDay).toString();

    if(zhou == '周六' || zhou == "周日"){
      return false;
    }
    if((DateTime.now().hour) < 9 || ((DateTime.now().hour) == 9 && DateTime.now().minute < 30)){
      return false;
    }
    if((((DateTime.now().hour) == 11 && DateTime.now().minute > 30) || (DateTime.now().hour) > 11) && (DateTime.now().hour) < 13){
      return false;
    }
    if((DateTime.now().hour) > 14){
      return false;
    }
    return true;
  }
}