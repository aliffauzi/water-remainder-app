import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/CustomPainter/circlularProgess.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    animation = Tween<double>(begin: 0, end: 80).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColors.themeAccent,
      body: Column(
        children: <Widget>[
          Center(
            child: CustomPaint(
              foregroundPainter: CirclePainter(animation.value),
              child: Container(
                height: 200,
                width: 200,
                child: InkWell(
                  onTap: () {
                    if (animation.value != 80) {
                      controller.forward();
                    } else
                      controller.repeat();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
