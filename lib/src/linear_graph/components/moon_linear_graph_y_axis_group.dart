

part of moon_linear_graph_library;



class _MoonLinearGraphYAxisGroup extends StatelessWidget {

  final int axisCount;
  final EdgeInsets padding;
  final double axisWidth;
  final double axisHeight;
  final MoonDottedLineUIModel line;

  const _MoonLinearGraphYAxisGroup({
    required this.axisCount,
    required this.padding,
    required this.axisWidth,
    required this.axisHeight,
    required this.line
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: List.generate(axisCount, (index) {
        return Padding(
          padding: padding,
          child: MoonDottedLine.fromDottedLineUIModel(
            width: axisWidth,
            height: axisHeight,
            dottedLineUIModel: line
          )
        );
      })
    );
  }
}