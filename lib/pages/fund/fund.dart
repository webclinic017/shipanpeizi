import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/utils/fundDraw.dart';

class fund extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return fund_();
  }
}

class fund_ extends State<fund>{
  int flag = 0;
  int page = 1;
  List<ListTile> list = [];
  List data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    List<Map> d = [
      {"v":"全部交易","state":0},
      {"v":"账户充值","state":1},
      {"v":"申请提现","state":3},
      {"v":"提现失败","state":4},
      {"v":"申请合约","state":7},
      {"v":"合约申请失败","state":14},
      {"v":"扩大合约","state":8},
      {"v":"追加保证金","state":9},
      {"v":"合约提盈","state":10},
      {"v":"合约结算","state":11},
      {"v":"续期利息","state":12},
    ];

    d.forEach((element) {
      list.add(ListTile(
        onTap: (){
          setState(() {
            flag =element["state"];
            page = 1;

            Navigator.pop(context);
          });
          getList();
        },
        title: Text(element["v"],style: TextStyle(color: Colors.black),),
      ));
    });
   getList();
  }
  getList()async{
  ResultData res = await HttpManager.getInstance().get("member/getFundList",params: {"page":page,"limit":10,"state":flag,"sort":"-id"},withLoading: false);
  if(page == 1){
    setState(() {
      data = res.data;
    });
  }else{
    List s = res.data;
    s.forEach((element) {
      setState(() {
        data.add(element);
      });

    });
  }

  }
  getCardList(){
    return data.asMap().keys.map((e){
      String str = '余额';
      List arr = [15,16,17,18,19,20,21];
      if(arr.contains(data[e]["type"])){
        str = "操盘余额";
      }
      return Container(
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
        child: Card(
          elevation:3,
          shadowColor: Colors.brown,
          child: Container(
            padding: EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),

            child: Wrap(
              runSpacing: 15,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("日期:  "+data[e]["add_time"]),
                    Text("金额:  "+data[e]["amount"].toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text("用途:  "+data[e]["mark"]),
                    ),
                    Text(str+":  "+data[e]["after_amount"].toString()),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      drawer: fundDraw(
          widthPercent: 0.4,
        child: Container(
          padding: EdgeInsets.only(top: 10),

          child: ListView(
            children: [
              Column(
                children: list,
              )
            ],
          ),
        ),
      ),

      backgroundColor: Colors.white,
      appBar: AppBar(

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            tooltip: "Alarm",
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ],
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(
          size: 25.0,
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        title: Text("资金明细",style: TextStyle(color:Colors.black),),

      ),
      body: EasyRefresh(
        loadMore: ()async{
          setState(() {
            page++;
          });
          getList();
        },
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Wrap(
                children: getCardList(),
              ),
            )
          ],
        ),
      ),
    );
  }

}