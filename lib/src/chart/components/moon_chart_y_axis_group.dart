

part of chart_library;



class _MoonChartYAxisGroup extends StatelessWidget {

  final int tapAreaCount;
  final double tapAreaWidth;
  final double tapAreaRightPadding;
  final MoonDottedLineUIModel line;

  const _MoonChartYAxisGroup({
    required this.tapAreaCount,
    required this.tapAreaWidth,
    required this.tapAreaRightPadding,
    required this.line,
  });

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
      child: CustomPaint(
        painter: _MoonChartYAxisGroupCustomPainter(
          tapAreaCount: tapAreaCount,
          tapAreaWidth: tapAreaWidth,
          tapAreaRightPadding: tapAreaRightPadding,
          line: line,
        ),
      ),
    );
  }
}


class _MoonChartYAxisGroupCustomPainter extends CustomPainter {
  int tapAreaCount;
  double tapAreaWidth;
  double tapAreaRightPadding;
  MoonDottedLineUIModel line;

  _MoonChartYAxisGroupCustomPainter({
    required this.tapAreaCount,
    required this.tapAreaWidth,
    required this.tapAreaRightPadding,
    required this.line,
  });

  @override
  void paint(Canvas canvas, Size size) {

    var paint = ui.Paint()
      ..color = line.dotColor
      ..strokeWidth = line.dotWidth
      ..style = PaintingStyle.stroke;

    final path = Path();

    List.generate(tapAreaCount, (index) {
      double dx =  (tapAreaRightPadding * index) + (tapAreaWidth * index);
      double yUpPoint = 0;
      double yDownPoint = size.height;

      while (yUpPoint < yDownPoint) {
        path.moveTo(dx, yUpPoint);
        yUpPoint += line.dotHeight;
        path.lineTo(dx, yUpPoint);
        yUpPoint += line.space;
      }
    });

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MoonChartYAxisGroupCustomPainter oldDelegate) {
    return tapAreaCount != oldDelegate.tapAreaCount ||
        tapAreaWidth != oldDelegate.tapAreaWidth ||
        tapAreaRightPadding != oldDelegate.tapAreaRightPadding ||
        line != oldDelegate.line;
  }
}