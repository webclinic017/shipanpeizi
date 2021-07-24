import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconInput extends StatefulWidget{
  Function callBack;
  Map data;
  IconInput({Key key, this.data, this.callBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _ChildState();
  }

}
class _ChildState extends State<IconInput> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    return  Container(
          height: ScreenUtil().setHeight(50),
          margin: EdgeInsets.only(left: 5, top: 15, right: 5),

          child: Row(
            children: <Widget>[

              Expanded(
                child: TextField(
                  keyboardType: getInputType(widget.data),
                  onChanged: (e) {
                    setState(() {
                      widget.data["value"] = e;
                    });
                    widget.callBack(e);
                  },
                  controller: TextEditingController.fromValue(

                      TextEditingValue(
                          text:
                          '${this.widget.data["value"] == null ? "" : this.widget.data["value"]}',
                          selection: TextSelection.fromPosition(
                              TextPosition(
                                  affinity: TextAffinity.downstream,
                                  offset: '${this.widget.data["value"]}'.length)))),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText:widget.data["tip"],
                    prefixIcon: widget.data["icon"],

                  ),
                ),
              )
            ],
          ),
        );

  }
  bool is_edit(data){

    if(data["is_edit"]){
      return true;
    }
    if(!data["is_edit"] && (data['tag_value'] == null || data['tag_value'] == "")){
      return true;
    }
    return false;
  }

  getInputType(data){
   if(data["type"] == "number"){
     return TextInputType.number;
   }
   return TextInputType.text;
  }
}