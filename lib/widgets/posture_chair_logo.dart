import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class PostureChairLogo extends StatelessWidget {
  final double size;
  const PostureChairLogo({super.key, this.size = 88});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  size,
      height: size,
      decoration: BoxDecoration(
        color:        AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.27),
      ),
      child: CustomPaint(
        painter: _ChairPainter(),
      ),
    );
  }
}

class _ChairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final white = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final dot = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;
    final r = Radius.circular(s * 0.02);

    // Backrest
    canvas.drawRRect(
      RRect.fromLTRBR(s * 0.234, s * 0.152, s * 0.361, s * 0.563, r),
      white,
    );
    // Seat
    canvas.drawRRect(
      RRect.fromLTRBR(s * 0.215, s * 0.537, s * 0.762, s * 0.646, r),
      white,
    );
    // Back leg
    canvas.drawRRect(
      RRect.fromLTRBR(s * 0.234, s * 0.635, s * 0.322, s * 0.816, r),
      white,
    );
    // Front leg
    canvas.drawRRect(
      RRect.fromLTRBR(s * 0.610, s * 0.635, s * 0.698, s * 0.816, r),
      white,
    );
    // Spine vertebrae dots
    for (int i = 0; i < 4; i++) {
      canvas.drawCircle(
        Offset(s * 0.298, s * (0.215 + i * 0.086)),
        s * 0.026,
        dot,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
