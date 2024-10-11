

part of moon_linear_graph_library;



class _MoonLinearGraphLinePainter extends CustomPainter {

  final List<MoonChartPointUIModel> nodeGroup;
  final List<MoonChartPointUIModel> oldNodeGroup;
  final Animation<double> animation;

  List<double> get _different {
    List<double> x = [];

    int length = oldNodeGroup.length > nodeGroup.length ? nodeGroup.length : oldNodeGroup.length;

    for(int index = 0 ; index < length ; index = index + 1) {
      x.add(nodeGroup[index].y - oldNodeGroup[index].y);
    }
    return x;
  }

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

      for (int index = 0; index < nodeGroup.length; index++) {

        double realScreenX = index * size.width / nodeGroup.length;

        double newDifference = _different.length > index ? _different[index] : 0;
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
    return !isEqual(oldNodeGroup, nodeGroup);
  }
}




bool isEqual(List<MoonChartPointUIModel> list1, List<MoonChartPointUIModel> list2) {
  if (list1.length != list2.length) {
    return false; // 길이가 다르면 다름
  }
  for (int i = 0; i < list1.length; i++) {
    if (list1[i].x != list2[i].x || list1[i].y != list2[i].y) {
      return false; // 요소가 다르면 다름
    }
  }

  return true; // 모든 요소가 같으면 같음
}