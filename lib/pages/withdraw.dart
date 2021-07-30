import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/editCard.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Toast.dart';

class withdraw extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return withdraw_();
  }
  
}

class withdraw_ extends State<withdraw>{
  String withdraw_money;
  String can_withdraw_money = "0";
  String bank_name = "暂无银行卡";
  String bank_card = "请添加到账银行卡";
  bool have_card = false;
  FocusNode _commentFocus = FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBankInfo();
  }
  loadBankInfo() async{
    ResultData member = await HttpManager.getInstance()
        .get("member/findMember", withLoading: false);
    ResultData bank = await HttpManager.getInstance()
        .get("member/findUserBank", withLoading: false);
    if(member.data != null){
      setState(() {
        can_withdraw_money = member.data["amount"].toString();
      });
    }
    if(bank.data != null){
      setState(() {
        bank_card = bank.data["bank_card"];
        bank_name = bank.data["bank_name"];
        have_card = true;
      });
    }
  }
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child, // child is the value returned by pageBuilder
    );
  }
  static TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
//    FocusScope.of(context).requestFocus(_commentFocus);
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        iconTheme: IconThemeData(
          size: 25.0,
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        title: Text(
          "零钱提现",
          style: TextStyle(fontSize: ScreenUtil().setSp(18),color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(new PageRouteBuilder(pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return editCard();
              },transitionsBuilder: (

                  BuildContext context,

                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                  ) {
                // 添加一个平移动画
                return createTransition(animation, child);
              },transitionDuration: const Duration(milliseconds: 350)
              )

              ).then((data) => {
// 判断是否刷新
                loadBankInfo()
              });
            },
            child: Container(
              decoration: BoxDecoration(border:Border(top: BorderSide(width: 4,color: Color(0xfffcfcfc)),bottom: BorderSide(width: 4,color: Color(0xfffcfcfc))) ),
              padding: EdgeInsets.only(top: 15,bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Text("到账银行卡"),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin:EdgeInsets.only(right: 10),
                          child: Image.asset("img/yl.png",fit: BoxFit.fill,width: 35,),
                        ),
                        Column(
                          children: <Widget>[
                            Text(bank_name),
                            Text(bank_card),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("提现金额"),
                Container(
                  width: ScreenUtil().setWidth(340),
                  child: Row(
                    children: <Widget>[
                      Text("￥",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                     Expanded(
                          child: TextField(

                            focusNode: _commentFocus,
                            onChanged:(e){
                              setState(() {
                                withdraw_money = e.toString();
                              });
                            },
                            controller: TextEditingController
                                .fromValue(TextEditingValue(
                                text:
                                '${this.withdraw_money == null ? "" : this.withdraw_money}',
                                selection:
                                TextSelection.fromPosition(

                                    TextPosition(

                                        affinity:
                                        TextAffinity
                                            .downstream,
                                        offset:
                                        '${this.withdraw_money}'
                                            .length)))),
                            keyboardType: TextInputType.number,//键盘类型，数字键盘

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),


                            ),
                          ),
                        ),

                     Container(
                       margin: EdgeInsets.only(left: 10),
                       child:  Column(
                         children: <Widget>[
                           Container(
                             child: Ink(
                               color: Color(0xffebebeb),
                               child: InkWell(
                                 onTap: (){
                                   setState(() {
                                     if(withdraw_money != null){
                                       if( double.parse(withdraw_money) >=0){
                                         withdraw_money = (double.parse(withdraw_money)+1).toString();
                                       }
                                     }

                                   });
                                 },
                                 splashColor: Colors.grey,
                                 child: Container(
                                   padding: EdgeInsets.only(top: 1,bottom: 1),
                                   child: Icon(Icons.arrow_drop_up,size: 17,),
                                 ),
                               ),
                             ),
                           ),
                           Container(


                             child: Ink(
                               color: Color(0xffebebeb),
                               child: InkWell(
                                 onTap: (){
                                   setState(() {
                                     if(withdraw_money != null){
                                       if( double.parse(withdraw_money) >0){
                                         withdraw_money = (double.parse(withdraw_money)-1).toString();
                                       }
                                       if(double.parse(withdraw_money) < 0){
                                         withdraw_money = "0";
                                       }
                                     }

                                   });
                                 },
                                 splashColor: Colors.grey,
                                 child: Container(
                                   padding: EdgeInsets.only(top: 1,bottom: 1),
                                   child: Icon(Icons.arrow_drop_down,size: 17,),
                                 ),
                               ),
                             ),
                           ),

                         ],
                       ),
                     )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text("可提现$can_withdraw_money元"),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            this.withdraw_money  = can_withdraw_money.toString();
                          });
                        },
                        child: Text("全部提现",style: TextStyle(color: Color(0xff7cb3fc)),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20,top: 20),

            child: MaterialButton(
              disabledColor: Colors.grey,
              splashColor: Colors.grey,
              color: Colors.yellow,
              onPressed:have_card==false?null: () async{
                if(withdraw_money==null){
                  Toast.toast(context,msg: "请输入提现金额");
                  return;
                }
                if(double.parse(withdraw_money) <= 0){
                  Toast.toast(context,msg: "请输入提现金额");
                  return;
                }
                ResultData result = await HttpManager.getInstance()
                    .post("member/applyWithdraw",params: {"withdraw_money":double.parse(withdraw_money)}, withLoading: false);
                if(result.code != 200 ){
                  Toast.toast(context,msg: result.msg);
                }else{
                  Toast.toast(context,msg: "申请成功");
                  setState(() {
                  double s =  double.parse(can_withdraw_money) - double.parse(withdraw_money);
                    can_withdraw_money = s.toString();
                    withdraw_money = "0";
                  });
                }
              },
              child: Text("立即提现"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:10),
            child: Text("注意事项:"),
          ),
          Container(
            margin: EdgeInsets.only(left:20),
            child: Text("1.提现手续费每笔3元"),
          ),
        ],
      ),
    );
  }
  
}