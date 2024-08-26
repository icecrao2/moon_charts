

part of bar_graph_library;



class BarChartWidget extends StatefulWidget {

  final List<ChartPointUIModel> chartPointGroup;
  final double maxY;
  final int hitXIndex;
  final Function(int) onChangeSelectedIndex;

  const BarChartWidget({
    super.key,
    required this.chartPointGroup,
    required this.maxY,
    required this.hitXIndex,
    required this.onChangeSelectedIndex
  });

  @override
  State<StatefulWidget> createState() => _BarChartState();
}

class _BarChartState extends State<BarChartWidget> {

  late double _widthMySelf;
  late double _heightMySelf;
  double xCategoryFontSize = 11;
  final ScrollController _scrollController = ScrollController();

  double get _itemBetweenPadding => 10;
  double get _itemWidth => 28;
  double get _itemBarWidth => 7;
  int get _yAxisNumber => 5;
  Duration get _animationDuration => const Duration(milliseconds: 500);


  double get _graphWidth => _widthMySelf * 0.88181818;
  double get _graphHeight => _heightMySelf * 0.7556390;

  double get _scrollWidthMySelf => ((widget.chartPointGroup.length + 1) * (_itemWidth + _itemBetweenPadding));
  double get _yAxisScale => widget.maxY / _yAxisNumber;
  double get _yAxisWidth => _widthMySelf * 0.106061;
  double get _yAxisUnitHeight => _graphHeight / 5;

  double get _xAxisHeight => _heightMySelf * 0.086466;

  @override
  void didUpdateWidget(covariant BarChartWidget oldWidget) {

    if(oldWidget.chartPointGroup != widget.chartPointGroup ) {
      double scrollPoint = widget.hitXIndex * (_itemWidth + _itemBetweenPadding) - (_graphWidth / 2);
      _scrollController.jumpTo(scrollPoint);
    }

    // xCategoryFontSize = calculateFontSizeWithWidth(widget.chartPointGroup.last.x.isNotEmpty ? widget.chartPointGroup.last.x : "    " , _itemWidth, context) - 2;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {


    return  LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

          _widthMySelf = constraints.maxWidth;
          _heightMySelf = constraints.maxHeight;

          return CardShapeContainer(
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                SizedBox(
                  width: _scrollWidthMySelf,
                  height: _heightMySelf,
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: _scrollWidthMySelf,
                        height: _heightMySelf,
                      ),

                      Positioned(
                          bottom: 0,
                          left: _yAxisWidth,
                          child: Row(
                            children: [
                              for(int index = 0; index < widget.chartPointGroup.length; index++) Container(
                                width: _itemWidth,
                                margin: EdgeInsets.only(right: _itemBetweenPadding),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.chartPointGroup[index].x,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: xCategoryFontSize,
                                    fontWeight: widget.hitXIndex == index ? FontWeight.w600 : FontWeight.w500,
                                    color: widget.hitXIndex == index ? Colors.blue : Colors.grey
                                  ),
                                ),
                              )
                            ],
                          )
                      ),

                      Positioned(
                          bottom: _xAxisHeight,
                          left: _yAxisWidth,
                          child: Row(
                            children: [
                              for(int index = 0; index < widget.chartPointGroup.length; index++) Container(
                                margin: EdgeInsets.only(right: _itemBetweenPadding),
                                child: CustomDottedLine(
                                    width: _itemWidth,
                                    height: _graphHeight,
                                    lineWidth: 1,
                                    lineHeight: 6,
                                    space: 4,
                                    color: Colors.blue.withOpacity(0.15)
                                ),
                              )
                            ],
                          )
                      ),

                      Positioned(
                          bottom: _xAxisHeight - 1,
                          left: _yAxisWidth,
                          child: Container(
                            width: widget.chartPointGroup.length * (_itemWidth + _itemBetweenPadding),
                            height: 1,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                          )
                      ),

                      Positioned(
                          bottom: _xAxisHeight,
                          left: _yAxisWidth,
                          child: Row(
                            children: [
                              for(int index = 0; index < widget.chartPointGroup.length; index++) Container(
                                  width: _itemWidth,
                                  height: _graphHeight,
                                  margin: EdgeInsets.only(right: _itemBetweenPadding),
                                  padding: EdgeInsets.symmetric(horizontal: (_itemWidth - _itemBarWidth) / 2),
                                  alignment: Alignment.bottomCenter,
                                  child: AnimatedSize(
                                    duration: _animationDuration,
                                    child: Container(
                                      width: _itemBarWidth,
                                      height: (_graphHeight / widget.maxY) * widget.chartPointGroup[index].y,
                                      decoration: BoxDecoration(
                                          color: widget.hitXIndex == index ? Colors.blue : Colors.black,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                          )
                                      ),
                                    ),
                                  )
                              )
                            ],
                          )
                      ),

                      Positioned(
                          bottom: _xAxisHeight,
                          left: _yAxisWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              for(int index = 0; index < widget.chartPointGroup.length; index++) Container(
                                width: _itemWidth,
                                height: _graphHeight,
                                margin: EdgeInsets.only(right: _itemBetweenPadding),
                                child: OutlinedButton(
                                    onPressed: () {
                                      widget.onChangeSelectedIndex(index);
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
                          )
                      ),
                    ],
                  ),
                ),


                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      color: Colors.white,
                      height: _heightMySelf,
                      padding: EdgeInsets.only(top: _heightMySelf - _graphHeight - _xAxisHeight - 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        children: [

                          for(double number = widget.maxY; number >= 0; number -= _yAxisScale) Container(
                            width: _yAxisWidth,
                            height: number.toStringAsFixed(1) == '0.0' ? 30 : _yAxisUnitHeight,
                            alignment: Alignment.topCenter,
                            child: Text(
                              number.toStringAsFixed(1),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),


              ],
            ),
          );
        }
    );
  }
}