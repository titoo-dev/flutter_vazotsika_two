import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;
  final PaintingStyle paintingStyle;

  SpritePainter(this._animation, this.paintingStyle)
      : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = Color.fromRGBO(255, 193, 7, opacity);

    double size = rect.width / 1.5;
    double area = size * size;
    double radius = sqrt(area * value / 4);
    final Paint paint = Paint()
      ..style = paintingStyle
      ..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
