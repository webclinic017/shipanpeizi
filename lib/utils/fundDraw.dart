// 为了简单，里面一切处理没写，可以参照官方的，或者把官方的拷贝过来，在官方的基础上进行修改，都是可以的
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fundDraw extends StatelessWidget {

  final double elevation;
  final Widget child;
  final String semanticLabel;
  final double widthPercent;
  const fundDraw({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
    this.widthPercent = 0.7,
  })  : assert(
  widthPercent != null && widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    final double _width = MediaQuery.of(context).size.width * widthPercent;
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,

      child: ConstrainedBox(

        constraints: BoxConstraints.expand(width: _width),
        child: Material(

          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}




