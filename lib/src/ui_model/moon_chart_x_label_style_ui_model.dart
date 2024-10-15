

part of ui_model_library;



class MoonChartXLabelStyleUIModel {

  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;

  const MoonChartXLabelStyleUIModel({
    required this.selectedTextStyle,
    required this.unSelectedTextStyle
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is MoonChartXLabelStyleUIModel;
  }

  @override
  int get hashCode => Object.hash(selectedTextStyle, unSelectedTextStyle);
}