

part of moon_linear_graph_library;



class MoonLinearGraph extends StatefulWidget {

  final List<MoonChartPointUIModel> chartPointGroup;
  final double maxY;
  final int hitXIndex;
  final Function(int) onChangeSelectedIndex;
  final int yAxisCount;
  final double barWidth;
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
    this.barWidth = 7,
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
  double get _itemBarWidth => widget.barWidth;
  int get _yAxisCount => widget.yAxisCount;

  double get _graphWidth => _widthMySelf * 0.88181818;
  double get _graphHeight => _heightMySelf * 0.7556390;

  double get _scrollWidthMySelf => ((widget.chartPointGroup.length + 1) * (_itemWidth + _itemBetweenPadding));
  double get _yAxisScale => widget.maxY / _yAxisCount;
  double get _yAxisWidth => _widthMySelf * 0.106061;
  double get _yAxisUnitHeight => _graphHeight / _yAxisCount;

  double get _xAxisHeight => _heightMySelf * 0.086466;

  late int hitXIndex;

  late _MoonLinearGraphLegend _legendWidget;
  late _MoonLinearGraphYLabel _yLabelWidget;
  late _MoonLinearGraphTouchArea _touchAreaWidget;
  late _MoonLinearGraphYAxisGroup _yAxisGroupWidget;
  late _MoonLinearGraphXLabel _xLabelWidget;

  @override
  void initState() {

    hitXIndex = widget.hitXIndex;

    _legendWidget = _MoonLinearGraphLegend(widget.legend);

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

        bool needsRebuild = constraints.maxHeight != _heightMySelf || constraints.maxWidth != _widthMySelf;

        if(needsRebuild) {

          _widthMySelf = constraints.maxWidth;
          _heightMySelf = constraints.maxHeight;

          _yLabelWidget = _MoonLinearGraphYLabel(
              height: _heightMySelf, maxY: widget.maxY,
              yAxisScale: _yAxisScale, yAxisWidth: _yAxisWidth,
              yAxisUnitHeight: _yAxisUnitHeight, xAxisLabelPrecision: widget.xAxisLabelPrecision,
              xAxisLabelSuffixUnit: widget.xAxisLabelSuffixUnit, textStyle: widget.yAxisTextStyle
          );

          _touchAreaWidget = _MoonLinearGraphTouchArea(
              tapAreaCount: widget.chartPointGroup.length, tapAreaWidth: _itemWidth,
              tapAreaHeight: _graphHeight, padding: EdgeInsets.only(right: _itemBetweenPadding),
              onPressed: (index) {
                if(hitXIndex != index) {
                  setState(() {
                    hitXIndex = index;
                    widget.onChangeSelectedIndex(index);
                  });
                }
              }
          );

          _yAxisGroupWidget = _MoonLinearGraphYAxisGroup(
              axisCount: widget.chartPointGroup.length,
              padding: EdgeInsets.only(right: _itemBetweenPadding),
              axisWidth: _itemWidth,
              axisHeight: _graphHeight,
              line: widget.dottedLineUIModel
          );

          _xLabelWidget = _MoonLinearGraphXLabel(
              chartPointGroup: widget.chartPointGroup,
              labelWidth: _itemWidth,
              labelMargin: EdgeInsets.only(right: _itemBetweenPadding),
              hitXIndex: hitXIndex,
              selectedXLabelTextStyle: widget.selectedXAxisTextStyle,
              unSelectedXLabelTextStyle: widget.unSelectedXAxisTextStyle
          );
        }


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
                      left: _yAxisWidth,
                      child: _xLabelWidget
                    ),

                    Positioned(
                      bottom: _xAxisHeight - widget.backgroundCardPadding.bottom,
                      left: _yAxisWidth,
                      child: _yAxisGroupWidget
                    ),

                    Positioned(
                      bottom: _xAxisHeight - widget.backgroundCardPadding.bottom,
                      left: _yAxisWidth + ((_itemBetweenPadding + _itemWidth) * hitXIndex),
                      child: MoonDottedLine.fromDottedLineUIModel(
                        width: _itemWidth,
                        height: _graphHeight,
                        dottedLineUIModel: widget.selectedDottedLineUIModel,
                      )
                    ),

                    Positioned(
                      top: widget.backgroundCardPadding.top,
                      left: _yAxisWidth + ((_itemWidth + _itemBetweenPadding) * hitXIndex),
                      child:  Text(
                        widget.chartPointGroup[hitXIndex].y.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),

                    Positioned(
                        bottom: _xAxisHeight ,
                        left: _yAxisWidth,
                        child: SizedBox(
                          width: widget.chartPointGroup.length * (_itemWidth + _itemBetweenPadding),
                          child: const Divider(
                            color: Colors.black,
                            height: 0,
                            thickness: 1,
                          ),
                        ),
                    ),

                    Positioned(
                        bottom: _xAxisHeight,
                        left: _yAxisWidth + _itemBetweenPadding + (_itemBarWidth / 2),
                        child: RepaintBoundary(
                          child: CustomPaint(
                            size: Size(_scrollWidthMySelf - _itemWidth - _itemBetweenPadding, _graphHeight),
                            painter: _MoonLinearGraphLinePainter(nodeGroup: widget.chartPointGroup, oldNodeGroup: oldChartPointGroup, animation: _animation),
                          ),
                        )
                    ),

                    Positioned(
                        bottom: _xAxisHeight,
                        left: _yAxisWidth,
                        child: _touchAreaWidget
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: _xAxisHeight,
                left: 0,
                child: _yLabelWidget
              ),

              Positioned(
                  top: widget.backgroundCardPadding.top / 2,
                  left: widget.backgroundCardPadding.left / 2,
                  child: _legendWidget,
              ),
            ],
          ),
        );
      }
    );
  }
}