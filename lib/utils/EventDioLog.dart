import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDioLog{

  String title;
  String content;
  BuildContext context;
  Function function;
  EventDioLog(this.title,this.content,this.context,this.function);
  void showDioLog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
            title: Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            content: Text(content,style: TextStyle(fontSize: 15)),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Container(

                  child: Text('取消',style: TextStyle(color: Colors.black),),
                ),
              ),
              FlatButton(


                onPressed: () => function(),
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