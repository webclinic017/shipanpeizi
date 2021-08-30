import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class rule extends StatefulWidget{
  @override
  _rule createState() => _rule();
}

class _rule extends State<rule>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("交易规则",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(
          size: 12.0,
          color: Colors.black, //修改颜色
        ),

        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Wrap(
              runSpacing: 15,
              children: <Widget>[
                Text("交易规则政策内容：",style: TextStyle(fontWeight: FontWeight.bold),),
                Text("1.全程支付账户管理费（不包含交易印花税、过户费和佣金），无其他任何费用。"),
                Text("2.投资本金：您用于投资股票的资金,起点相当低。"),
                Text("3.资金使用期限：按交易日计算，不包含各类节假日。"),
                Text("4.管理费：按天：首次是按一天收取 后续费用每天15:00收取，按周：每周收取一次，按月：每月收取一次管理费用。"),
                Text("5.亏损警告线：当总配资资金低于警戒线以下时，您要及时追加保证金或者卖出止损。"),
                Text("6.亏损平仓线：当总配资资金低于平仓线以下时，我们将有权把您的股票进行平仓，为避免平仓发生，请时刻关注本金是否充足。"),
                Text("7.开始交易时间：交易日当天14:50之前的申请于当日生效（当天开始收取账户管理费），交易日当天14：50后的申请于下个交易日生效。"),
                Text("8.股市有风险，投资需谨慎。"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Wrap(
              runSpacing: 15,
              children: <Widget>[
                Text("股票配资限制购买的股票有哪些？ ",style: TextStyle(fontWeight: FontWeight.bold),),
                Text("1、不得购买权证类可以T+0交易的证券；"),
                Text("2、不得购买带ST和*ST的股票；"),
                Text("3、不得购买上市30日以内的新股（或复牌首日股票）等当日不设涨跌停板限制的股票；"),
                Text("4、不得进行坐庄、对敲、接盘、大宗交易、内幕信息等违反股票交易法律法规及证券公司规定的交易。"),

              ],
            ),
          ),
        ],
      ),
    );
  }

}