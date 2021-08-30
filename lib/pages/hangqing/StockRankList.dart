import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Util.dart';
import 'package:flutterapp2/utils/request.dart';
import 'package:flutterapp2/net/ResultData.dart';
import '../stock.dart';

class StockRankList extends StatefulWidget {
  @override
  _StockRankList createState() => _StockRankList();
}

class _StockRankList extends State<StockRankList>{
  @override
  // TODO: implement wantKeepAlive

  List<Container> table_list = [];
  List dapan_data;
  List<String> containers = ["沪深", "自选"];
  int page = 0;
  int page_ = 1;
  List rank_list = [] ; //龙虎榜
  double screenwidth;
  List<TextStyle> ts = [TextStyle()];
  Future _future;
  Timer timer_;
  @override
  void initState() {
    super.initState();
    getDaPanData();
    _future = getRankList();
    dapan_data = [
      {
        "text": "上证指数",
        "price": "--",
        "diff": "--",
        "diff_money": "--",
        "color": Colors.black,
        "bg_color": Colors.white
      },
      {
        "text": "深证成指",
        "price": "--",
        "diff": "--",
        "diff_money": "--",
        "color": Colors.black,
        "bg_color": Colors.white
      },
      {
        "text": "创业板指",
        "price": "--",
        "diff": "--",
        "diff_money": "--",
        "color": Colors.black,
        "bg_color": Colors.white
      }
    ];
    bool is_trade = Util().checkStockTradeTime();
    if(is_trade){
      timer_ = Timer.periodic(Duration(seconds: 5), (t){
        try{
          getDaPanData();
        }catch(Exception){
        }
      });
    }

  }
  @override
  void dispose() {
  if(timer_ != null){
    timer_.cancel();
  }

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screenwidth = MediaQuery.of(context).size.width*0.6;
    return Container(
      child: FutureBuilder(
        future: _future,
          builder: (context, snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('网络请求出错'),
                  );
                }
                return Center(
                  child: EasyRefresh(
                    refreshHeader: MaterialHeader(
                      key: null,
                    ),
                    refreshFooter: MaterialFooter(key: null),
                    child: ListView(
                      children: <Widget>[
                        Container(

                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            direction: Axis.horizontal,
                            children: (dapan_data !=null && dapan_data.length>0) ? getDaPanList():[],
                          ),
                        ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text("龙虎榜",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Wrap(

                      children: rank_list != null && rank_list.length>0? getTableRowList():[],
                    ),
                  )
                      ],
                    ),
                    onRefresh: () async {
                      await new Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                         getRankList();
                         getDaPanData();
                        });
                      });
                    },
                   loadMore: ()async{
                      setState(() {
                        page_++;
                      });

                   },
                  ),
                );
            }
            return null;
          }
      ),
    );





  }

  List getDaPanList() {

    return dapan_data.asMap().keys.map((e) {
      return Card(
          shadowColor: Colors.black,
          child: Container(
            decoration: BoxDecoration(
                color: dapan_data[e]["bg_color"],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: 100,
            height: 100,
            child: Wrap(
              spacing: 10,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  dapan_data[e]["text"],
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  dapan_data[e]["price"],
                  style: TextStyle(color: dapan_data[e]["color"], fontSize: 16),
                ),
                Wrap(
                  spacing: 3,
                  children: <Widget>[
                    Text(
                      dapan_data[e]["diff_money"],
                      style: TextStyle(
                          color: dapan_data[e]["color"], fontSize: 12),
                    ),
                    Text(
                      dapan_data[e]["diff"],
                      style: TextStyle(
                          color: dapan_data[e]["color"], fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ));
    }).toList();
  }
  List<Container> getTableRowList(){
    int i = 0;
    rank_list.forEach((element) {
      Color cur_color ;
      String diff_rate;
      if(element["diff_rate"]>0.00){
        cur_color = Colors.red;
        diff_rate = "+"+element["diff_rate"].toString();
      }else{
        cur_color = Color(0xff09B971);
        diff_rate = element["diff_rate"].toString();
      }

      if(i>5){
        table_list.add(Container(

          child: Material(
            color: Colors.white,
            child: Ink(

              child: InkWell(
                splashColor: Colors.black26,
                onTap:() {
                  print(element["code"]);
                  JumpAnimation().jump(stock(element["code"].toString()), context);
                },
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 7,bottom: 7),
                      width: screenwidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.vertical,
                            children: <Widget>[
                              Text(
                                element["name"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(element["code"].toString(),style: TextStyle(fontSize: 12),),
                                ],
                              )
                            ],
                          ),
                          Container(

                            child: Text(element["nowPrice"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),


                    Container(

                      child: Text(diff_rate.toString()+"%",
                          style: TextStyle(
                              color: cur_color,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }
      i++;
    });
    return table_list;
  }
  Future getRankList() async {
    try{


      ResultData result = await HttpManager.getInstance().get("stock/getRankList/"+page_.toString(),withLoading: false);

      Map d =  json.decode(result.data["data"]);

      List list = d["showapi_res_body"]["data"]["list"];

      setState(() {
        if(page_ == 1){
          rank_list = list;
          table_list.add(Container(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: screenwidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("名称代码"),
                      Text("最新价格"),
                    ],
                  ),
                ),
                Container(
                  child: Text("涨跌幅"),
                ),
              ],
            ),
          ));
        }else{
          rank_list.addAll(list);
        }

      });
    }catch(e){
      print(e);
    }
  }

 Future getDaPanData() async {
    try {
      ResultData res =await HttpManager.getInstance().get("stock/getDaPanData",withLoading: false);
      Map d =  json.decode(res.data["data"]);
      List list = d["showapi_res_body"]["indexList"];
      if(list != null){
        if(list.length>0){
          int i = 0;
          list.forEach((element) {
            setState(() {
              if (double.parse(element["diff_rate"]) > 0.00) {
                dapan_data[i]["color"] = Color(0xffE63A3C);
                dapan_data[i]["diff"] = "+" + element["diff_rate"] + "%";
                dapan_data[i]["diff_money"] = "+" + element["diff_money"];
                dapan_data[i]["bg_color"] = Color(0xfffaf0f0);
              } else {
                dapan_data[i]["color"] = Color(0xff09B971);
                dapan_data[i]["diff"] = element["diff_rate"] + "%";
                dapan_data[i]["diff_money"] = element["diff_money"];
                dapan_data[i]["bg_color"] = Color(0xffe1fae5);
              }
              dapan_data[i]["price"] = element["nowPrice"];
            });
            if (i > 2) {
              return;
            }
            i++;
          });
        }
      }
    } catch (e) {
      print(e);
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

}
