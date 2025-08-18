part of 'ui_model_lib.dart';

abstract class MoonChartStyle {
  final double lineWidth;
  final Duration animationDuration;
  final double touchAreaWidth;
  final double itemBetweenPadding;

  const MoonChartStyle({
    required this.lineWidth,
    required this.animationDuration,
    required this.touchAreaWidth,
    required this.itemBetweenPadding,
  });
}

class MoonChartBarStyleUIModel extends MoonChartStyle {
  final Color unSelectedColor;
  final Color selectedColor;

  const MoonChartBarStyleUIModel(
      {required this.unSelectedColor,
      required this.selectedColor,
      required super.lineWidth,
      required super.animationDuration,
      required super.touchAreaWidth,
      required super.itemBetweenPadding});

  const MoonChartBarStyleUIModel.fromDefault()
      : unSelectedColor = Colors.grey,
        selectedColor = Colors.blue,
        super(
            lineWidth: 7,
            animationDuration: const Duration(milliseconds: 500),
            touchAreaWidth: 27,
            itemBetweenPadding: 10);
}

class MoonChartLineStyleUIModel extends MoonChartStyle {
  final Color lineColor;
  final Color unSelectedCircleColor;
  final double unSelectedCircleRadius;
  final Color selectedCircleColor;
  final double selectedCircleRadius;

  const MoonChartLineStyleUIModel(
      {required this.lineColor,
      required this.unSelectedCircleColor,
      required this.unSelectedCircleRadius,
      required this.selectedCircleColor,
      required this.selectedCircleRadius,
      required super.lineWidth,
      required super.animationDuration,
      required super.touchAreaWidth,
      required super.itemBetweenPadding});

  const MoonChartLineStyleUIModel.fromDefault()
      : lineColor = Colors.blue,
        unSelectedCircleColor = Colors.blue,
        unSelectedCircleRadius = 3,
        selectedCircleColor = Colors.blue,
        selectedCircleRadius = 5,
        super(
            lineWidth: 3,
            animationDuration: const Duration(milliseconds: 500),
            touchAreaWidth: 27,
            itemBetweenPadding: 10);
}
