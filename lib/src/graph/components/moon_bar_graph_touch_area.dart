

part of graph_library;



class _MoonBarGraphTouchArea extends StatelessWidget {

  final int tapAreaCount;
  final double tapAreaWidth;
  final double tapAreaHeight;
  final EdgeInsets padding;
  final Function(int index) onPressed;

  const _MoonBarGraphTouchArea({
    required this.tapAreaCount,
    required this.tapAreaWidth,
    required this.tapAreaHeight,
    required this.padding,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    debugPrint('rebuild graph touch area');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children:List.generate(tapAreaCount, (index) {
        return Container(
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
            child: const SizedBox.shrink(),
          ),
        );
      }),
    );
  }
}