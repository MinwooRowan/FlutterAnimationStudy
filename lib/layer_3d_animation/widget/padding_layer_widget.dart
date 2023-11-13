import 'package:flutter/material.dart';

class PaddingLayerWidget extends StatelessWidget {
  const PaddingLayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const paddingColor = Colors.blueAccent;

    return Opacity(
      opacity: 0.5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: paddingColor, width: 20),
        ),
      ),
    );
  }
}

class SlashBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 20;

    // Draw the slashes
    const double slashSpacing = 10.0;
    final double slashCount = size.width / slashSpacing;
    for (int i = 0; i < slashCount; i++) {
      final x = i * slashSpacing;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      canvas.drawLine(Offset(0, x), Offset(size.width, x), paint);
    }

    // Create the outer square path
    final outerRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final outerPath = Path()..addRect(outerRect);

    // Create the inner square path
    final innerRect = Rect.fromLTWH(size.width * 0.25, size.height * 0.25,
        size.width * 0.5, size.height * 0.5);
    final innerPath = Path()..addRect(innerRect);

    // Subtract the inner path from the outer path to create a hole
    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
