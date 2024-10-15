

part of moon_linear_graph_library;



class _MoonLinearGraphYAxisGroup extends StatelessWidget {

  final int tapAreaCount;
  final double tapAreaWidth;
  final double tapAreaRightPadding;
  final MoonDottedLineUIModel line;
  final Function(int index) onPressed;

  const _MoonLinearGraphYAxisGroup({
    required this.tapAreaCount,
    required this.tapAreaWidth,
    required this.tapAreaRightPadding,
    required this.line,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    debugPrint('y axis group build');

    return GestureDetector(
      onTapDown: (details) {
        Offset tapPosition = details.localPosition;

        double width = (tapAreaRightPadding + tapAreaWidth) * tapAreaCount;

        int index = ((tapPosition.dx / width) * tapAreaCount).round();

        onPressed(index);
      },
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _MoonLinearGraphYAxisGroupCustomPainter(
            tapAreaCount: tapAreaCount,
            tapAreaWidth: tapAreaWidth,
            tapAreaRightPadding: tapAreaRightPadding,
            line: line,
          ),
        ),
      )
    );
  }
}


class _MoonLinearGraphYAxisGroupCustomPainter extends CustomPainter {
  int tapAreaCount;
  double tapAreaWidth;
  double tapAreaRightPadding;
  MoonDottedLineUIModel line;

  _MoonLinearGraphYAxisGroupCustomPainter({
    required this.tapAreaCount,
    required this.tapAreaWidth,
    required this.tapAreaRightPadding,
    required this.line,
  });

  @override
  void paint(Canvas canvas, Size size) {

    debugPrint('y axis group paint');

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
  bool shouldRepaint(covariant _MoonLinearGraphYAxisGroupCustomPainter oldDelegate) {
    return tapAreaCount != oldDelegate.tapAreaCount ||
        tapAreaWidth != oldDelegate.tapAreaWidth ||
        tapAreaRightPadding != oldDelegate.tapAreaRightPadding ||
        line != oldDelegate.line;
  }
}