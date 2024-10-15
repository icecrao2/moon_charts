

part of ui_model_library;



class MoonChartBarStyleUIModel {

  final Color unSelectedColor;
  final Color selectedColor;
  final double lineWidth;
  final Duration animationDuration;
  final double touchAreaWidth;
  final double itemBetweenPadding;

  const MoonChartBarStyleUIModel({
    required this.unSelectedColor,
    required this.selectedColor,
    required this.lineWidth,
    required this.animationDuration,
    required this.touchAreaWidth,
    required this.itemBetweenPadding
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is MoonChartBarStyleUIModel &&
      other.unSelectedColor == unSelectedColor &&
      other.selectedColor == selectedColor &&
      other.lineWidth == lineWidth &&
      other.animationDuration.inMilliseconds == animationDuration.inMilliseconds;
  }
  
  @override
  int get hashCode => Object.hash(unSelectedColor, selectedColor, lineWidth, animationDuration);
}


class MoonChartLineStyleUIModel {

  final Color lineColor;
  final double lineWidth;

  final Color unSelectedCircleColor;
  final double unSelectedCircleRadius;
  final Color selectedCircleColor;
  final double selectedCircleRadius;

  final Duration animationDuration;
  final double touchAreaWidth;
  final double itemBetweenPadding;

  const MoonChartLineStyleUIModel({
    required this.lineColor,
    required this.lineWidth,
    required this.unSelectedCircleColor,
    required this.unSelectedCircleRadius,
    required this.selectedCircleColor,
    required this.selectedCircleRadius,
    required this.animationDuration,
    required this.touchAreaWidth,
    required this.itemBetweenPadding
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is MoonChartLineStyleUIModel &&
      other.lineColor == lineColor &&
      other.lineWidth == lineWidth &&
      other.unSelectedCircleColor == unSelectedCircleColor &&
      other.unSelectedCircleRadius == unSelectedCircleRadius &&
      other.selectedCircleColor == selectedCircleColor &&
      other.selectedCircleRadius == selectedCircleRadius &&
      other.animationDuration == animationDuration &&
      other.touchAreaWidth == touchAreaWidth &&
      other.itemBetweenPadding == itemBetweenPadding;
  }

  @override
  int get hashCode => Object.hash(
      lineColor,
      lineWidth,
      unSelectedCircleColor,
      unSelectedCircleRadius,
      selectedCircleColor,
      selectedCircleRadius,
      animationDuration,
      touchAreaWidth,
      itemBetweenPadding
  );
}

