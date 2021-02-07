import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class holdOrder extends StatefulWidget{
  @override
  _holdOrder createState() => _holdOrder();
}
class _holdOrder extends State<holdOrder>{
  Color rase_color = Colors.red;
  Color down_color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return EasyRefresh(

      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: ScreenUtil().setWidth(130),
                  child: Text("名称|市值"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(95),
                  child: Text("浮动盈亏"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(95),
                  child: Text("可用|持仓"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(95),
                  child: Text("成本|现价"),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Divider(),
          ),

          Wrap(
            runSpacing: 5,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(


                    child:  Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: ScreenUtil().setWidth(130),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("包钢股份",style: TextStyle(color: down_color),),
                              Text("3319",style: TextStyle(color: down_color)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(95),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("-28.45",style: TextStyle(color: down_color),),
                              Text("-7.755%",style: TextStyle(color: down_color)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(95),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("300",style: TextStyle(color: down_color),),
                              Text("300",style: TextStyle(color: down_color)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(95),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("1.225",style: TextStyle(color: down_color),),
                              Text("1.13",style: TextStyle(color: down_color)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Divider(),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    child:  Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: ScreenUtil().setWidth(130),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("包钢股份",style: TextStyle(color: rase_color),),
                              Text("3319",style: TextStyle(color: rase_color)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(95),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("-28.45",style: TextStyle(color: rase_color),),
                              Text("-7.755%",style: TextStyle(color: rase_color)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(95),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("300",style: TextStyle(color: rase_color),),
                              Text("300",style: TextStyle(color: rase_color)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(95),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("1.225",style: TextStyle(color: rase_color),),
                              Text("1.13",style: TextStyle(color: rase_color)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Divider(),
                  )
                ],
              ),
            ],
          )
        ],
      ),
      onRefresh: () async {
        await new Future.delayed(const Duration(seconds: 1), () {
          setState(() {

          });
        });
      },
      loadMore: null,
      refreshHeader: MaterialHeader(
        key: null,
      ),
      refreshFooter: MaterialFooter(key: null),
    );
  }
  
}