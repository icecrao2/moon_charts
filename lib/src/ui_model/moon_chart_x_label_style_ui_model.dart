part of 'ui_model_lib.dart';

class MoonChartXLabelStyleUIModel {
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;

  const MoonChartXLabelStyleUIModel({required this.selectedTextStyle, required this.unSelectedTextStyle});

  const MoonChartXLabelStyleUIModel.fromDefault()
      : selectedTextStyle = const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(89, 147, 255, 1),
        ),
        unSelectedTextStyle = const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(81, 81, 81, 1),
        );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is MoonChartXLabelStyleUIModel;
  }

  @override
  int get hashCode => Object.hash(selectedTextStyle, unSelectedTextStyle);
}
