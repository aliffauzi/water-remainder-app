import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/Drink%20Analysis/waterDrinkAnalysis.dart';
import 'package:water_remainder/OnBoarding/Model/weightInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/bedTimeInfo.dart';
import 'Model/infoAbout.dart';
import 'Model/wakeUpInfo.dart';

class SlidePageView extends StatefulWidget {
  @override
  _SlidePageViewState createState() => _SlidePageViewState();
}

class _SlidePageViewState extends State<SlidePageView>
    with TickerProviderStateMixin {
  InfoAbout info;
  static const _kDuration = const Duration(milliseconds: 1000);
  static const _kCurve = Curves.decelerate;
  TabController _tabController;
  final PageController pageControllerSlide = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double currentPageValue = 0;
  int waterIntake = 0;
  double weightValue;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    pageControllerSlide.addListener(() {
      setState(() {
        currentPageValue = pageControllerSlide.page;
      });
    });
  }

  @override
  void dispose() {
    pageControllerSlide.dispose();
    _tabController.dispose();
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
                  controller: pageControllerSlide,
                  children: <Widget>[
                    WeightInfo(
                      weightNext: () async {
                        {
                          if (await getWeightValue() != 0 &&
                              await getWeightValue() != null) {
                            pageControllerSlide.nextPage(
                                duration: _kDuration, curve: _kCurve);
                          } else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Weigth cannot be null!")));
                          }
                        }
                      },
                      imagePath: "assets/manweight.png",
                    ),
                    WakeUpInfo(
                      next: () {
                        pageControllerSlide.nextPage(
                            duration: _kDuration, curve: _kCurve);
                      },
                      info: InfoAbout(gender: "male"),
                      imagePath: "assets/maletime.png",
                    ),
                    BedTimeInfo(
                      next: () {
                        maleWaterIntakeAnalysis();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WaterDrinkAnalysis(
                            intakeWater: waterIntake,
                            imagePath: "assets/boywithbottle.jpg",
                          );
                        }));
                      },
                      imagePath: "assets/malebed.png",
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  maleWaterIntakeAnalysis() async {
    if (await getWeightValue() <= 10 && 1 <= await getWeightValue()) {
      setState(() {
        waterIntake = 1200;
      });
    } else if (await getWeightValue() <= 25 && 11 <= await getWeightValue()) {
      setState(() {
        waterIntake = 2500;
      });
    } else if (await getWeightValue() <= 50 && 26 <= await getWeightValue()) {
      setState(() {
        waterIntake = 2800;
      });
    } else if (await getWeightValue() <= 80 && 51 <= await getWeightValue()) {
      setState(() {
        waterIntake = 3500;
      });
    } else if (await getWeightValue() >= 100 && 81 <= await getWeightValue()) {
      setState(() {
        waterIntake = 4300;
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
