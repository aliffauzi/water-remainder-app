import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:water_remainder/Animation/delayedAnimation.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';

class CustomWeight extends StatefulWidget {
  final Function onTab;

  const CustomWeight({Key key, this.onTab}) : super(key: key);
  @override
  _CustomWeightState createState() => _CustomWeightState();
}

class _CustomWeightState extends State<CustomWeight> {
  TextEditingController controller = TextEditingController();
  double spinner = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((onValue) {
      setState(() {
        spinner = onValue.getDouble('doubleValue');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DelayedAnimtion(
      anioffsetX: 0.0,
      anioffsetY: 1.35,
      delayDuration: 0,
      aniDuration: 700,
      widget: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)), //this right here
        child: FittedBox(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your weight",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "muli",
                      fontSize: ScreenUtil().setSp(20.0)),
                ),
              ),
              Center(
                child: SpinnerInput(
                  spinnerValue: spinner,
                  middleNumberPadding: const EdgeInsets.all(20),
                  middleNumberWidth: ScreenUtil().setWidth(100),
                  middleNumberStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "muli",
                      fontSize: 20.0),
                  popupTextStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: "muli",
                      fontSize: ScreenUtil().setSp(20.0)),
                  popupButton: SpinnerButtonStyle(
                      elevation: 8.0,
                      height: 50.0,
                      width: 50.0,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  minusButton: SpinnerButtonStyle(
                      child: Icon(
                        FontAwesomeIcons.minus,
                        color: Color(0xFFF4F4F4),
                        size: ScreenUtil().setSp(20.0),
                      ),
                      color: AppThemeColors.themeAccent,
                      elevation: 8.0,
                      height: ScreenUtil().setHeight(50.0),
                      width: ScreenUtil().setWidth(100)),
                  plusButton: SpinnerButtonStyle(
                      child: Icon(
                        FontAwesomeIcons.plus,
                        color: Color(0xFFF4F4F4),
                        size: 20.0,
                      ),
                      elevation: 8.0,
                      color: AppThemeColors.themeAccent,
                      height: ScreenUtil().setHeight(50.0),
                      width: ScreenUtil().setWidth(100)),
                  minValue: 0,
                  maxValue: 400,
                  onChange: onValueChanged,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                    onTap: widget.onTab,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10.0),
                        child: Center(
                          child: Text("OK",
                              style: TextStyle(
                                  color: AppThemeColors.textMaterial,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: "muli",
                                  fontSize: ScreenUtil().setSp(20.0))),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: AppThemeColors.themeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onValueChanged(double newValue) {
    spinner = newValue;
    setWeightValue();
    print(spinner);
    setState(() {
      spinner = newValue;
    });
  }

  Future<Null> setWeightValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('doubleValue', spinner);
  }
}
