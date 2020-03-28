import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:water_remainder/Animation/buttonAnimationImplement.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';

class BedTimeInfo extends StatefulWidget {
  final String imagePath;
  final Function next;

  const BedTimeInfo({Key key, this.imagePath, this.next}) : super(key: key);
  @override
  _BedTimeInfoState createState() => _BedTimeInfoState();
}

class _BedTimeInfoState extends State<BedTimeInfo> {
  int delayAnimation = 500;
  DateTime _setDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    return Scaffold(
      backgroundColor: AppThemeColors.themeAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Container(
          child: Stack(
            // fit: StackFit.expand,
            children: [
              DelayedAnimtion(
                widget: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top + 20,
                      ),
                      Text(
                        "Your bed time",
                        style: TextStyle(
                            color: AppThemeColors.textMaterial,
                            fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                            fontSize: ScreenUtil().setSp(20.0)),
                      ),
                    ],
                  ),
                ),
                anioffsetX: 0.0,
                anioffsetY: 0.35,
                delayDuration: delayAnimation,
                aniDuration: 700,
              ),
              SingleChildScrollView(
                child: Container(
                  height: ScreenUtil().setHeight(600),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top + 70,
                      ),
                      DelayedAnimtion(
                        anioffsetY: 1.00,
                        anioffsetX: 0.00,
                        delayDuration: delayAnimation + 200,
                        aniDuration: 700,
                        widget: Image.asset(widget.imagePath),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(600),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: DelayedAnimtion(
                        anioffsetY: 1.00,
                        anioffsetX: 0.0,
                        delayDuration: delayAnimation + 400,
                        aniDuration: 700,
                        widget: TimePickerSpinner(
                          is24HourMode: false,
                          normalTextStyle: TextStyle(
                              fontSize: 24, color: AppThemeColors.textMaterial),
                          highlightedTextStyle: TextStyle(
                              fontSize: 24,
                              color: AppThemeColors.materialTheme),
                          spacing: 50,
                          itemHeight: 50,
                          isForce2Digits: true,
                          onTimeChange: (time) {
                            setState(() {
                              _setDate = time;
                              print(_setDate);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  // BottonAnimationImplementation(),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: BottonAnimationImplementation(
                        delayedAni: delayAnimation + 800,
                        buttonText: "Let's Go",
                        nextOrPrevious: widget.next,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
