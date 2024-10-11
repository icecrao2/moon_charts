

part of moon_linear_graph_library;



class _MoonLinearGraphXLabel extends StatelessWidget {

  final List<MoonChartPointUIModel> chartPointGroup;
  final double labelWidth;
  final EdgeInsets labelMargin;
  final int hitXIndex;
  final TextStyle selectedXLabelTextStyle;
  final TextStyle unSelectedXLabelTextStyle;

  const _MoonLinearGraphXLabel({
    required this.chartPointGroup,
    required this.labelWidth,
    required this.labelMargin,
    required this.hitXIndex,
    required this.selectedXLabelTextStyle,
    required this.unSelectedXLabelTextStyle
  });

  @override
  Widget build(BuildContext context) {

    debugPrint('rebuild x label');

    return Row(
      children: List.generate(chartPointGroup.length, (index) {
        return Container(
          width: labelWidth,
          margin: labelMargin,
          alignment: Alignment.center,
          child: Text(
            chartPointGroup[index].x,
            textAlign: TextAlign.center,
            style: hitXIndex == index ? selectedXLabelTextStyle : unSelectedXLabelTextStyle
          ),
        );
      })
    );
  }
}