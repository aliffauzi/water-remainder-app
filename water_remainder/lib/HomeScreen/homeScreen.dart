import 'package:avatar_glow/avatar_glow.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_remainder/Animation/buttonAnimation.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/OnBoarding/Model/maleFemaleRadio.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _animationController;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  void onPressedUp(PointerUpEvent event) {
    setState(() {
      isPressed = false;
    });
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() {
      isPressed = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 0.986;
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    return Scaffold(
      backgroundColor: AppThemeColors.themeAccent,
      body: Builder(builder: (context) {
        final data = MediaQuery.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top + 20,
                ),
                Center(
                  heightFactor: 1.1,
                  child: Column(
                    children: <Widget>[
                      AvatarGlow(
                        endRadius: 100.0,
                        duration: Duration(milliseconds: 2000),
                        glowColor: Colors.white24,
                        repeat: true,
                        repeatPauseDuration: Duration(seconds: 2),
                        startDelay: Duration(seconds: 1),
                        child: Material(
                          elevation: 8.0,
                          shadowColor: Colors.black,
                          shape: CircleBorder(),
                          child: Container(
                            height: data.size.height / 6,
                            width: data.size.width / 3,
                            child: CircleAvatar(
                              backgroundColor: AppThemeColors.materialTheme,
                              child: FlareActor("assets/waterBody.flr",
                                  animation: "waterFalling"),
                            ),
                          ),
                        ),
                      ),
                      DelayedAnimtion(
                        widget: Text(
                          "Hello there",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "muli",
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(20.0)),
                        ),
                        delayDuration: delayedAmount,
                        anioffsetX: 0.0,
                        anioffsetY: 0.35,
                        aniDuration: 700,
                      ),
                      DelayedAnimtion(
                        widget: Text(
                          "Did you drink water today ?",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "muli",
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(20.0)),
                        ),
                        delayDuration: delayedAmount + 200,
                        anioffsetX: 0.0,
                        anioffsetY: 0.35,
                        aniDuration: 700,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      DelayedAnimtion(
                        widget: Center(
                          child: Text(
                            "Here daily you can",
                            style: TextStyle(
                                color: AppThemeColors.textMaterial
                                    .withOpacity(0.5),
                                fontFamily: "muli",
                                fontSize: ScreenUtil().setSp(20.0)),
                          ),
                        ),
                        delayDuration: delayedAmount + 600,
                        anioffsetX: 0.0,
                        anioffsetY: 0.35,
                        aniDuration: 700,
                      ),
                      DelayedAnimtion(
                        widget: Center(
                          child: Text(
                            "keep yourself hydrated",
                            style: TextStyle(
                                color: AppThemeColors.textMaterial
                                    .withOpacity(0.5),
                                fontFamily: "muli",
                                fontSize: ScreenUtil().setSp(20.0)),
                          ),
                        ),
                        delayDuration: delayedAmount + 800,
                        anioffsetX: 0.0,
                        anioffsetY: 0.35,
                        aniDuration: 700,
                      ),
                      SizedBox(height: data.viewPadding.bottom + 200),
                      ButtonAnimation(
                        delayTime: delayedAmount + 1200,
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print(data.size.height);
                              print(data.size.width);
                              !ButtonAnimation.disableButton
                                  ? Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                      return MaleFemaleRadio();
                                    }))
                                  : null;
                            },
                            child: Listener(
                              onPointerUp: onPressedUp,
                              onPointerDown: onPressedDown,
                              child: isPressed
                                  ? Transform.scale(
                                      scale: _scale,
                                      child: Container(
                                        width: double.infinity,
                                        height: ScreenUtil().setHeight(60),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 3.0,
                                              offset: Offset(0, 4),
                                            )
                                          ],
                                          color: AppThemeColors.materialTheme,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Let's drink from today",
                                          style: TextStyle(
                                              color: AppThemeColors.themeAccent,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0,
                                              fontFamily: "muli",
                                              fontSize:
                                                  ScreenUtil().setSp(20.0)),
                                        )),
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: ScreenUtil().setHeight(60),
                                      decoration: BoxDecoration(
                                          color: AppThemeColors.materialTheme,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 5.0,
                                              offset: Offset(0, 10),
                                            )
                                          ]),
                                      child: Center(
                                          child: Text(
                                        "Let's drink from today",
                                        style: TextStyle(
                                            color: AppThemeColors.themeAccent,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "muli",
                                            letterSpacing: 1.0,
                                            fontSize: ScreenUtil().setSp(20.0)),
                                      )),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
