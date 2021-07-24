import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/stock.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';

class searchStock extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return searchStock_();
  }
}
class searchStock_ extends State<searchStock>{
  List stock_list = [];
  bool is_search = false;
  List history_stock = [];
  String stock_code;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getHistory();
  }
  getHistory() async {

    List sl = await TokenStore().getStringList("search_list") ;

    setState(() {
      history_stock = sl;
    });
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 25),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(

                    width: ScreenUtil().setWidth(320),
                    height: 35,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            onChanged:(e) async {
                              setState(() {
                                stock_code = e;
                              });
                              if(e.length>=3){
                                ResultData result =  await HttpManager.getInstance().get("stock/searchStock",params: {"stock_code":e},withLoading: false);
                                Map res = result.data;
                                Map res1 =  json.decode(res["data"]);
                                Map res2 = res1["showapi_res_body"];
                                List res3 = res2["list"];
                                setState(() {
                                  if(res3.length>10){
                                    stock_list = res3.sublist(0,9);
                                  }else{
                                    stock_list = res3;
                                  }
                                  if(stock_list.length>0){
                                    is_search = true;
                                  }else{
                                    is_search = false;
                                  }
                                });
                              }else{
                                setState(() {
                                  is_search = false;
                                });
                              }
                            },
                            controller: TextEditingController
                                .fromValue(TextEditingValue(
                                text:
                                '${this.stock_code == null ? "" : this.stock_code}',
                                selection:
                                TextSelection.fromPosition(
                                    TextPosition(
                                        affinity:
                                        TextAffinity
                                            .downstream,
                                        offset:
                                        '${this.stock_code}'
                                            .length)))),
                            /// 设置字体
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            /// 设置输入框样式
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xfff5f5f5),
                                hintText: '搜索(输入股票代码)',
                                /// 边框
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    /// 里面的数值尽可能大才是左右半圆形，否则就是普通的圆角形
                                    Radius.circular(50),
                                  ),
                                ),

                                ///设置内容内边距
                                contentPadding: EdgeInsets.only(
                                  top: 0,
                                  bottom: 0,
                                ),
                                /// 前缀图标
                                prefixIcon: Icon(Icons.search),
                                suffixIcon:IconButton(onPressed: (){
                                  setState(() {
                                    stock_list = [];
                                    is_search = false;
                                    stock_code = "";
                                  });
                                },icon: Icon(Icons.close),)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Text("取消"),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: this.is_search ,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10,top: 10),
                        child: Text("股票",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: getStockList(),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !this.is_search ,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("历史搜索",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          GestureDetector(
                            onTap: (){
                              TokenStore().clearToken("search_list");
                              getHistory();
                            },
                            child: const Icon(Icons.delete,color: Colors.grey,),

                          )
                        ],
                      ),
                      GridView.count(crossAxisCount: 3,childAspectRatio: 2,shrinkWrap: true,children: history_stock!=null?history_stock.asMap().keys.map((e){
                       Map m = json.decode(history_stock[e]);

                        return GestureDetector(
                          onTap: (){
                            JumpAnimation().jump(stock(m["code"]), context);
                          },
                          child: Container(
                            child: Chip(
                              label: Text(m["name"]),
                            ),
                          ),
                        );
                      }).toList():[],)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<MaterialButton> getStockList(){

    return stock_list.asMap().keys.map((e){
      return MaterialButton(onPressed: () async {
        Map map = {"code":stock_list[e]["code"].toString(),"name":stock_list[e]["name"].toString()};
        String str = json.encode(map);
        List sl = await TokenStore().getStringList("search_list") ;

        if(sl == null){
          List<String> lst = [];
          lst.add(str);
          TokenStore().setStringList("search_list", lst);

        }else{
          sl.add(str);
          TokenStore().setStringList("search_list", sl);
        }
        getHistory();
        JumpAnimation().jump(stock(stock_list[e]["code"].toString()), context);
      },child: Container(

        padding: EdgeInsets.only(top: 5,bottom: 5),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(stock_list[e]["name"],style: TextStyle(fontWeight: FontWeight.bold),)
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 3),
                  padding: EdgeInsets.only(top: 1,bottom: 1,left: 3,right: 3),
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(stock_list[e]["market"].toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 9),),
                ),
                Text(stock_list[e]["code"])
              ],
            )
          ],
        ),
      ),);
    }).toList();
  }

}