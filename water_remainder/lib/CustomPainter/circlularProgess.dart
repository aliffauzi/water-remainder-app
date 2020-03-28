import 'dart:math';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double currentProgress;

  CirclePainter(this.currentProgress);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0
      ..color = Colors.black;

    final completeArc = Paint()
      ..strokeWidth = 7.0
      ..style = PaintingStyle.stroke
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round;

    Offset offsetCenter = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 7;

    double angle = 2 * pi * (currentProgress / 100);

    canvas.drawCircle(offsetCenter, radius, paint);
    canvas.drawArc(
        Rect.fromCircle(
          center: offsetCenter,
          radius: radius,
        ),
        -pi / 2,
        angle,
        false,
        completeArc);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}
