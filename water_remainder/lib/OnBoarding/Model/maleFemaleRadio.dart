import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_remainder/Animation/buttonAnimationImplement.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/OnBoarding/Model/weightInfo.dart';
import '../maleSlidePageView.dart';
import 'femaleSlideView.dart';

class MaleFemaleRadio extends StatefulWidget {
  final Function onTabFemale;
  final Function onTabMale;

  const MaleFemaleRadio({
    this.onTabFemale,
    this.onTabMale,
  });
  @override
  _MaleFemaleRadioState createState() => _MaleFemaleRadioState();
}

class _MaleFemaleRadioState extends State<MaleFemaleRadio> {
  WeightInfo info = WeightInfo();
  int delayAnimation = 500;
  SlidePageView slidePageView = new SlidePageView();
  int currentTabpage = 0;
  String gender;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    return Scaffold(
        backgroundColor: AppThemeColors.themeAccent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
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
                        "Your Gender",
                        style: TextStyle(
                            color: AppThemeColors.textMaterial,
                            fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                            fontSize: ScreenUtil().setSp(20.0)),
                      ),
                    ],
                  ),
                ),
                anioffsetX: -1.35,
                anioffsetY: 0.00,
                delayDuration: delayAnimation,
                aniDuration: 700,
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).viewPadding.top + 50,
                    ),
                    DelayedAnimtion(
                      anioffsetX: -1.35,
                      anioffsetY: 0.00,
                      delayDuration: delayAnimation + 200,
                      aniDuration: 700,
                      widget: Container(
                        height: ScreenUtil().setHeight(320),
                        width: ScreenUtil().setHeight(300),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: ScreenUtil().setHeight(100),
                              backgroundColor: Colors.red,
                              backgroundImage: AssetImage(
                                "assets/boywithbottle.jpg",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: BottonAnimationImplementation(
                                delayedAni: delayAnimation + 1000,
                                buttonText: "Male",
                                nextOrPrevious: () {
                                  setState(() {
                                    gender = "Male";
                                    setGender();
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SlidePageView();
                                  }));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DelayedAnimtion(
                      anioffsetX: -1.35,
                      anioffsetY: 0.00,
                      delayDuration: delayAnimation + 400,
                      aniDuration: 700,
                      widget: Container(
                        height: ScreenUtil().setHeight(320),
                        width: ScreenUtil().setHeight(300),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: ScreenUtil().setHeight(100),
                              backgroundColor: Colors.red,
                              backgroundImage: AssetImage(
                                "assets/girlwithbottle.png",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: BottonAnimationImplementation(
                                delayedAni: delayAnimation + 1200,
                                buttonText: "Female",
                                nextOrPrevious: () {
                                  setState(() {
                                    setGender();
                                    gender = "Female";
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FemaleSlidePageView();
                                  }));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future setGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var a = preferences.setString('gender', gender);
    return a;
  }
}
