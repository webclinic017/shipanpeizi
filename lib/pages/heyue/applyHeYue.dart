import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/utils/TipDioLog.dart';
import 'package:flutterapp2/utils/Toast.dart';

class applyHeYue extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return applyHeYue_();
  }
}

class applyHeYue_ extends State<applyHeYue>{
  List heyue = [];
  List deposit = [];
  List leverage = [];
  int cur_heyue_index =0;
  int cur_deposit_index =0;
  int cur_leverage_index =0;
  bool is_focus = false;
  FocusNode _commentFocus;
  double blockwidth;
  String cur_deposit;
  bool is_loading = true;
  double amount = 0.00;
  double repare_capitical = 0.00;
  double interest = 0.00;
  double leverage_money = 0.00;
  double total_capitial = 0.00;
  double loss_warning_line = 0.00;
  double deposit_ = 0.00;
  double interest_rate = 0.00;
  double loss_sell_line = 0.00;
  double leverage_name = 0.00;
  int use_time = 2;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getDeposit();
    _commentFocus = FocusNode();
    deposit = [
      {"id":2,"value":"1000","name":"1千"},
      {"id":3,"value":"2000","name":"2千"},
      {"id":4,"value":"3000","name":"3千"},
      {"id":5,"value":"5000","name":"5千"},
      {"id":6,"value":"8000","name":"8千"},
      {"id":7,"value":"10000","name":"1万"},
      {"id":8,"value":"20000","name":"2万"},
      {"id":9,"value":"30000","name":"3万"},
      {"id":10,"value":"50000","name":"5万"},
      {"id":11,"value":"0","name":"自定义金额"},
      ];
    cur_deposit = deposit[cur_deposit_index]["value"];

  }
  @override
  Widget build(BuildContext context) {

    blockwidth = MediaQuery.of(context).size.width * 0.285;
    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              size: 12.0,
              color: Colors.black, //修改颜色
            ),
            backgroundColor: Colors.white,
            centerTitle:true,
            title: Text("申请合约",style: TextStyle(color: Colors.black,fontSize: 16),),
          ),
          body: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[

                  Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfffafafa),width: 6),top: BorderSide(color: Color(0xfffafafa),width: 6))),
                    padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("钱包可用余额",style: TextStyle(color: Color(0xff858585)),),
                        Text("￥"+amount.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 25,top: 10,bottom: 15),
                    child: Text("选择合约",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                  ),


                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: getHeYueList(),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 25,top: 10,bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Text("保证金",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        ),
                        Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 1),
                              child: TextField(
                                onChanged:(e){
                                  setState(() {
                                    if(double.parse(e) >=0){
                                      cur_deposit = e;
                                      int index = 0;
                                      deposit.forEach((element) {
                                        if(element["value"] == cur_deposit){
                                          cur_deposit_index = index;
                                        }
                                        if(index == deposit.length){
                                          return;
                                        }
                                        index++;
                                      });
                                    }

                                  });
                                },
                                controller: TextEditingController
                                    .fromValue(TextEditingValue(
                                    text:
                                    '${this.cur_deposit == null ? "" : this.cur_deposit}',
                                    selection:
                                    TextSelection.fromPosition(
                                        TextPosition(
                                            affinity:
                                            TextAffinity
                                                .downstream,
                                            offset:
                                            '${this.cur_deposit}'
                                                .length)))),
                                keyboardType: TextInputType.number,//键盘类型，数字键盘
                                focusNode: _commentFocus,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                        )


                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Wrap(
                      children: getDeopositList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25,top: 15,bottom: 15),
                    child: Text("申请额度",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 50),
                    child: Wrap(
                      children: getLeverageList(),
                    ),
                  ),

                ],
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: 1000,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),


              Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width*0.2,
                right: MediaQuery.of(context).size.width*0.2,
                child: MaterialButton(
                  color: Colors.yellow,
                  onPressed: () async {
                    int heyue_id = heyue[cur_heyue_index]["id"];
                    int leverage_id = leverage[cur_leverage_index]["id"];
                    ResultData result = await HttpManager.getInstance().get(Address.BASE_URL+"frontend/heyue/caculate",params: {"deposit":cur_deposit,"heyue_id":heyue_id,"leverage_id":leverage_id});
                     setState(() {
                       repare_capitical = result.data["repare_capitical"];
                       interest = result.data["interest"];
                       leverage_money = result.data["leverage_money"];
                       total_capitial = result.data["total_capitial"];
                       leverage_name = result.data["leverage_name"];
                       loss_warning_line = result.data["loss_warning_line"];
                       deposit_ = result.data["deposit"];
                       interest_rate = result.data["interest_rate"];
                       loss_sell_line = result.data["loss_sell_line"];
                       use_time = result.data["use_time"];
                     });

                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Container(
                          //弹出框的具体事件
                                child: Material(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  child: Center(
                                    child: Container(
                                      width: 300,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(color: Colors.white),
                                      child: Wrap(

                                        runSpacing: 10,
                                        children: <Widget>[
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.end,

                                            children: <Widget>[
                                              Container(
                                                width:150,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Text("确认信息",style: TextStyle(fontWeight: FontWeight.bold),),
                                                    GestureDetector(
                                                      child: Container(

                                                        child: Icon(Icons.close),
                                                      ),
                                                      onTap: (){
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(border: Border(top: BorderSide(width: 0.2,color: Colors.black12))),
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("总操盘资金"),
                                                    GestureDetector(
                                                      onTap: (){
                                                        TipDioLog("总操盘资金","总操盘资金=保证金\+配资资金\n追加的保证金不计入总操盘资金",context).showDioLog();
                                                      },
                                                      child: Icon(
                                                        const IconData(0xe602, fontFamily: 'iconfont'),
                                                        size:18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(total_capitial.toString()+"元"),
                                              )
                                            ],
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("保证金/本金"),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(deposit_.toString()+"元"),
                                              )
                                            ],
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("配资资金"),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(leverage_money.toString()+"元"+"/"+leverage_name.toStringAsFixed(0)+"倍"),
                                              )
                                            ],
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("亏损预警线"),
                                                    GestureDetector(
                                                      onTap: (){
                                                        TipDioLog("亏损预警线","亏损预警线=保证金×50.00%+配资资金",context).showDioLog();
                                                      },
                                                      child: Icon(
                                                        const IconData(0xe602, fontFamily: 'iconfont'),
                                                        size:18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(loss_warning_line.toString()+"元"),
                                              )
                                            ],
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("亏损平仓线"),
                                                    GestureDetector(
                                                      onTap: (){
                                                        TipDioLog("亏损平仓线","亏损平仓线=保证金×30.0%+配资资金",context).showDioLog();
                                                      },
                                                      child: Icon(
                                                        const IconData(0xe602, fontFamily: 'iconfont'),
                                                        size:18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(loss_sell_line.toString()+"元"),
                                              )
                                            ],
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("利率"),
                                                    GestureDetector(
                                                      onTap: (){
                                                        TipDioLog("利息利率","按天、按周、按月的合约\n收取利息的利率是不一样的\n具体以显示为准\n\n交易日14:25之前申请的合约当日开始计息\n14.45之后与非交易日申请的合约下个交易日开始计息",context).showDioLog();
                                                      },
                                                      child: Icon(
                                                        const IconData(0xe602, fontFamily: 'iconfont'),
                                                        size:18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(interest_rate.toString()+"%"),
                                              )
                                            ],
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("产生利息"),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(interest.toString()+"元"),
                                              )
                                            ],
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("资金使用时间"),
                                                    GestureDetector(
                                                      onTap: (){
                                                        TipDioLog("资金使用时间","资金使用时间即操盘期限\n按天合约最多两天\n按月、按周最少一月、一周\n所有类型合约到期自动续期\n您也可以随时手动终止结算",context).showDioLog();
                                                      },
                                                      child: Icon(
                                                        const IconData(0xe602, fontFamily: 'iconfont'),
                                                        size:18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(use_time.toString()+"天(自动续费)"),
                                              )
                                            ],
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Wrap(
                                                  spacing: 2,
                                                  children: <Widget>[
                                                    Text("准备资金"),
                                                    GestureDetector(
                                                      onTap: (){
                                                        TipDioLog("准备资金","准备资金=保证金+利息×资金使用时间",context).showDioLog();
                                                      },
                                                      child: Icon(
                                                        const IconData(0xe602, fontFamily: 'iconfont'),
                                                        size:18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(repare_capitical.toString()+"元"),
                                              )
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(border: Border(top: BorderSide(width: 0.2,color: Colors.black12))),
                                          ),
                                          Container(
                                            child: Text("如果您点击\"确认\"按钮,即表示您已阅读并同意我们网站上的相关风险披露与说明",style: TextStyle(fontSize: 12),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: MaterialButton(
                                                  color: Colors.white,
                                                  textColor: Colors.black,
                                                  child: new Text('取消'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                                ,),
                                              Container(
                                                child: MaterialButton(
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                child: new Text('确认'),
                                                onPressed: () async {
                                                  // ...
                                                  int heyue_id_ = heyue[cur_heyue_index]["id"];
                                                  int leverage_id_ = leverage[cur_leverage_index]["id"];
                                                  ResultData result = await HttpManager.getInstance().get(Address.BASE_URL+"frontend/applyHeYue",withLoading: true,params: {"deposit":cur_deposit,"heyue_id":heyue_id_,"leverage_id":leverage_id_});
                                                  if(result.code == 505){
                                                    Toast.toast(context,msg:"账户余额不足");
                                                  }else if(result.code == 500){
                                                    Toast.toast(context,msg:"申请失败");
                                                    Navigator.pop(context);
                                                  }else if(result.code == 200){
                                                    Toast.toast(context,msg:"申请成功");
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              )
                                                ,),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );


                        });


                  },
                  hoverColor: Colors.black,
                  child: Text("立即申请",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          )
      ),
    );
  }
 List getHeYueList(){
    return heyue.asMap().keys.map((e){
      FontWeight fw = FontWeight.normal;
      Color bg_color = Colors.white;
      if(e == cur_heyue_index){
        fw = FontWeight.bold;
        bg_color = Colors.yellow;
      }
          return Container(
            child: Card(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(color: bg_color,borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: EdgeInsets.only(top: 8,bottom: 8),
                  alignment: Alignment.center,
                  width: blockwidth,
                  child: Text(heyue[e]["name"],style: TextStyle(fontSize: 14,fontWeight: fw),),
                ),
                onTap: (){
                  setState(() {
                    cur_heyue_index = e;
                  });
                },
              ),
            ),
          );
    }).toList();
  }

 List getDeopositList() {
   return deposit.asMap().keys.map((e){
     FontWeight fw = FontWeight.normal;
     Color bg_color = Colors.white;
     if(e == cur_deposit_index){
       fw = FontWeight.bold;
       bg_color = Colors.yellow;
     }
     String name;
     if(e==deposit.length-1){
        name = "自定义金额";
     }else{
        name = getNum(int.parse(deposit[e]["value"]));
     }
     return Container(
       child: Card(
         child: GestureDetector(
           child: Container(
             padding: EdgeInsets.only(top: 8,bottom: 8),
             decoration: BoxDecoration(color: bg_color,borderRadius: BorderRadius.all(Radius.circular(5))),
              alignment: Alignment.center,
              width: blockwidth,
             child: Text(name,style: TextStyle(fontSize: 14,fontWeight: fw),),
           ),
           onTap: (){
             if(e == deposit.length-1){
               FocusScope.of(context).requestFocus(_commentFocus);//失去焦点_commentFocus.unfocus();    // 失去焦点
             }
             setState(() {
               cur_deposit_index = e;
               if(e != deposit.length-1){
                 cur_deposit = deposit[e]["value"];
               }
             });
           },
         ),
       ),
     );
   }).toList();
 }

 getLeverageList(){

   return leverage.asMap().keys.map((e){
     FontWeight fw = FontWeight.normal;
     Color bg_color = Colors.white;
     if(e == cur_leverage_index){
       fw = FontWeight.bold;
       bg_color = Colors.yellow;
     }

     return Container(
       child: Card(
         child: GestureDetector(
           child: Container(
             padding: EdgeInsets.only(top: 8,bottom: 8),
             decoration: BoxDecoration(color: bg_color,borderRadius: BorderRadius.all(Radius.circular(5))),
             alignment: Alignment.center,
             width: blockwidth,
             child: Text(get_Num(leverage[e]["name"])+"倍"+getNum_(leverage[e]["name"]),style: TextStyle(fontSize: 14,fontWeight: fw),),
           ),
           onTap: (){
             setState(() {
               cur_leverage_index = e;

             });
           },
         ),
       ),
     );
   }).toList();
 }
 getNum(int num){
   int num_ = (num/1000).floor() as int;
    if(num_ >= 10){
      return (num / 10000).floor().toString()+"万";
    }else if(num_>=1){
      return (num / 1000).floor().toString()+"千";
    }else{
      return (num / 100).floor().toString()+"百";
    }
 }

  get_Num(double num){
    List s = num.toString().split(".");
    return s[0];

  }

  getNum_(double num){

    int num_ = ((num*(int.parse(cur_deposit)))/1000).toInt();
    if(num_ >= 10){
      List s = (num*(int.parse(cur_deposit)) / 10000).toString().split(".");
      if(s[1] == "0"){
        return s[0]+"万";
      }else{
        return (num*(int.parse(cur_deposit)) / 10000).toString()+"万";
      }

    }else if(num_>=1){
      List s = (num*(int.parse(cur_deposit)) / 1000).toString().split(".");

      if(s[1] == "0"){
        return s[0]+"千";
      }else{
        return (num*(int.parse(cur_deposit)) / 1000).toString()+"千";
      }
    }else{
      List s = (num*(int.parse(cur_deposit)) / 100).toString().split(".");
      if(s[1] == "0"){
        return s[0]+"百";
      }else{
        return (num*(int.parse(cur_deposit)) / 100).toString()+"百";
      }

    }
  }
 getDeposit() async {
    ResultData result = await HttpManager.getInstance().get(Address.BASE_URL+"frontend/getHeYueLeverage",withLoading: false);
   if(result.data != null){

      List hy = result.data["validHeYueIdList"];
     List lr = result.data["validLeverageIdList"];
     double amount_ = result.data["amount"];

     setState(() {
       heyue = hy;
       leverage = lr;
       amount = amount_;
     });
   }

  }
}