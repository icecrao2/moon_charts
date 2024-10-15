

part of chart_library;



class _MoonChartSelectedYAxis extends StatelessWidget {

  final MoonDottedLineUIModel line;

  const _MoonChartSelectedYAxis({
    required this.line,
  });

  @override
  Widget build(BuildContext context) {

    debugPrint('selected y axis group build');

    return RepaintBoundary(
      child: CustomPaint(
        painter: _MoonChartSelectedYAxisCustomPainter(line: line,),
      ),
    );
  }
}


class _MoonChartSelectedYAxisCustomPainter extends CustomPainter {

  MoonDottedLineUIModel line;

  _MoonChartSelectedYAxisCustomPainter({required this.line,});

  @override
  void paint(Canvas canvas, Size size) {

    debugPrint('selected y axis group paint');

    var paint = ui.Paint()
      ..color = line.dotColor
      ..strokeWidth = line.dotWidth
      ..style = PaintingStyle.stroke;

    final path = Path();

    double yUpPoint = 0;
    double yDownPoint = size.height;

    while (yUpPoint < yDownPoint) {
      path.moveTo(0, yUpPoint);
      yUpPoint += line.dotHeight;
      path.lineTo(0, yUpPoint);
      yUpPoint += line.space;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MoonChartSelectedYAxisCustomPainter oldDelegate) {
    return line != oldDelegate.line;
  }
}