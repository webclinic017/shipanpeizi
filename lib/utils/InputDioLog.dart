import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IconInput.dart';

class InputDioLog{

  String title;
  String content;
  BuildContext context;
  Function function;
  Map<String, Object> realName = {
    "value": "",
    "title": "真实姓名",
    "tip": "请输入金额",
    "icon": Icon(Icons.person),
    "is_edit": false,
    "type":"number"
  };
  InputDioLog(this.title,this.content,this.context,this.function);
  void showDioLog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            title: Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            content: IconInput(
              data: realName,
              callBack: (value) {
                realName["value"] = value;
              },
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Container(

                  child: Text('取消',style: TextStyle(color: Colors.black),),
                ),
              ),
              FlatButton(


                onPressed: () => function(realName["value"]),
                child: Container(

                  padding: EdgeInsets.all(10),
                  child: Text('确认',style: TextStyle(color: Colors.blue),),
                ),
              ),

            ],
          );
        });
  }
}