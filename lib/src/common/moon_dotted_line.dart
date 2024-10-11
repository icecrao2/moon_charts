

part of common_lib;



class MoonDottedLine extends StatelessWidget {

  final double width;
  final double height;
  final double lineWidth;
  final double lineHeight;
  final double space;
  final Color color;

  double get numberOfDot => (height / (lineHeight + space)).floor().toDouble();

  const MoonDottedLine({
    super.key,
    required this.width,
    required this.height,
    required this.lineWidth,
    required this.lineHeight,
    required this.space,
    required this.color,
  });

  MoonDottedLine.fromDottedLineUIModel({
    super.key,
    required this.width,
    required this.height,
    required MoonDottedLineUIModel dottedLineUIModel
  })
  : lineWidth = dottedLineUIModel.dotWidth,
    lineHeight = dottedLineUIModel.dotHeight,
    space = dottedLineUIModel.space,
    color = dottedLineUIModel.dotColor;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: List.generate(numberOfDot.toInt(), (index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: space / 2),
            color: color,
            width: lineWidth,
            height: lineHeight,
          );
        })
      ),
    );
  }
}
