

part of ui_model_library;



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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is MoonChartYLabelStyleUIModel &&
      other.max == max &&
      other.labelCount == labelCount &&
      other.textStyle == textStyle &&
      other.labelPrecision == labelPrecision &&
      other.labelSuffixUnit == labelSuffixUnit;
  }

  @override
  int get hashCode => Object.hash(max, labelCount, textStyle, labelPrecision, labelSuffixUnit);

}