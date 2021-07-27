import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutterapp2/pages/ChildItemView.dart';
import 'package:flutterapp2/pages/HistoryContract.dart';
import 'package:flutterapp2/pages/heyue/applyHeYue.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'ValidContract.dart';
class heyue extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return heyue_();
  }
}

class heyue_ extends State<heyue>{

  PageController controller;
  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  List<TextStyle> ts = [TextStyle()];
  TextStyle checked_text_style =
      TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle unchecked_text_style = null;
  BoxDecoration checked_border_style = BoxDecoration(

      border: Border(
          top: BorderSide(
              // 设置单侧边框的样式
              color: Colors.yellow,
              width: 2,
              style: BorderStyle.solid)));
  BoxDecoration unchecked_border_style = null;

List<String> containers = ["有效合约","历史合约"];
List<Container> con = [];



  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15, top: 30),
                  child: Text(
                    "合约",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: Ink(
                    child: InkWell(
                      splashColor: Colors.black26,
                      onTap: (){
                        JumpAnimation().jump(applyHeYue(), context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20,top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    Icons.wrap_text,
                                    size: 30,
                                    color: Colors.orange,
                                  ),
                                  margin: EdgeInsets.only(left: 15),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "申请合约",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(

                                        child: Text("即时审批,快速操盘"),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                                padding:EdgeInsets.only(left: 12, right: 12, top: 3, bottom: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    color: Color(0xffffe100)),
                                child: Text("立即申请"),
                                margin: EdgeInsets.only(right: 15))
                          ],
                        ),
                      )
                    ),
                  ),
                )
              ],
            ),
          ),

          Container(

            margin: EdgeInsets.only(left:15,top: 20),
            child: Row(
             children: containers.asMap().keys.map((e) {
               TextStyle cur_ts;
               BoxDecoration cur_bd;
               if(e == page){
                 cur_ts = checked_text_style;
                 cur_bd = checked_border_style;
               }else{
                 cur_ts = unchecked_text_style;
                 cur_bd = unchecked_border_style;
               }
               return Container(
                 margin: EdgeInsets.only(right: 15),
                 child: Column(
                   children: <Widget>[
                     Container(child: Text(containers[e],style: cur_ts,),),
                     Container(decoration: cur_bd,width: 20,)
                   ],
                 ),
               );
             }).toList(),
            ),
          ),

          Expanded(

            child: PageView(
              controller: controller,
              onPageChanged: onPageChanged,
              children: <Widget>[
                ValidContract("3333"),
                HistoryContract("#33"),
              ],
            ),
          )
          //       Expanded(
//         child:  Scaffold(
//           appBar: AppBar(
//
//
//             bottom: TabBar(
//
//               isScrollable: true,
//               controller: _tabController,
//               tabs: <Widget>[
//                 Tab(
//                   text: "33",
//                 ),
//                 Tab(
//                   text: "33",
//                 ),
//               ],
//             ),
//           ),
//           body: getTabBarView(<Widget>[
//             new Text("第一页"),
//             new Text("第二页")
//           ]),
//         ),
//       )
        ],
      ),
    );
  }
}
