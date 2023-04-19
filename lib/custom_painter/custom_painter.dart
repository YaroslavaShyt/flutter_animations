import 'package:flutter/material.dart';
import 'object_properties.dart';

class BarChartPainter extends CustomPainter {
  final Animation<double> animation;
  final List<ObjectProperties> data;

  BarChartPainter({required this.animation, required this.data})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (data.length * 2);
    final chartHeight = size.height * 0.7;
    final chartWidth = size.width;
    final origin = Offset(0, size.height * 0.8);

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    canvas.drawLine(origin, Offset(chartWidth, origin.dy), axisPaint);

    final xArrowPath = Path();
    xArrowPath.moveTo(chartWidth, origin.dy);
    xArrowPath.lineTo(chartWidth - 20, origin.dy - 10);
    xArrowPath.lineTo(chartWidth - 20, origin.dy + 10);
    xArrowPath.close();
    canvas.drawPath(
      xArrowPath.transform(Matrix4.translationValues(0, 0, 0).storage),
      axisPaint,
    );

    canvas.drawLine(origin, const Offset(0, 0), axisPaint);

    final yArrowPath = Path();
    yArrowPath.moveTo(origin.dx, 0);
    yArrowPath.lineTo(origin.dx - 10, 20);
    yArrowPath.lineTo(origin.dx + 10, 20);
    yArrowPath.close();
    canvas.drawPath(
      yArrowPath.transform(Matrix4.translationValues(0, 0, 0).storage),
      axisPaint,
    );

    for (int i = 0; i < data.length; i++) {
      final barHeight = chartHeight * animation.value * (data[i].value / 100);
      final barX = i * barWidth * 1.5 + barWidth;
      final barY = origin.dy - barHeight;

      final colorRange = [
        Colors.lightBlueAccent,
        Colors.lightBlue,
        Colors.teal,
        Colors.indigo,
        Colors.green];

      final color = Color.lerp(
          colorRange[0],
          colorRange[colorRange.length - 1],
          (barHeight / chartHeight).clamp(0, 1));

      final barRect = Rect.fromLTWH(barX, barY, barWidth, barHeight);

      final barPaint = Paint()..color = color!;

      canvas.drawRect(barRect, barPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
