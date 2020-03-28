import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_remainder/Main/Main_Screen_Detail/home.dart';

class Audio extends StatefulWidget {
  void showNotification() {}

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;
  // int delayedNotification;
  String mode;
  String remindMe;

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

    // SharedPreferences.getInstance().then((onValue) {
    //   var a = onValue.getString("schedule");
    //   if (a == "Default") {
    //     setState(() {
    //       delayedNotification = 5;
    //     });
    //   }
    //   if (a == "Choose") {
    //     setState(() {
    //       delayedNotification = 5;
    //     });
    //   }
    // });

    SharedPreferences.getInstance().then((onValue) {
      var a = onValue.getString("currentMode");
      if (a == null) {
        setState(() {
          mode = "As device settings";
        });
      } else {
        setState(() {
          mode = a;
        });
      }
      // setState(() {
      //   mode = a;
      // });
      // print(mode);
      // if (mode == "As device settings") {
      //   _showNotificationAsDevice();
      // }
      // if (mode == "Vibration only") {
      //   _showNotificationVibrationOnly();
      // }
      // if (mode == "Vibration and sound") {
      //   _showNotificationVibratioAndSound();
      // }
      // if (mode == "Display only") {
      //   _showNotificationDisplayOnly();
      // }
      // if (mode == "Notification off") {
      //   return null;
      // }
    });

    SharedPreferences.getInstance().then((onValue) {
      remindMe = onValue.getString("schedule");
      if (remindMe == null) {
        setState(() {
          remindMe = "Every one hour";
        });
      }
      if (remindMe == "Every one hour") {
        _showNotificationAsDevice();
      }
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
      }
    });
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
    var notificationTime =
        DateTime.now().add(Duration(seconds: 5));
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
    var notificationTime =
        DateTime.now().add(Duration(seconds: 5));
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
    var notificationTime =
        DateTime.now().add(Duration(seconds: 5));
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
    var notificationTime =
        DateTime.now().add(Duration(seconds: 5));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _showNotificationAsDevice,
        //   child: Icon(Icons.notifications),
        // ),
        // body: Container(),
        );
  }
}
