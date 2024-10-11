

part of moon_linear_graph_library;



class _MoonLinearGraphTouchArea extends StatelessWidget {

  final int tapAreaCount;
  final double tapAreaWidth;
  final double tapAreaHeight;
  final EdgeInsets padding;
  final Function(int index) onPressed;

  const _MoonLinearGraphTouchArea({
    required this.tapAreaCount,
    required this.tapAreaWidth,
    required this.tapAreaHeight,
    required this.padding,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    debugPrint('rebuild touch area');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        for(int index = 0; index < tapAreaCount; index++) Container(
          width: tapAreaWidth,
          height: tapAreaHeight,
          margin: padding,
          child: OutlinedButton(
              onPressed: () {
                onPressed(index);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.transparent),
                shape: const RoundedRectangleBorder(),
                splashFactory: InkSplash.splashFactory,
              ),
              child: Container()
          ),
        )
      ],
    );
  }
}