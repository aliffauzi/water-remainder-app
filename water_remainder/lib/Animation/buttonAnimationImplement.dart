import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_remainder/Colors/appThemeColors.dart';

import 'buttonAnimation.dart';

class BottonAnimationImplementation extends StatefulWidget {
  final Function nextOrPrevious;
  final String buttonText;
  final int delayedAni;

  const BottonAnimationImplementation(
      {Key key, this.nextOrPrevious, this.buttonText, this.delayedAni})
      : super(key: key);
  @override
  _BottonAnimationImplementationState createState() =>
      _BottonAnimationImplementationState();
}

class _BottonAnimationImplementationState
    extends State<BottonAnimationImplementation> {
  bool isPressed = false;
  double _scale = 0.986;

  void onPressedUp(PointerUpEvent event) {
    setState(() {
      isPressed = false;
    });
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ButtonAnimation(
      delayTime: widget.delayedAni,
      widget: Padding(
        padding: const EdgeInsets.symmetric(
            // horizontal: 10.0, vertical: 30.0
            ),
        child: GestureDetector(
          onTap: ButtonAnimation.disableButton == true
              ? () {
                  print("disable true");
                }
              : widget.nextOrPrevious,
          child: Listener(
            onPointerUp: onPressedUp,
            onPointerDown: onPressedDown,
            child: isPressed
                ? Transform.scale(
                    scale: _scale,
                    child: Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(60),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3.0,
                            offset: Offset(0, 4),
                          )
                        ],
                        color: AppThemeColors.materialTheme,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Center(
                          child: Text(
                        widget.buttonText,
                        style: TextStyle(
                            color: AppThemeColors.themeAccent,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            fontFamily: "muli",
                            fontSize: ScreenUtil().setSp(20.0)),
                      )),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(60),
                    decoration: BoxDecoration(
                        color: AppThemeColors.materialTheme,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: Center(
                        child: Text(
                      widget.buttonText,
                      style: TextStyle(
                          color: AppThemeColors.themeAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: "muli",
                          letterSpacing: 1.0,
                          fontSize: ScreenUtil().setSp(20.0)),
                    )),
                  ),
          ),
        ),
      ),
    );
  }
}
