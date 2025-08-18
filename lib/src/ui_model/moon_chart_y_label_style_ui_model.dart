part of 'ui_model_lib.dart';

class MoonChartYLabelStyleUIModel {
  final double max;
  final int labelCount;
  final TextStyle textStyle;
  final int labelPrecision;
  final String labelSuffixUnit;

  const MoonChartYLabelStyleUIModel({
    required this.max,
    required this.labelCount,
    required this.textStyle,
    required this.labelPrecision,
    required this.labelSuffixUnit,
  });

  const MoonChartYLabelStyleUIModel.fromDefault()
      : max = 100,
        labelCount = 5,
        textStyle = const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(81, 81, 81, 1),
        ),
        labelPrecision = 0,
        labelSuffixUnit = "%";
}