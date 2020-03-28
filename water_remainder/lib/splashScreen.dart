import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/HomeScreen/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    return Scaffold(
      backgroundColor: AppThemeColors.materialTheme,
      body: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: ScreenUtil().setHeight(350),
                width: ScreenUtil().setWidth(350),
                child: FlareActor(
                  "assets/glassloading1.flr",
                  animation: "sujan",
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  // alignment: Alignment.center,
                ),
              ),
            ),
            Center(
              child: Text(
                "Please wait...",
                style: TextStyle(
                    fontFamily: "muli", fontSize: ScreenUtil().setSp(20)),
              ),
            ),
          ],
        );
      }),
    );
  }
}
