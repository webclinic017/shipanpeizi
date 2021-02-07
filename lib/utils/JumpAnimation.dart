

import 'package:flutter/cupertino.dart';

class JumpAnimation{
  JumpAnimation();
  void jump(StatefulWidget statefulWidget,BuildContext context){
    Navigator.of(context).push(new PageRouteBuilder(pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return statefulWidget;
    },transitionsBuilder: (

        BuildContext context,

        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      // 添加一个平移动画
      return createTransition(animation, child);
    },transitionDuration: const Duration(milliseconds: 350)
    )

    );
  }
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child, // child is the value returned by pageBuilder
    );
  }
}