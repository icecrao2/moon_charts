

part of moon_linear_graph_library;



class _MoonLinearGraphLinePainter extends CustomPainter {

  final List<MoonChartPointUIModel> nodeGroup;
  final List<MoonChartPointUIModel> oldNodeGroup;
  final Animation<double> animation;

  const _MoonLinearGraphLinePainter({required this.nodeGroup, required this.oldNodeGroup, required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {

    debugPrint('line repaint');

    Paint paint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue.withOpacity(1);

    Path path = Path();

    if (nodeGroup.isNotEmpty) {

      int length = math.min(oldNodeGroup.length, nodeGroup.length);

      for (int index = 0; index < nodeGroup.length; index++) {

        double realScreenX = index * size.width / nodeGroup.length;

        double newDifference = index < length ? nodeGroup[index].y - oldNodeGroup[index].y : 0;
        double y = oldNodeGroup.isEmpty ? nodeGroup[index].y : (oldNodeGroup.length > index ? (oldNodeGroup[index].y + newDifference * animation.value) : (nodeGroup[index].y)) ;
        double realScreenY = size.height - (y * (size.height / 100));

        Offset center = Offset(realScreenX, realScreenY);

        if (index == 0) {
          path.moveTo(center.dx, center.dy);
        } else {
          path.lineTo(center.dx, center.dy);
        }

        canvas.drawCircle(center, 3, fillPaint);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !const ListEquality().equals(oldNodeGroup, nodeGroup);
  }
}

