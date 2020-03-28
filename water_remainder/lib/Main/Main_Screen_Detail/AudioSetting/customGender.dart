import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_remainder/Animation/buttonAnimationImplement.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';

class CustomGender extends StatefulWidget {
  final Function male;
  final Function feMale;

  const CustomGender({Key key, this.male, this.feMale}) : super(key: key);
  @override
  _CustomGenderState createState() => _CustomGenderState();
}

class _CustomGenderState extends State<CustomGender> {
  String gender;
  int delayAnimation = 500;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((onValue) {
      var a = onValue.getString('gender');
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    return DelayedAnimtion(
      anioffsetX: 0.0,
      anioffsetY: 1.35,
      delayDuration: 0,
      aniDuration: 1000,
      widget: Dialog(
        backgroundColor: AppThemeColors.themeAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)), //this right here
        child: FittedBox(
          child: Column(
            children: <Widget>[
              DelayedAnimtion(
                anioffsetX: -1.35,
                anioffsetY: 0.00,
                delayDuration: delayAnimation,
                aniDuration: 700,
                widget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your gender",
                    style: TextStyle(
                        color: AppThemeColors.materialTheme,
                        fontFamily: "muli",
                        fontSize: ScreenUtil().setSp(20.0)),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top + 10,
              ),
              DelayedAnimtion(
                anioffsetX: -1.35,
                anioffsetY: 0.00,
                delayDuration: delayAnimation + 200,
                aniDuration: 700,
                widget: Container(
                  height: 220,
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red,
                        backgroundImage: AssetImage(
                          "assets/boywithbottle.jpg",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: BottonAnimationImplementation(
                            delayedAni: delayAnimation + 1000,
                            buttonText: "Male",
                            nextOrPrevious: widget.male),
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
                  height: 220,
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red,
                        backgroundImage: AssetImage(
                          "assets/girlwithbottle.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: BottonAnimationImplementation(
                            delayedAni: delayAnimation + 1200,
                            buttonText: "Female",
                            nextOrPrevious: widget.feMale),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
