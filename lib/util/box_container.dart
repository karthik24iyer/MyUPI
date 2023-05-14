import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // return CustomPaint(
    //   painter: _HighlightPainter(),
    //   child: Container(
    //     width: 250,
    //     height: 250,
    //     decoration: BoxDecoration(
    //         border: Border.all(color: Colors.white)
    //     ),
    //   ),
    // );
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white)
          ),
        ),
        //const Divider(height: 1, color: Colors.white, thickness: 3, indent: 1, endIndent: 350),
        VerticalDivider(width: 1, color: Colors.white, thickness: 3,),
      ],
    );
  }
}

class _HighlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 12.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(0, 10)
      ..lineTo(10, 5)
      ..lineTo(size.width - 10, 0)
      ..lineTo(size.width, 10)
      ..lineTo(size.width, size.height - 10)
      ..lineTo(size.width - 10, size.height)
      ..lineTo(10, size.height)
      ..lineTo(0, size.height - 10)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HighlightPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_HighlightPainter oldDelegate) => false;
}