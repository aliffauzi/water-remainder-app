import 'dart:async';
import 'package:flutter/material.dart';

class ButtonAnimation extends StatefulWidget {
  final Widget widget;
  final int delayTime;
  static bool disableButton = true;

  const ButtonAnimation({@required this.widget, this.delayTime});
  @override
  _ButtonAnimationState createState() => _ButtonAnimationState();
}

class _ButtonAnimationState extends State<ButtonAnimation>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> next;
  Animation<Offset> _animationOffset;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    // opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
    //     CurvedAnimation(curve: Curves.elasticOut, parent: _animationController));

    // final curve = CurvedAnimation(
    //     curve: Curves.bounceInOut, parent: _animationController);
    // next = TweenSequence(
    //   <TweenSequenceItem<double>>[
    //     TweenSequenceItem<double>(
    //       tween: Tween<double>(begin: 1.4, end: 1)
    //           .chain(CurveTween(curve: Curves.elasticInOut)),
    //       weight: 40.0,
    //     ),
    //     TweenSequenceItem<double>(
    //       tween: Tween<double>(begin: 0.9, end: 1)
    //           .chain(CurveTween(curve: Curves.elasticInOut)),
    //       weight: 20.0,
    //     ),
    //   ],
    // ).animate(curve);

    // final curve1 =
    //     CurvedAnimation(curve: Curves.decelerate, parent: _animationController);
    // _animationOffset = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset.zero)
    //     .animate(curve1);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          ButtonAnimation.disableButton = false;
        });
      } else {
        setState(() {
          ButtonAnimation.disableButton = true;
        });
      }
    });

    if (widget.delayTime == null) {
      _animationController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delayTime), () {
        _animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  ScaleTransition(
        scale: CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: Curves.elasticOut)),
        child: widget.widget,
      );
    
  }
}
