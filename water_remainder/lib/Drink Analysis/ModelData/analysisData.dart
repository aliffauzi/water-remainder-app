import 'package:flutter/cupertino.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Drink%20Analysis/ModelData/reportModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalaysisData extends StatelessWidget {
  final ReportModel model;

  const AnalaysisData({
    Key key,
    this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 432.0, height: 816.0, allowFontScaling: true);
    int delayAmount = 500;
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DelayedAnimtion(
              widget: model.title,
              anioffsetX: 0.0,
              anioffsetY: 0.35,
              delayDuration: model.durationTitle,
              aniDuration: 700,
            ),
            model.chlid,
            DelayedAnimtion(
              anioffsetX: 0.0,
              anioffsetY: 0.35,
              delayDuration: delayAmount + model.durationSubTitle,
              aniDuration: 700,
              widget: model.subTitle,
            )
          ],
        ),
      ),
    );
  }
}
