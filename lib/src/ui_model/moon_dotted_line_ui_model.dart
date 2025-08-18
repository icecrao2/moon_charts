part of 'ui_model_lib.dart';

class MoonDottedLineUIModel {
  final double dotWidth;
  final double dotHeight;
  final double space;
  final Color dotColor;

  const MoonDottedLineUIModel(
      {this.dotWidth = 1, this.dotHeight = 6, this.space = 4, this.dotColor = const Color.fromRGBO(89, 147, 255, 0.2)});

  const MoonDottedLineUIModel.fromDefault()
      : dotWidth = 1,
        dotHeight = 6,
        space = 4,
        dotColor = const Color.fromRGBO(89, 147, 255, 0.2);
}
