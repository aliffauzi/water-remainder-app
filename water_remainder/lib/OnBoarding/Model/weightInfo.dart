import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:water_remainder/Animation/buttonAnimationImplement.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';

class WeightInfo extends StatefulWidget {
  final String imagePath;
  final Function weightNext;

  const WeightInfo({
    Key key,
    this.imagePath,
    this.weightNext,
  }) : super(key: key);
  @override
  _WeightInfoState createState() => _WeightInfoState();
}

class _WeightInfoState extends State<WeightInfo> {
  String imagePath = "";
  int delayAnimation = 500;
  double spinner = 0;
  bool isMaleImagedOpened = false;

  @override
  void initState() {
    super.initState();
  }

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
                        "Your Weight",
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
                  height: ScreenUtil().setHeight(720),
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
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Center(
                        child: FittedBox(
                          child: Container(
                            child: DelayedAnimtion(
                              anioffsetY: 1.00,
                              anioffsetX: 0.0,
                              delayDuration: delayAnimation + 400,
                              aniDuration: 700,
                              widget: SpinnerInput(
                                spinnerValue: spinner,
                                middleNumberPadding: const EdgeInsets.all(20),
                                middleNumberWidth: ScreenUtil().setWidth(100),
                                middleNumberStyle: TextStyle(
                                    color: AppThemeColors.textMaterial,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "muli",
                                    fontSize: 20.0),
                                popupTextStyle: TextStyle(
                                    fontFamily: "muli",
                                    fontSize: ScreenUtil().setSp(20.0)),
                                popupButton: SpinnerButtonStyle(
                                    elevation: 8.0,
                                    height: 50.0,
                                    width: 50.0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                minusButton: SpinnerButtonStyle(
                                    child: Icon(
                                      FontAwesomeIcons.minus,
                                      color: Color(0xFF009ef6),
                                      size: ScreenUtil().setSp(20.0),
                                    ),
                                    color: Color(0xFFF4F4F4),
                                    elevation: 8.0,
                                    height: ScreenUtil().setHeight(50.0),
                                    width: ScreenUtil().setWidth(100)),
                                plusButton: SpinnerButtonStyle(
                                    child: Icon(
                                      FontAwesomeIcons.plus,
                                      color: Color(0xFF009ef6),
                                      size: 20.0,
                                    ),
                                    elevation: 8.0,
                                    color: Color(0xFFF4F4F4),
                                    height: ScreenUtil().setHeight(50.0),
                                    width: ScreenUtil().setWidth(100)),
                                minValue: 0,
                                maxValue: 400,
                                onChange: onValueChanged,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: BottonAnimationImplementation(
                            delayedAni: delayAnimation + 800,
                            buttonText: "Next",
                            nextOrPrevious: widget.weightNext),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 700,
              //   child: Container(
              //     alignment: Alignment.bottomCenter,
              //     child: BottonAnimationImplementation(
              //         delayedAni: delayAnimation + 600,
              //         buttonText: "Next",
              //         nextOrPrevious: widget.weightNext),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  onValueChanged(double newValue) {
    spinner = newValue;
    setWeightValue();
    print(spinner);
    setState(() {
      spinner = newValue;
    });
  }

  Future<Null> setWeightValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('doubleValue', spinner);
  }
}
