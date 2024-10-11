

part of moon_linear_graph_library;



class _MoonLinearGraphYLabel extends StatelessWidget {

  final double height;
  final double maxY;
  final double yAxisScale;
  final double yAxisWidth;
  final double yAxisUnitHeight;
  final int xAxisLabelPrecision;
  final String xAxisLabelSuffixUnit;
  final TextStyle textStyle;

  const _MoonLinearGraphYLabel({
    required this.height,
    required this.maxY,
    required this.yAxisScale,
    required this.yAxisWidth,
    required this.yAxisUnitHeight,
    required this.xAxisLabelPrecision,
    required this.xAxisLabelSuffixUnit,
    required this.textStyle
  });

  @override
  Widget build(BuildContext context) {

    debugPrint('rebuild y label');

    return Container(
      color: Colors.white,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        verticalDirection: VerticalDirection.down,
        children: List.generate((maxY / yAxisScale).ceil() + 1, (index) {
          final double number = maxY - index * yAxisScale;
          return SizedBox(
            width: yAxisWidth,
            height: yAxisUnitHeight,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "${number.toStringAsFixed(xAxisLabelPrecision)}$xAxisLabelSuffixUnit",
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          );
        }),
      ),
    );
  }
}