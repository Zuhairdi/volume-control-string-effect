import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _sliderValue = 1;

  double constant(double x) {
    double a = -20.0;
    double b = -10.0;
    double c = 25.0;
    num power = pow(x, 2);
    double out = (a * power) + (b * x) + c;
    return out;
  }

  ColorTween myColor() {
    final startColor = Colors.blueAccent;
    final endColor = Colors.red;
    return ColorTween(end: endColor, begin: startColor);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print('slider: $_sliderValue, Container: ${(size.width * _sliderValue)}');
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: size.height * 0.5,
            child: CustomPaint(
              foregroundPainter: MyPainter(myColor().transform(_sliderValue)!),
              child: Container(
                width: size.width * _sliderValue + constant(_sliderValue),
                height: 300 * (1 - _sliderValue),
              ),
            ),
          ),
          Positioned(
            child: Slider(
              activeColor: Colors.transparent,
              inactiveColor: Colors.transparent,
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color _color;
  MyPainter(this._color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final pointAx = 0.0;
    final pointAy = 0.0;

    final pointBx = size.width * 0.02;
    final pointBy = 0.0;

    final pointCx = size.width * 0.93;
    final pointCy = 0.0;

    final pointDx = size.width * 0.95;
    final pointDy = 0.0;

    final curveX1 = size.width * 0.2;
    final curveY1 = size.height;

    final curveX2 = size.width * 0.80;
    final curveY2 = size.height;

    final path = Path()
      ..moveTo(pointAx, pointAy)
      ..lineTo(pointBx, pointBy)
      ..cubicTo(curveX1, curveY1, curveX2, curveY2, pointCx, pointCy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
