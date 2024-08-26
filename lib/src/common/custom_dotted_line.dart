

part of common_lib;



class CustomDottedLine extends StatelessWidget {

  final double width;
  final double height;
  final double lineWidth;
  final double lineHeight;
  final double space;
  final Color color;

  double get numberOfDot => height / (lineHeight + space) - 1;

  const CustomDottedLine({
    super.key,
    required this.width,
    required this.height,
    required this.lineWidth,
    required this.lineHeight,
    required this.space,
    required this.color
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child: Flex(
        direction: Axis.vertical,
        children: [
          for(int i = 0 ; i < numberOfDot ; i++) Container(
            margin: EdgeInsets.symmetric(vertical: space / 2),
            color: color,
            width: lineWidth,
            height: lineHeight,
          )
        ],
      ),
    );
  }

}