import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/AudioSetting/customDialog.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/AudioSetting/customGender.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/AudioSetting/customWeight.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/audio.dart';

import 'home.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;
  String mode;
  String remindMe;
  String gender;
  double weight;
  int waterIntake;
  var notificationSchedule = [
    "Every one hour",
    "Never",
  ];
  var currentSchedule = "Every one hour";
  @override
  void initState() {
    super.initState();
    initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    SharedPreferences.getInstance().then((onValue) {
      CustomDialog.currentSoundMode = onValue.getString("currentMode");
      print(CustomDialog.currentSoundMode);
      if (CustomDialog.currentSoundMode == null) {
        CustomDialog.currentSoundMode = "As device settings";
      }
      setState(() {
        mode = CustomDialog.currentSoundMode;
      });
    });
    SharedPreferences.getInstance().then((onValue) {
      setState(() {
        weight = onValue.getDouble("doubleValue");
      });
    });
    SharedPreferences.getInstance().then((onValue) {
      gender = onValue.getString('gender');
      print(gender);
      if (gender == "Male") {
        setState(() {
          maleWaterIntakeAnalysis();
        });
      }
      if (gender == "Female") {
        setState(() {
          femaleWaterIntakeAnalysis();
        });
      }
    });
    SharedPreferences.getInstance().then((onValue) {
      remindMe = onValue.getString("schedule");
      if (remindMe == null) {
        setState(() {
          remindMe = "Every one hour";
        });
      }

      if (remindMe == "Every one hour") {
        currentSchedule = "Every one hour";
      }
      if (remindMe == "Never") {
        currentSchedule = "Never";
        print(remindMe);
      }
    });
  }

  Future<bool> dialogPattern() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            onTab: () {
              setClicked();
              if (CustomDialog.isTap1) {
                Navigator.pop(context, true);
                setState(() {
                  setClicked();
                  CustomDialog.currentSoundMode = "As device settings";
                  mode = CustomDialog.currentSoundMode;
                  print(CustomDialog.currentSoundMode);
                  schedulePerformOn();
                });
              }
              if (CustomDialog.isTap2) {
                Navigator.pop(context, true);
                setState(() {
                  setClicked();
                  CustomDialog.currentSoundMode = "Vibration only";
                  mode = CustomDialog.currentSoundMode;
                  schedulePerformOn();
                });
              }
              if (CustomDialog.isTap3) {
                Navigator.pop(context, true);
                setState(() {
                  setClicked();
                  CustomDialog.currentSoundMode = "Vibration and sound";
                  mode = CustomDialog.currentSoundMode;
                  schedulePerformOn();
                });
              }
              if (CustomDialog.isTap4) {
                Navigator.pop(context, true);
                setState(() {
                  setClicked();
                  CustomDialog.currentSoundMode = "Display only";
                  mode = CustomDialog.currentSoundMode;
                  schedulePerformOn();
                });
              }
              if (CustomDialog.isTap5) {
                Navigator.pop(context, true);
                setState(() {
                  setClicked();
                  CustomDialog.currentSoundMode = "Notification off";
                  mode = CustomDialog.currentSoundMode;
                  schedulePerformOn();
                });
              }
            },
          );
        });
  }

  Future<bool> customWeighthandle() {
    showDialog(
      context: context,
      builder: (context) => CustomWeight(
        onTab: () {
          SharedPreferences.getInstance().then((onValue) {
            Navigator.pop(context, true);
            var a = onValue.getDouble('doubleValue');
            if (gender == "Male") {
              setState(() {
                weight = a;
                maleWaterIntakeAnalysis();
                print(gender);
              });
            }
            if (gender == "Female") {
              setState(() {
                weight = a;
                femaleWaterIntakeAnalysis();
                print(gender);
              });
            }
          });
        },
      ),
    );
  }

  Future<bool> customGenderthandle() {
    showDialog(
      context: context,
      builder: (context) => CustomGender(
        male: () {
          Navigator.pop(context, true);
          maleWaterIntakeAnalysis();
          setState(() {
            gender = "Male";
            setGender();
          });
        },
        feMale: () {
          Navigator.pop(context, true);
          femaleWaterIntakeAnalysis();
          setState(() {
            gender = "Female";
            setGender();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    return Scaffold(
        backgroundColor: AppThemeColors.themeAccent,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top + 20,
              ),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    color: AppThemeColors.themeAccent,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(-3, -3),
                        color: AppThemeColors.textMaterial.withOpacity(.1),
                      ),
                      BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(3, 3),
                        color: Colors.black26,
                      )
                    ],
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FlareActor(
                    "assets/setting.flr",
                    animation: "rotating",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Settings",
                style: TextStyle(
                    color: AppThemeColors.textMaterial,
                    fontWeight: FontWeight.bold,
                    fontFamily: "muli",
                    fontSize: ScreenUtil().setSp(20.0)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(
                  thickness: 2,
                  color: AppThemeColors.materialTheme.withOpacity(0.5),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Remind me",
                        style: TextStyle(
                            color: AppThemeColors.textMaterial,
                            // fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                            fontSize: ScreenUtil().setSp(15.0)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: AppThemeColors.themeAccent,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3.0,
                                offset: Offset(-3, -3),
                                color:
                                    AppThemeColors.textMaterial.withOpacity(.1),
                              ),
                              BoxShadow(
                                  blurRadius: 3.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black26)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: FittedBox(
                            child: DropdownButton<String>(
                              underline: Container(
                                width: double.infinity,
                                color: AppThemeColors.themeAccent,
                              ),
                              elevation: 8,
                              iconEnabledColor: AppThemeColors.textMaterial,
                              items: notificationSchedule
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppThemeColors.themeAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FittedBox(
                                          child: Text(
                                            dropDownStringItem,
                                            style: TextStyle(
                                                color:
                                                    AppThemeColors.textMaterial,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "muli",
                                                fontSize:
                                                    ScreenUtil().setSp(15.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  value: dropDownStringItem,
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  currentSchedule = newValue;
                                  remindMe = currentSchedule;
                                  print(remindMe);
                                  setNotificationSchedule();
                                  schedulePerformOn();
                                });
                              },
                              value: currentSchedule,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          dialogPattern();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Remainder mode",
                              style: TextStyle(
                                  color: AppThemeColors.textMaterial,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: "muli",
                                  fontSize: ScreenUtil().setSp(15.0)),
                            ),
                            FittedBox(
                              child: Text(
                                "${CustomDialog.currentSoundMode}",
                                style: TextStyle(
                                    color: AppThemeColors.textMaterial,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "muli",
                                    fontSize: ScreenUtil().setSp(15.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "General info",
                        style: TextStyle(
                            color: AppThemeColors.textMaterial.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                            fontSize: ScreenUtil().setSp(20.0)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 2,
                        color: AppThemeColors.materialTheme.withOpacity(0.5),
                      ),
                      InkWell(
                        onTap: () {
                          customWeighthandle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Your weight",
                              style: TextStyle(
                                  color: AppThemeColors.textMaterial,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: "muli",
                                  fontSize: ScreenUtil().setSp(15.0)),
                            ),
                            FittedBox(
                              child: Text(
                                "$weight KG",
                                style: TextStyle(
                                    color: AppThemeColors.textMaterial,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "muli",
                                    fontSize: ScreenUtil().setSp(15.0)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Intake water",
                      style: TextStyle(
                          color: AppThemeColors.textMaterial,
                          // fontWeight: FontWeight.bold,
                          fontFamily: "muli",
                          fontSize: ScreenUtil().setSp(15.0)),
                    ),
                    FittedBox(
                      child: Text(
                        "$waterIntake ML",
                        style: TextStyle(
                            color: AppThemeColors.textMaterial,
                            fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                            fontSize: ScreenUtil().setSp(15.0)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  onTap: () {
                    customGenderthandle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Your gender",
                        style: TextStyle(
                            color: AppThemeColors.textMaterial,
                            // fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                            fontSize: ScreenUtil().setSp(15.0)),
                      ),
                      FittedBox(
                        child: FittedBox(
                          child: Text(
                            "$gender",
                            style: TextStyle(
                                color: AppThemeColors.textMaterial,
                                fontWeight: FontWeight.bold,
                                fontFamily: "muli",
                                fontSize: ScreenUtil().setSp(15.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future setClicked() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("currentMode", CustomDialog.currentSoundMode);
  }

  maleWaterIntakeAnalysis() async {
    if (weight <= 10 && 1 <= weight) {
      setState(() {
        waterIntake = 1200;
      });
    } else if (weight <= 25 && 11 <= weight) {
      setState(() {
        waterIntake = 2500;
      });
    } else if (weight <= 50 && 26 <= weight) {
      setState(() {
        waterIntake = 2800;
      });
    } else if (weight <= 80 && 51 <= weight) {
      setState(() {
        waterIntake = 3500;
      });
    } else if (weight >= 100 && 81 <= weight) {
      setState(() {
        waterIntake = 4300;
      });
    } else {
      setState(() {
        waterIntake = 5000;
      });
    }
  }

  femaleWaterIntakeAnalysis() async {
    if (weight <= 10 && 1 <= weight) {
      setState(() {
        waterIntake = 1000;
      });
    } else if (weight <= 25 && 11 <= weight) {
      setState(() {
        waterIntake = 2200;
      });
    } else if (weight <= 50 && 26 <= weight) {
      setState(() {
        waterIntake = 2500;
      });
    } else if (weight <= 80 && 51 <= weight) {
      setState(() {
        waterIntake = 3000;
      });
    } else if (weight >= 100 && 81 <= weight) {
      setState(() {
        waterIntake = 4000;
      });
    } else {
      setState(() {
        waterIntake = 5000;
      });
    }
  }

  Future setGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var a = preferences.setString('gender', gender);
    return a;
  }

  Future setNotificationSchedule() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var a = preferences.setString("schedule", currentSchedule);
    return a;
  }

  void schedulePerformOn() {
    if (remindMe == "Every one hour" && mode == "As device settings") {
      _showNotificationAsDevice();
    }
    if (remindMe == "Every one hour" && mode == "Vibration only") {
      _showNotificationVibrationOnly();
    }
    if (remindMe == "Every one hour" && mode == "Vibration and sound") {
      _showNotificationVibratioAndSound();
    }
    if (remindMe == "Every one hour" && mode == "Display only") {
      _showNotificationDisplayOnly();
    }
    if (remindMe == "Every one hour" && mode == "Notification off") {
      return null;
    }
    if (remindMe == "Never") {
      return null;
    } else {
      return null;
    }
  }

  void _showNotificationAsDevice() async {
    await _demoNotification1();
  }

  void _showNotificationVibrationOnly() async {
    await _demoNotification2();
  }

  void _showNotificationVibratioAndSound() async {
    await _demoNotification3();
  }

  void _showNotificationDisplayOnly() async {
    await _demoNotification4();
  }

  Future<void> _demoNotification1() async {
    var notificationTime = DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Hello there',
        "It's time to drink water", notificationTime, platformChannelSpecifics);
  }

  Future<void> _demoNotification2() async {
    var notificationTime = DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'vibration channel id',
        'vibration  channel name',
        'vibration  channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker',
        playSound: false,
        enableVibration: true,
        style: AndroidNotificationStyle.Default);

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(1, 'Hello there',
        "It's time to drink water", notificationTime, platformChannelSpecifics);
  }

  Future<void> _demoNotification3() async {
    var notificationTime = DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'vibration and sound channel id',
        'vibration and sound channel name',
        'vibration and sound channel description',
        importance: Importance.Max,
        priority: Priority.High,
        playSound: true,
        enableVibration: true,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(2, 'Hello there',
        "It's time to drink water", notificationTime, platformChannelSpecifics);
  }

  Future<void> _demoNotification4() async {
    var notificationTime = DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'display channel id',
        'display  channel name',
        'display channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker',
        playSound: false,
        enableVibration: false,
        style: AndroidNotificationStyle.Default);

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(3, 'Hello there',
        "It's time to drink water", notificationTime, platformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Home()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                )
              ],
            ));
  }
}
