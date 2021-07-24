import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class introduction extends StatefulWidget{
  @override
  _introduction createState() => _introduction();
}

class _introduction extends State<introduction>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("公司简介",style: TextStyle(color: Colors.black),),
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
                Text("广州盈满资管企业管理有限公司成立于2018年12月份，注册实缴资本5000万元人民币。是一家集金融服务、基金管理、股权投资、资产管理、实体项目投资等业务的综合金融企业。战略合作伙伴有申万宏源证券、国泰君安证券、招商证券、国信证券、四川信托、云南信托等多家合作银行及券商金融机构。 公司凭借多年金融行业投资经验、以客户为中心，秉承专业、诚信、贴心、共赢的服务宗旨，以诚信共赢、高效专业的经营理念，赢得了客户及合作伙伴的高度认可，紧密结合金融市场环境及用户需求，不断加强创新能力，提高企业综合实力，致力于为用户打造一个安全、专业、可信赖的投资平台，让人人都懂得投资，通过资产配置，实现财富增值。"),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Wrap(
              runSpacing: 15,
              children: <Widget>[
                Text("企业文化 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text("诚信、规范、专业、创新为经营思想，以客户至上为经营原则，以专业创造价值为企业文化价值理念"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Wrap(
              runSpacing: 15,
              children: <Widget>[
                Text("我们的优势 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text("足不出户、零风险、固定收益、复利效应、享受生活。"),
                Text("解决资金瓶颈、以小博大、杠杆效应、充分利用市场波动，放大收益"),
                Text("超低费用：利息低至0.6分，券商佣金万分之二，广大配资用户首选平台。"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Wrap(
              runSpacing: 15,
              children: <Widget>[
                Text("我们的使命 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text("专业：整合有效资源, 借鉴成功案例, 提高专业水平, 打造精英团队。"),
                Text("成长：保持快速发展，努力实现共赢，让客户、员工与企业共同成长。"),
                Text("热情：保持工作热情，积极面对挑战，敢于攀登高峰，追求卓越品质。"),
              ],
            ),
          ),
        ],
      ),
    );
  }

}