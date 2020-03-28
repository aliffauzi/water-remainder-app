import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_remainder/Animation/buttonAnimationImplement.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/Drink Analysis/ModelData/drinkData.dart';
import 'package:water_remainder/Drink Analysis/ModelData/analysisData.dart';
import 'package:water_remainder/Main/mainScreen.dart';

class WaterDrinkAnalysis extends StatefulWidget {
  final String imagePath;
  final int intakeWater;
  static int waterIntake;

  const WaterDrinkAnalysis({Key key, this.imagePath, this.intakeWater})
      : super(key: key);
  @override
  _WaterDrinkAnalysisState createState() => _WaterDrinkAnalysisState();
}

class _WaterDrinkAnalysisState extends State<WaterDrinkAnalysis>
    with TickerProviderStateMixin {
  int delayAnimation = 500;
  PageController controller = PageController();
  int currentPage = 0;
  static const _kDuration = const Duration(milliseconds: 1000);
  static const _kCurve = Curves.fastLinearToSlowEaseIn;

  @override
  void initState() {
    super.initState();
    setState(() {
      WaterDrinkAnalysis.waterIntake = widget.intakeWater;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> handleBack() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Exit"),
        content: Text("Are you sure you want to exit?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              // SystemNavigator.pop();
              Navigator.pop(context, true);
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
        body: Stack(
          children: <Widget>[
            PageView.builder(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: drinkData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return AnalaysisData(
                    model: drinkData[index],
                  );
                }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: DelayedAnimtion(
                widget: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top + 20,
                      ),
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(widget.imagePath),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Personal hydration plan",
                              style: TextStyle(
                                  color: AppThemeColors.textMaterial,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "muli",
                                  fontSize: ScreenUtil().setSp(20.0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                anioffsetX: 0.0,
                anioffsetY: 0.35,
                delayDuration: 0,
                aniDuration: 500,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < drinkData.length; i++)
                          if (i == currentPage) ...[circleBar(true)] else
                            circleBar(false),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    currentPage == 2
                        ? Visibility(
                            visible: currentPage == 2 ? true : false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: BottonAnimationImplementation(
                                delayedAni: 500,
                                buttonText: "Done",
                                nextOrPrevious: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MainScreen();
                                  }));
                                },
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: BottonAnimationImplementation(
                              buttonText: "Next",
                              delayedAni: 7200,
                              nextOrPrevious: () {
                                controller.nextPage(
                                    duration: _kDuration, curve: _kCurve);
                              },
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? AppThemeColors.materialTheme : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
