import 'package:flutter/cupertino.dart';

class ReportModel {
  final Widget chlid;
  final Text title;
  final Text subTitle;
  final int durationTitle;
  final int durationSubTitle;

  ReportModel(
      {this.durationSubTitle,
      this.durationTitle,
      this.chlid,
      this.title,
      this.subTitle});
}
