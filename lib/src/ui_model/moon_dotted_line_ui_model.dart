

part of ui_model_library;



class MoonDottedLineUIModel {
  final double dotWidth;
  final double dotHeight;
  final double space;
  final Color dotColor;

  const MoonDottedLineUIModel({
    required this.dotWidth,
    required this.dotHeight,
    required this.space,
    required this.dotColor
  });


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is MoonDottedLineUIModel &&
        other.dotWidth == dotWidth &&
        other.dotHeight == dotHeight &&
        other.space == space &&
        other.dotColor == dotColor;
  }


  @override
  int get hashCode => Object.hash(dotWidth, dotHeight, space, dotColor);
}