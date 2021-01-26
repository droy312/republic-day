import 'dart:math' as math;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const Color white = Color(0xffffffff);

  AnimationController a1, a2, a3, a4;

  Widget buildText() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 100,
              color: Color(0xffFF9933),
            ),
            Container(
              height: 60,
              width: 100,
              color: white,
            ),
            Container(
              height: 60,
              width: 100,
              color: Color(0xff138808),
            ),
          ],
        ),
        Text(
          'Happy Republic Day',
          style: TextStyle(
            color: Color(0xff000080),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins'
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    a1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    a2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    a3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    a4 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Container(
          height: (2 / 3) * MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPaint(
                painter: IndianFlagPainter(
                  topFlagValue: a1.value,
                  bottomFlagValue: a2.value,
                  centerFlagValue: a3.value,
                ),
                child: Container(
                  width: 300,
                  height: 200,
                ),
              ),
              Opacity(
                opacity: a4.value,
                child: buildText(),
              ),
              RaisedButton(
                color: white,
                onPressed: () {
                  a1.reset();
                  a2.reset();
                  a3.reset();
                  a4.reset();
                  a1.forward().then(
                        (value) => a2.forward().then(
                              (value) => a3.forward().then(
                                    (value) => a4.forward(),
                                  ),
                            ),
                      );

                  a1.addListener(() {
                    setState(() {});
                  });
                  a2.addListener(() {
                    setState(() {});
                  });
                  a3.addListener(() {
                    setState(() {});
                  });
                  a4.addListener(() {
                    setState(() {});
                  });
                },
                child: Text(
                  'START',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndianFlagPainter extends CustomPainter {
  final double topFlagValue;
  final double bottomFlagValue;
  final double centerFlagValue;
  IndianFlagPainter({
    this.topFlagValue,
    this.bottomFlagValue,
    this.centerFlagValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint saffronPaint = Paint()
      ..color = Color(0xffFF9933)
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Paint greenPaint = Paint()
      ..color = Color(0xff138808)
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Paint bluePaint = Paint()
      ..color = Color(0xff000080)
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Path topPath = Path();
    topPath.moveTo(0, 0);
    topPath.lineTo(size.width * topFlagValue, 0);

    topPath.moveTo(size.width, 0);
    topPath.lineTo(size.width, (size.height / 3) * topFlagValue);

    topPath.moveTo(size.width, (size.height / 3));
    topPath.lineTo(size.width * (1 - topFlagValue), (size.height / 3));

    topPath.moveTo(0, (size.height / 3));
    topPath.lineTo(0, size.height / 3 * (1 - topFlagValue));

    canvas.drawPath(topPath, saffronPaint);

    final Path bottomPath = Path();
    bottomPath.moveTo(0, 2 * size.height / 3);
    bottomPath.lineTo(size.width * bottomFlagValue, 2 * size.height / 3);

    bottomPath.moveTo(size.width, 2 * size.height / 3);
    bottomPath.lineTo(
        size.width, size.height - (1 - bottomFlagValue) * (size.height / 3));

    bottomPath.moveTo(size.width, size.height);
    bottomPath.lineTo(size.width * (1 - bottomFlagValue), size.height);

    bottomPath.moveTo(0, size.height);
    bottomPath.lineTo(0, (size.height) - bottomFlagValue * (size.height / 3));

    canvas.drawPath(bottomPath, greenPaint);

    final Path centerPath = Path();
    final double radius = math.min(size.height / 3, size.width / 3);
    centerPath.addArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: radius - 20,
        width: radius - 20,
      ),
      -math.pi / 2,
      4 * (math.pi / 2) * centerFlagValue,
    );

    canvas.drawPath(centerPath, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
