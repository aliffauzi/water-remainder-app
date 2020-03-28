import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/Drink%20Analysis/waterDrinkAnalysis.dart';
import 'package:water_remainder/OnBoarding/Model/bedTimeInfo.dart';
import 'package:water_remainder/OnBoarding/Model/infoAbout.dart';
import 'package:water_remainder/OnBoarding/Model/wakeUpInfo.dart';
import 'package:water_remainder/OnBoarding/Model/weightInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FemaleSlidePageView extends StatefulWidget {
  @override
  _FemaleSlidePageViewState createState() => _FemaleSlidePageViewState();
}

class _FemaleSlidePageViewState extends State<FemaleSlidePageView>
    with TickerProviderStateMixin {
  static const _kDuration = const Duration(milliseconds: 1000);
  static const _kCurve = Curves.decelerate;
  final PageController pageControllerSlide = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  InfoAbout about;
  double d;
  int delayedAmount = 500;
  bool isPressed = false;
  int waterIntake = 0;
  int currentPageValue = 0;
  @override
  void initState() {
    super.initState();
    print(getWeightValue().then((onValue) {
      var a = onValue;
      setState(() {
        d = a;
        print(d);
      });
    }));
  }

  @override
  void dispose() {
    pageControllerSlide.dispose();
    super.dispose();
  }

  Future<bool> handleBack() {
    currentPageValue == 0
        ? Navigator.pop(context, true)
        : pageControllerSlide.previousPage(
            duration: _kDuration, curve: _kCurve);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: false);

    return WillPopScope(
      onWillPop: handleBack,
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppThemeColors.themeAccent,
          body: Column(
            // fit: StackFit.expand,
            children: <Widget>[
              Flexible(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  onPageChanged: (index) {
                    currentPageValue = index;
                    print(currentPageValue);
                  },
                  controller: pageControllerSlide,
                  children: <Widget>[
                    WeightInfo(
                      weightNext: () async {
                        if (await getWeightValue() != 0 &&
                            await getWeightValue() != null) {
                          pageControllerSlide.nextPage(
                              duration: _kDuration, curve: _kCurve);
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: "Ok",
                                onPressed: () {
                                  _scaffoldKey.currentState
                                      .hideCurrentSnackBar();
                                },
                              ),
                              content: Text("Weigth cannot be null or zero")));
                        }
                      },
                      imagePath: "assets/femaleweight.png",
                    ),
                    WakeUpInfo(
                      next: () {
                        pageControllerSlide.nextPage(
                            duration: _kDuration, curve: _kCurve);
                      },
                      info: about = InfoAbout(gender: "female"),
                      imagePath: "assets/femaletime.png",
                    ),
                    BedTimeInfo(
                      imagePath: "assets/femalebed.png",
                      next: () {
                        femaleWaterIntakeAnalysis();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WaterDrinkAnalysis(
                            intakeWater: waterIntake,
                            imagePath: "assets/girlwithbottle.png",
                          );
                        }));
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  femaleWaterIntakeAnalysis() async {
    if (await getWeightValue() <= 10 && 1 <= await getWeightValue()) {
      setState(() {
        waterIntake = 1000;
      });
    } else if (await getWeightValue() <= 25 && 11 <= await getWeightValue()) {
      setState(() {
        waterIntake = 2200;
      });
    } else if (await getWeightValue() <= 50 && 26 <= await getWeightValue()) {
      setState(() {
        waterIntake = 2500;
      });
    } else if (await getWeightValue() <= 80 && 51 <= await getWeightValue()) {
      setState(() {
        waterIntake = 3000;
      });
    } else if (await getWeightValue() >= 100 && 81 <= await getWeightValue()) {
      setState(() {
        waterIntake = 4000;
      });
    } else {
      setState(() {
        waterIntake = 5000;
      });
    }
  }

  Future<double> getWeightValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var a = prefs.getDouble("doubleValue");
    return a;
  }
}
