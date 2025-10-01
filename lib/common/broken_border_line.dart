import 'dart:math';

import 'package:flutter/material.dart';

class BrokenBorderPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double gapWidth;
  final double strokeWidth;

  BrokenBorderPainter({
    required this.color,
    required this.dashWidth,
    required this.gapWidth,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final double circumference = 2 * pi * radius;

    double dashCount = (circumference / (dashWidth + gapWidth)).floorToDouble();
    double anglePerDash = (2 * pi) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      double startAngle = i * anglePerDash;
      double endAngle = startAngle + (dashWidth / radius);

      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}