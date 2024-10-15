

part of moon_linear_graph_library;



class MoonLinearGraph extends StatefulWidget {

  final List<MoonChartPointUIModel> chartPointGroup;
  final double maxY;
  final int hitXIndex;
  final Function(int) onChangeSelectedIndex;
  final int yAxisCount;
  final double barTouchAreaWidth;
  final double itemBetweenPadding;

  final Color selectedBarColor;
  final Color unSelectedBarColor;
  final EdgeInsets backgroundCardPadding;
  final Duration animationDuration;
  final BoxShadow backgroundBoxShadow;

  final String legend;
  final int xAxisLabelPrecision;
  final String xAxisLabelSuffixUnit;
  final TextStyle unSelectedXAxisTextStyle;
  final TextStyle selectedXAxisTextStyle;
  final TextStyle yAxisTextStyle;
  final MoonDottedLineUIModel dottedLineUIModel;
  final MoonDottedLineUIModel selectedDottedLineUIModel;

  const MoonLinearGraph({
    super.key,
    required this.chartPointGroup,
    required this.maxY,
    required this.hitXIndex,
    required this.onChangeSelectedIndex,
    this.legend = "",
    this.xAxisLabelPrecision = 1,
    this.xAxisLabelSuffixUnit = "",
    this.yAxisCount = 5,
    this.backgroundCardPadding = const EdgeInsets.all(5),
    this.animationDuration = const Duration(milliseconds: 500),
    this.selectedBarColor = const Color.fromRGBO(89, 147, 255, 1),
    this.unSelectedBarColor = const Color.fromRGBO(161, 161, 161, 1),
    this.barTouchAreaWidth = 27,
    this.itemBetweenPadding = 10,
    this.unSelectedXAxisTextStyle = const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(81, 81, 81, 1),
    ),
    this.selectedXAxisTextStyle = const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(89, 147, 255, 1),
    ),
    this.yAxisTextStyle = const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(81, 81, 81, 1),
    ),
    this.dottedLineUIModel = const MoonDottedLineUIModel(
      dotWidth: 1,
      dotHeight: 6,
      space: 4,
      dotColor: Color.fromRGBO(89, 147, 255, 0.2),
    ),
    this.selectedDottedLineUIModel = const MoonDottedLineUIModel(
      dotWidth: 1,
      dotHeight: 6,
      space: 4,
      dotColor: Color.fromRGBO(89, 147, 255, 0.2),
    ),
    this.backgroundBoxShadow = const BoxShadow(
        color: Color.fromRGBO(200, 200, 200, 0.5),
        blurRadius: 5,
        spreadRadius: 0.1,
        offset: Offset(2, 2)
    ),
  });

  @override
  State<StatefulWidget> createState() => LinearGraphState();
}


class LinearGraphState extends State<MoonLinearGraph> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  late List<MoonChartPointUIModel> oldChartPointGroup;
  double _widthMySelf = 0;
  double _heightMySelf = 0;
  final ScrollController _scrollController = ScrollController();

  double get _itemBetweenPadding => widget.itemBetweenPadding;
  double get _itemWidth => widget.barTouchAreaWidth;
  int get _yAxisCount => widget.yAxisCount;

  double get _graphWidth => _widthMySelf * 0.88181818;
  double get _graphHeight => _heightMySelf * 0.7556390;

  double get _scrollWidthMySelf => ((widget.chartPointGroup.length + 1) * (_itemWidth + _itemBetweenPadding));
  double get _yAxisScale => widget.maxY / _yAxisCount;
  double get _yAxisWidth => _widthMySelf * 0.106061;
  double get _yAxisUnitHeight => _graphHeight / _yAxisCount;

  double get _xAxisHeight => _heightMySelf * 0.086466;

  late int hitXIndex;
  late ValueNotifier<int> hitXIndexNotifier;


  @override
  void initState() {

    hitXIndex = widget.hitXIndex;
    hitXIndexNotifier = ValueNotifier(hitXIndex);

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    oldChartPointGroup = widget.chartPointGroup.map((e) => e).toList();

    _controller.addStatusListener(_statusListener);


    super.initState();
  }

  @override
  void didUpdateWidget(covariant MoonLinearGraph oldWidget) {

    super.didUpdateWidget(oldWidget);


    if (widget.hitXIndex != hitXIndex) {
      hitXIndex = widget.hitXIndex;
      hitXIndexNotifier = ValueNotifier(hitXIndex);
      double scrollPoint = widget.hitXIndex * (_itemWidth + _itemBetweenPadding) - (_graphWidth / 2);
      scrollPoint = scrollPoint.clamp(0.0, _scrollController.position.maxScrollExtent);
      _scrollController.jumpTo(scrollPoint);
    }

    if(!const ListEquality().equals(oldChartPointGroup, widget.chartPointGroup) || oldWidget.chartPointGroup.isEmpty) {

      if(_controller.isAnimating) {
        _controller.stop();
      }
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.dispose();
    super.dispose();
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      oldChartPointGroup = widget.chartPointGroup.map((e) => e).toList();
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        _widthMySelf = constraints.maxWidth;
        _heightMySelf = constraints.maxHeight;

        return Container(
          padding: widget.backgroundCardPadding,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromRGBO(223, 230, 238, 1),
              width: 1,
            ),
            boxShadow:[
              widget.backgroundBoxShadow
            ]
          ),
          child: Stack(
            children: [

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
                      left: _yAxisWidth + _itemBetweenPadding,
                      child: SizedBox(
                        height: _xAxisHeight,
                        width: _scrollWidthMySelf,
                        child: ValueListenableBuilder(
                          valueListenable: hitXIndexNotifier,
                          builder: (_, hitXIndex, __) {
                            return _MoonLinearGraphXLabel(
                              chartPointGroup: widget.chartPointGroup,
                              labelWidth: _itemWidth + _itemBetweenPadding,
                              hitXIndex: hitXIndex,
                              selectedTextStyle: widget.selectedXAxisTextStyle,
                              unSelectedTextStyle: widget.unSelectedXAxisTextStyle
                            );
                          },
                        )
                      )
                    ),

                    ValueListenableBuilder(
                      valueListenable: hitXIndexNotifier,
                      builder: (_, hitXIndex, __) {
                        return Positioned(
                          top: widget.backgroundCardPadding.top,
                          left: _yAxisWidth + ((_itemWidth + _itemBetweenPadding) * hitXIndex),
                          child:  Text(
                            widget.chartPointGroup[hitXIndex].y.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        );
                      }
                    ),

                    ValueListenableBuilder(
                      valueListenable: hitXIndexNotifier,
                      builder: (_, hitXIndex, __) {
                        return Positioned(
                          bottom: _xAxisHeight,
                          left: _yAxisWidth + ((_itemBetweenPadding + _itemWidth) * hitXIndex) + (_itemWidth / 2),
                          child: SizedBox(
                            height: _graphHeight,
                            child: _MoonLinearGraphSelectedYAxis(line: widget.selectedDottedLineUIModel),
                          )
                        );
                      }
                    ),

                    Positioned(
                      bottom: _xAxisHeight,
                      left: _yAxisWidth + (_itemWidth / 2),
                      child: SizedBox(
                        width: _scrollWidthMySelf - _itemWidth - _itemBetweenPadding,
                        height: _graphHeight,
                        child: _MoonLinearGraphYAxisGroup(
                          tapAreaCount: widget.chartPointGroup.length,
                          tapAreaWidth: _itemWidth,
                          tapAreaRightPadding: _itemBetweenPadding,
                          line: widget.dottedLineUIModel,
                          onPressed: (index) {
                            if(hitXIndex != index) {
                              hitXIndex = index;
                              hitXIndexNotifier.value = index;
                              widget.onChangeSelectedIndex(index);
                            }
                          }
                        ),
                      )
                    ),

                    Positioned(
                      bottom: _xAxisHeight,
                      left:_yAxisWidth + (_itemWidth / 2),
                      child: RepaintBoundary(
                        child: IgnorePointer(
                          child: CustomPaint(
                            size: Size(_scrollWidthMySelf - _itemWidth - _itemBetweenPadding, _graphHeight),
                            painter: _MoonLinearGraphLinePainter(nodeGroup: widget.chartPointGroup, oldNodeGroup: oldChartPointGroup, animation: _animation),
                          ),
                        )
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
                  width: _yAxisWidth,
                  height: _heightMySelf,
                )
              ),

              Positioned(
                bottom: _xAxisHeight,
                left: 0,
                child: SizedBox(
                  height: _graphHeight,
                  width: _yAxisWidth,
                  child: _MoonLinearGraphYLabel(
                    maxY: widget.maxY,
                    yAxisScale: _yAxisScale,
                    yAxisUnitHeight: _yAxisUnitHeight,
                    xAxisLabelPrecision: widget.xAxisLabelPrecision,
                    xAxisLabelSuffixUnit: widget.xAxisLabelSuffixUnit,
                    textStyle: widget.yAxisTextStyle
                  ),
                )
              ),


              Positioned(
                top: widget.backgroundCardPadding.top / 2,
                left: widget.backgroundCardPadding.left / 2,
                child: _MoonLinearGraphLegend(widget.legend)
              ),
            ],
          ),
        );
      }
    );
  }
}
