import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/history.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/home.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/settings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  TabController _controller;
  int currentPage;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  Future<bool> handleBack() {
    return showDialog(
      context: context,
      builder: (context) => DelayedAnimtion(
        anioffsetX: 0.0,
        anioffsetY: 0.35,
        delayDuration: 0,
        aniDuration: 700,
        widget: AlertDialog(
          title: Text("Confirm Exit"),
          content: Text("Are you sure you want to exit?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                SystemNavigator.pop();
                // Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    return WillPopScope(
      onWillPop: handleBack,
      child: Scaffold(
        backgroundColor: AppThemeColors.themeAccent,
        body: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: <Widget>[
              Home(),
              History(),
              Settings(),
            ]),
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: AppThemeColors.themeAccent,
            color: AppThemeColors.materialTheme,
            buttonBackgroundColor: AppThemeColors.materialTheme,
            onTap: (index) {
              if (index == 0) {
                _controller.animateTo(0);
              }
              if (index == 1) {
                _controller.animateTo(1);
              }
              if (index == 2) {
                _controller.animateTo(2);
              }
            },
            items: <Widget>[
              Icon(Icons.home),
              Icon(Icons.history),
              Icon(Icons.settings)
            ]),
      ),
    );
  }
}
