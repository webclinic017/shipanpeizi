class Util{
  Util();
  bool checkStockTradeTime(){
    if(DateTime.now().weekday == 0 || DateTime.now().weekday == 6){
      return false;
    }
    if((DateTime.now().hour+8) < 9 || ((DateTime.now().hour+8) == 9 && DateTime.now().minute < 30)){

      return false;
    }
    if((((DateTime.now().hour+8) == 11 && DateTime.now().minute > 30) || (DateTime.now().hour+8) > 11) && (DateTime.now().hour+8) < 13){
      return false;
    }
    if((DateTime.now().hour+8) >= 15){
      return false;
    }
    return true;
  }
}