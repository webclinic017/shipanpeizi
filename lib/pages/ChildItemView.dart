import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/stock.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Util.dart';
import 'package:flutterapp2/utils/request.dart';


final GlobalKey<_ChildItemView> childkey = GlobalKey();
class ChildItemView extends StatefulWidget {

  ChildItemView();
  @override
  _ChildItemView createState() => _ChildItemView();
}

class _ChildItemView extends State<ChildItemView>{
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
  Timer timer_s;
  @override
  void initState() {
    super.initState();
    _future = getRankList();
    bool is_trade = Util().checkStockTradeTime();
      if(is_trade){
        timer_s = Timer.periodic(Duration(seconds: 5,), (t){
          getRankList();
        });
      }
  }
  @override
  void dispose() {
    if(timer_s != null){
      timer_s.cancel();
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
                          padding: EdgeInsets.only(left: 15,right: 15),
                          child: Wrap(

                            children: getTableRowList(),
                          ),
                        )
                      ],
                    ),
                    onRefresh: () async {
                      await new Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          getRankList();

                        });
                      });
                    },
                    loadMore: null,
                  ),
                );
            }
            return null;
          }
      ),
    );





  }


  List<Container> getTableRowList(){
    int i = 0;
    table_list = [];
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

    if(rank_list != null){
      rank_list.forEach((element) {

        Color cur_color ;
        String diff_rate;
        if(double.parse(element["diff_rate"])>0.00){
          cur_color = Colors.red;
          diff_rate = "+"+element["diff_rate"].toString();
        }else{
          cur_color = Color(0xff09B971);
          diff_rate = element["diff_rate"].toString();
        }
        table_list.add(Container(

          child: Material(
            color: Colors.white,
            child: Ink(
              child: InkWell(
                splashColor: Colors.black26,
                onTap:() {

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
      });
    }

    return table_list;
  }
  Future getRankList() async {
     ResultData res = await HttpManager.getInstance().get("stock/get_my_optional",withLoading: false);
     if(res.data != null){
       Map dat1 = res.data["data1"];
       List list = dat1["showapi_res_body"]["list"];
       setState(() {
         rank_list = list;
         table_list.add(Container(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Container(
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
       });
     }else{
       timer_s.cancel();
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
