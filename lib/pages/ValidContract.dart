import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/InputDioLog.dart';
import 'package:flutterapp2/utils/NumUtil.dart';
import 'package:flutterapp2/utils/Toast.dart';
class ValidContract extends StatefulWidget {
  String _title;

  ValidContract(this._title);

  @override
  _ValidContract createState() => _ValidContract();
}

class _ValidContract extends State<ValidContract> {


  Future _future;
  List _list = [];
  int _page = 1;
  bool hasMore = true; //判断有没有数据
  List<String> addStr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> str = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = this._getListData();
  }

  Future _getListData() async {
    if (this.hasMore) {
     ResultData res = await HttpManager.getInstance().get("frontend/selectMemberHeYueByCase",params: {"apply_state":1},withLoading: false);
      List arr = res.data;

      setState(() {
        this._list = res.data;
//        if (this._page == 1) {
//          this._list = res.data;
//        } else {
//          this._list.addAll(arr);
//        }
//        this._page++;
      });
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000), () {

      this._page = 1;
      _getListData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      builder: (context, snapshot) {
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
                child: ListView.builder(
                  itemCount: _list != null? _list.length:0,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: Card(
                      shadowColor: Colors.grey,
                      child: ExpansionTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "保证金:    " + _list[index]['deposit'].toString(),
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                          "操盘余额:    " +
                                              _list[index]['total_capital'].toString(),
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 13)),
                                      margin: EdgeInsets.only(top: 5),
                                    ),
                                    Container(
                                      child: Text(
                                          "合约市值:    " +
                                              _list[index]['order_sum'].toString(),
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 13)),
                                      margin: EdgeInsets.only(top: 5),
                                    ),
                                    Container(
                                      child: Text(
                                          "合约资产:    " +
                                              NumUtil.add(_list[index]['order_sum'], _list[index]['total_capital']).toString(),
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 13)),
                                      margin: EdgeInsets.only(top: 5),
                                    ),
                                  ],
                                ),
                                PopupMenuButton<String>(
                                    initialValue: "",
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 2,
                                          bottom: 2),
                                      decoration:
                                          BoxDecoration(color: Colors.red),
                                      child: Text(
                                        "操作",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    onSelected: (String string) {
                                     if(string == "1"){
                                       //追加保证金
                                      InputDioLog("追加保证金","3",context,(e) async{
                                        if(e != null && e != ''){
                                          if(double.parse(e)>0){
                                           ResultData res = await HttpManager.getInstance().post("frontend/addDeposit",params: {"id":_list[index]['id'],"deposit":e},withLoading: false);
                                           if(res.code != 200){
                                             Toast.toast(context,msg: res.msg);
                                             return;
                                           }else{
                                             Toast.toast(context,msg: '操作成功');
                                             _getListData();
                                             Navigator.pop(context);
                                           }
                                          }
                                        }

                                      }).showDioLog();
                                     }
                                     if(string == "2"){
                                       //关闭合约
                                     EventDioLog("提示","确认关闭合约吗",context,()async{
                                       ResultData res = await HttpManager.getInstance().post("frontend/closeHeYue",params: {"id":_list[index]['id']},withLoading: false);

                                       if(res.code != 200){
                                         Toast.toast(context,msg: res.msg);
                                         return;
                                       }else{
                                         Toast.toast(context,msg: '操作成功');
                                         _getListData();
                                         Navigator.pop(context);
                                       }
                                     }).showDioLog();
                                     }
                                     if(string == "3"){
                                       //关闭合约
                                       EventDioLog("提示","确认提盈吗",context,()async{
                                         ResultData res = await HttpManager.getInstance().post("frontend/pickHeYueProfit",params: {"id":_list[index]['id']},withLoading: false);

                                         if(res.code != 200){
                                           Toast.toast(context,msg: res.msg);
                                           return;
                                         }else{
                                           Toast.toast(context,msg: '操作成功');
                                           _getListData();
                                           Navigator.pop(context);
                                         }
                                       }).showDioLog();
                                     }
                                     if(string == "4"){
                                       //追加保证金
                                       InputDioLog("扩大合约","3",context,(e) async{
                                         if(e != null && e != ''){
                                           if(double.parse(e)>0){
                                             ResultData res = await HttpManager.getInstance().post("frontend/expandHeYue",params: {"id":_list[index]['id'],"amount":double.parse(e)},withLoading: false);
                                             if(res.code != 200){
                                               Toast.toast(context,msg: res.msg);
                                               return;
                                             }else{
                                               Toast.toast(context,msg: '操作成功');
                                               _getListData();
                                               Navigator.pop(context);
                                             }
                                           }
                                         }

                                       }).showDioLog();
                                     }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuItem<String>>[
                                          PopupMenuItem(
                                            child: Text("追加保证金"),
                                            value: "1",
                                          ),
                                          PopupMenuItem(
                                            child: Text("关闭合约"),
                                            value: "2",
                                          ),
                                          PopupMenuItem(
                                            child: Text("合约提盈"),
                                            value: "3",
                                          ),
                                          PopupMenuItem(
                                            child: Text("扩大合约"),
                                            value: "4",
                                          )
                                        ])
                              ],
                            )
                          ],
                        ),
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffF7F7F7),
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.red, width: 2))),
                            width: double.infinity,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              child: Column(
                                children: <Widget>[
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 5,
                                    children: <Widget>[
                                      Container(

                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("申请时间"),
                                            Text(_list[index]['apply_time'].toString()),
                                          ],
                                        ),
                                      ),
                                  MySeparator(color: Colors.grey),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("合约ID"),
                                            Text(_list[index]['id'].toString()),
                                          ],
                                        ),
                                      ),
                                      MySeparator(color: Colors.grey),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("策略"),
                                            Text(_list[index]['bei'].toString()+"倍"),
                                          ],
                                        ),
                                      ),
                                      MySeparator(color: Colors.grey),
                                      Container(

                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("日息"),
                                            Text(_list[index]['interest'].toString()),
                                          ],
                                        ),
                                      ),
                                      MySeparator(color: Colors.grey),
                                      Container(

                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("策略资金"),
                                            Text(_list[index]['leverage_money'].toString()),
                                          ],
                                        ),
                                      ),
                                      MySeparator(color: Colors.grey),
                                      Container(

                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("亏损警告线"),
                                            Text(_list[index]['loss_warning_line'].toString()),
                                          ],
                                        ),
                                      ),
                                      MySeparator(color: Colors.grey),
                                      Container(

                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("亏损平仓线"),
                                            Text(_list[index]['loss_sell_line'].toString()),
                                          ],
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
                  },
                ),
                onRefresh: () async {
                  _onRefresh();
                },
              ),
            );
        }
        return null;
      },
      future: _future,
    ));
  }
}
class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}