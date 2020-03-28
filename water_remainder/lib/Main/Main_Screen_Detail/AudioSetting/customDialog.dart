import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/settings.dart';

class CustomDialog extends StatefulWidget {
  static String currentSoundMode;
  static bool isTap1 = false;
  static bool isTap2 = false;
  static bool isTap3 = false;
  static bool isTap4 = false;
  static bool isTap5 = false;
  final Function onTab;

  const CustomDialog({Key key, this.onTab}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Settings settings = Settings();
  Color color = AppThemeColors.themeAccent;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((onValue) {
      CustomDialog.currentSoundMode = onValue.getString("currentMode");
      print(CustomDialog.currentSoundMode);
      setState(() {
        upadateSound();
      });
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
      aniDuration: 700,
      widget: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)), //this right here
        child: Container(
          width: double.infinity,
          height: 310,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          color: CustomDialog.isTap1
                              ? AppThemeColors.themeAccent
                              : null,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              CustomDialog.isTap1 = !CustomDialog.isTap1;
                              CustomDialog.isTap2 = false;
                              CustomDialog.isTap3 = false;
                              CustomDialog.isTap4 = false;
                              CustomDialog.isTap5 = false;
                            });
                          },
                          child: Text(
                            "As device settings",
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "muli",
                                fontSize: ScreenUtil().setSp(20.0)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.vibration,
                          color: CustomDialog.isTap2
                              ? AppThemeColors.themeAccent
                              : null,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              CustomDialog.isTap2 = !CustomDialog.isTap2;
                              CustomDialog.isTap1 = false;
                              CustomDialog.isTap3 = false;
                              CustomDialog.isTap4 = false;
                              CustomDialog.isTap5 = false;
                            });
                          },
                          child: Text(
                            "Vibration only",
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "muli",
                                fontSize: ScreenUtil().setSp(20.0)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.surround_sound,
                          color: CustomDialog.isTap3
                              ? AppThemeColors.themeAccent
                              : null,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              CustomDialog.isTap3 = !CustomDialog.isTap3;
                              CustomDialog.isTap1 = false;
                              CustomDialog.isTap2 = false;
                              CustomDialog.isTap4 = false;
                              CustomDialog.isTap5 = false;
                            });
                          },
                          child: Text(
                            "Vibration and sound",
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "muli",
                                fontSize: ScreenUtil().setSp(20.0)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.tv,
                          color: CustomDialog.isTap4
                              ? AppThemeColors.themeAccent
                              : null,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              CustomDialog.isTap4 = !CustomDialog.isTap4;
                              CustomDialog.isTap2 = false;
                              CustomDialog.isTap3 = false;
                              CustomDialog.isTap1 = false;
                              CustomDialog.isTap5 = false;
                            });
                          },
                          child: Text(
                            "Display only",
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "muli",
                                fontSize: ScreenUtil().setSp(20.0)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.notifications_off,
                          color: CustomDialog.isTap5
                              ? AppThemeColors.themeAccent
                              : null,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              CustomDialog.isTap5 = !CustomDialog.isTap5;
                              CustomDialog.isTap2 = false;
                              CustomDialog.isTap3 = false;
                              CustomDialog.isTap4 = false;
                              CustomDialog.isTap1 = false;
                            });
                          },
                          child: Text(
                            "Notification off",
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "muli",
                                fontSize: ScreenUtil().setSp(20.0)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Center(
                            child: Text("cancel",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: "muli",
                                    fontSize: ScreenUtil().setSp(20.0))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: widget.onTab,
                          child: Container(
                            height: ScreenUtil().setHeight(200),
                            width: ScreenUtil().setWidth(100),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: AppThemeColors.themeAccent),
                            alignment: Alignment.bottomRight,
                            child: Center(
                              child: Text("OK",
                                  style: TextStyle(
                                      color: AppThemeColors.textMaterial,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: "muli",
                                      fontSize: ScreenUtil().setSp(20.0))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  upadateSound() async {
    if (await getClicked() == "As device settings") {
      setState(() {
        CustomDialog.isTap1 = true;
        CustomDialog.isTap2 = false;
        CustomDialog.isTap3 = false;
        CustomDialog.isTap4 = false;
        CustomDialog.isTap5 = false;
      });
    } else if (await getClicked() == "Vibration only") {
      setState(() {
        CustomDialog.isTap2 = true;
        CustomDialog.isTap1 = false;
        CustomDialog.isTap3 = false;
        CustomDialog.isTap4 = false;
        CustomDialog.isTap5 = false;
      });
    } else if (await getClicked() == "Vibration and sound") {
      setState(() {
        CustomDialog.isTap3 = true;
        CustomDialog.isTap1 = false;
        CustomDialog.isTap2 = false;
        CustomDialog.isTap4 = false;
        CustomDialog.isTap5 = false;
      });
    } else if (await getClicked() == "Display only") {
      setState(() {
        CustomDialog.isTap4 = true;
        CustomDialog.isTap1 = false;
        CustomDialog.isTap2 = false;
        CustomDialog.isTap3 = false;
        CustomDialog.isTap5 = false;
      });
    } else if (await getClicked() == "Mute") {
      setState(() {
        CustomDialog.isTap5 = true;
        CustomDialog.isTap1 = false;
        CustomDialog.isTap2 = false;
        CustomDialog.isTap3 = false;
        CustomDialog.isTap4 = false;
      });
    } else if (await getClicked() == null) {
      setState(() {
        CustomDialog.isTap1 = true;
        CustomDialog.isTap2 = false;
        CustomDialog.isTap3 = false;
        CustomDialog.isTap4 = false;
        CustomDialog.isTap5 = false;
      });
    }
  }

  Future<String> getClicked() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String a = preferences.getString("currentMode");
    return a;
  }
}
