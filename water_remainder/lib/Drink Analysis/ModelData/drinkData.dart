import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_remainder/Animation/sizedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';
import 'package:water_remainder/Drink%20Analysis/ModelData/reportModel.dart';
import '../waterDrinkAnalysis.dart';

List<ReportModel> drinkData = [
  ReportModel(
    durationTitle: 200,
    durationSubTitle: 6100,
    title: Text(
      "Analysing your proper water intake",
      style: TextStyle(
          color: AppThemeColors.textMaterial,
          // fontWeight: FontWeight.bold,
          fontFamily: "muli",
          fontSize: ScreenUtil().setSp(20.0)),
    ),
    subTitle: Text(
      "${WaterDrinkAnalysis.waterIntake} ML",
      style: TextStyle(
          color: AppThemeColors.textMaterial,
          // fontWeight: FontWeight.bold,
          fontFamily: "muli",
          fontSize: ScreenUtil().setSp(20.0)),
    ),
    chlid: Stack(
      children: <Widget>[
        SizedAnim(
          child: FlareActor(
            "assets/liquidSwap.flr",
            fit: BoxFit.cover,
            animation: "Demo",
          ),
        ),
      ],
    ),
  ),
  ReportModel(
      durationTitle: 200,
      durationSubTitle: 500,
      title: Text(
        "How to effectively monitor",
        style: TextStyle(
            color: AppThemeColors.textMaterial,
            // fontWeight: FontWeight.bold,
            fontFamily: "muli",
            fontSize: ScreenUtil().setSp(20.0)),
      ),
      subTitle: Text(
        "Check your hydration and see your ratio",
        style: TextStyle(
            color: AppThemeColors.textMaterial,
            // fontWeight: FontWeight.bold,
            fontFamily: "muli",
            fontSize: ScreenUtil().setSp(18.0)),
      ),
      chlid: Stack(
        children: <Widget>[
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: SizedAnim(
                child: Image.asset(
                  "assets/bargraph.png",
                  fit: BoxFit.contain,
                  // animation: "Demo",
                ),
              ),
            ),
          ),
        ],
      )),
  ReportModel(
      durationSubTitle: 200,
      durationTitle: 500,
      title: Text(
        "Get Notification",
        style: TextStyle(
            color: AppThemeColors.textMaterial,
            // fontWeight: FontWeight.bold,
            fontFamily: "muli",
            fontSize: ScreenUtil().setSp(20.0)),
      ),
      subTitle: Text(
        "Drink on time ",
        style: TextStyle(
            color: AppThemeColors.textMaterial,
            // fontWeight: FontWeight.bold,
            fontFamily: "muli",
            fontSize: ScreenUtil().setSp(20.0)),
      ),
      chlid: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 00.0),
                  child: SizedAnim(
                    child: Stack(
                      children: <Widget>[
                        FlareActor(
                          "assets/glassloading1.flr",
                          animation: "sujan",
                          fit: BoxFit.contain,
                          // animation: "Demo",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            // color: Colors.yellow,
                            child: FlareActor(
                              "assets/notify.flr",
                              animation: "Play",
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
];
