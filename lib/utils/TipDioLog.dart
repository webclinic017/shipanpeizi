import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipDioLog{

  String title;
  String content;
  BuildContext context;
  TipDioLog(this.title,this.content,this.context);
  void showDioLog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:const EdgeInsets.fromLTRB(16.0, 10.0, 12.0, 12.0),
            title: Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            content: Text(content,style: TextStyle(fontSize: 15)),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                color: Colors.yellow,
                onPressed: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.only(left: 25,right: 25),
                  child: Text('确认',style: TextStyle(color: Colors.black),),
                ),
              ),

            ],
          );
        });
  }
}