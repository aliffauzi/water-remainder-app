import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizedAnim extends StatefulWidget {
  final Widget child;
  final int delayDuration;

  const SizedAnim({Key key, this.child, this.delayDuration}) : super(key: key);

  @override
  _SizedAnimState createState() => _SizedAnimState();
}

class _SizedAnimState extends State<SizedAnim> with TickerProviderStateMixin {
  AnimationController _controller;
  double h = 0;
  double w = double.infinity;
  double h1;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 0), () {
      setState(() {
        h = 280;
        w = double.infinity;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    h1 = ScreenUtil().setHeight(h);
    return AnimatedSize(
        vsync: this,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInCubic,
        child: Container(
          height: h1,
          width: w,
          child: widget.child,
        ));
  }
}
