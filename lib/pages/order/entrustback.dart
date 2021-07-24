import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<_entrust> entrustKey = GlobalKey();
class entrust extends StatefulWidget{
  @override
  _entrust createState() => _entrust();
}
class _entrust extends State<entrust>{
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
                  width: ScreenUtil().setWidth(150),
                  child: Text("名称"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(85),
                  child: Text("现价|委托"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(95),
                  child: Text("数量"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(85),
                  child: Text("方向"),
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
                          width: ScreenUtil().setWidth(150),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("包钢股份",style: TextStyle(color: rase_color),),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(

                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    color: Color(0xffffe5ee),
                                    child: Text("买",style: TextStyle(color: rase_color,fontSize: 11),),
                                  ),
                                  Text("20210120 12:27:54",style: TextStyle(color: rase_color,fontSize: 11),)
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(85),
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
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(85),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("买入",style: TextStyle(color: rase_color),),
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