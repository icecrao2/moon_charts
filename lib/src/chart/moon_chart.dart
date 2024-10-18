

part of chart_library;



class MoonChart extends StatefulWidget {

  final List<MoonChartPointUIModel> chartPointGroup;
  final int hitXIndex;
  final Function(int) onChangeSelectedIndex;
  final EdgeInsets backgroundCardPadding;
  final BoxShadow backgroundBoxShadow;
  final String legend;
  final bool isShowingSelectedYValue;

  final MoonDottedLineUIModel unSelectedDottedLineUIModel;
  final MoonDottedLineUIModel selectedDottedLineUIModel;
  final MoonChartYLabelStyleUIModel yAxisLabelStyle;
  final MoonChartXLabelStyleUIModel xAxisLabelStyle;
  final MoonChartStyle style;

  const MoonChart.linearChart({
    super.key,
    required this.chartPointGroup,
    required this.hitXIndex,
    required this.onChangeSelectedIndex,
    required MoonChartLineStyleUIModel this.style,
    this.isShowingSelectedYValue = false,
    this.backgroundCardPadding = const EdgeInsets.all(5),
    this.legend = "",
    this.unSelectedDottedLineUIModel = const MoonDottedLineUIModel.fromDefault(),
    this.selectedDottedLineUIModel = const MoonDottedLineUIModel.fromDefault(),
    this.yAxisLabelStyle = const MoonChartYLabelStyleUIModel.fromDefault(),
    this.xAxisLabelStyle = const MoonChartXLabelStyleUIModel.fromDefault(),
    this.backgroundBoxShadow = const BoxShadow(
      color: Color.fromRGBO(200, 200, 200, 0.5),
      blurRadius: 5,
      spreadRadius: 0.1,
      offset: Offset(2, 2)
    ),
  });

  const MoonChart.barChart({
    super.key,
    required this.chartPointGroup,
    required this.hitXIndex,
    required this.onChangeSelectedIndex,
    required MoonChartBarStyleUIModel this.style,
    this.isShowingSelectedYValue = false,
    this.backgroundCardPadding = const EdgeInsets.all(5),
    this.legend = "",
    this.unSelectedDottedLineUIModel = const MoonDottedLineUIModel.fromDefault(),
    this.selectedDottedLineUIModel = const MoonDottedLineUIModel.fromDefault(),
    this.yAxisLabelStyle = const MoonChartYLabelStyleUIModel.fromDefault(),
    this.xAxisLabelStyle = const MoonChartXLabelStyleUIModel.fromDefault(),
    this.backgroundBoxShadow = const BoxShadow(
        color: Color.fromRGBO(200, 200, 200, 0.5),
        blurRadius: 5,
        spreadRadius: 0.1,
        offset: Offset(2, 2)
    ),
  });


  @override
  State<StatefulWidget> createState() => _MoonChartState();
}


class _MoonChartState extends State<MoonChart> {

  double _widthMySelf = 0;
  double _heightMySelf = 0;
  final ScrollController _scrollController = ScrollController();

  double get _itemBetweenPadding => widget.style.itemBetweenPadding;
  double get _itemWidth => widget.style.touchAreaWidth;
  int get _yAxisCount => widget.yAxisLabelStyle.labelCount;

  double get _chartWidth => _widthMySelf * 0.88181818;
  double get _chartHeight => _heightMySelf * 0.7556390;

  double get _scrollWidthMySelf => ((widget.chartPointGroup.length + 1) * (_itemWidth + _itemBetweenPadding));
  double get _yAxisScale => widget.yAxisLabelStyle.max / _yAxisCount;
  double get _yAxisWidth => _widthMySelf * 0.106061;
  double get _yAxisUnitHeight => _chartHeight / _yAxisCount;

  double get _xAxisHeight => _heightMySelf * 0.086466;

  late int hitXIndex;
  late ValueNotifier<int> hitXIndexNotifier;


  @override
  void initState() {
    hitXIndex = widget.hitXIndex;
    hitXIndexNotifier = ValueNotifier(hitXIndex);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MoonChart oldWidget) {

    super.didUpdateWidget(oldWidget);

    if (widget.hitXIndex != hitXIndex) {
      hitXIndex = widget.hitXIndex;
      hitXIndexNotifier = ValueNotifier(hitXIndex);
      double scrollPoint = widget.hitXIndex * (_itemWidth + _itemBetweenPadding) - (_chartWidth / 2);
      scrollPoint = scrollPoint.clamp(0.0, _scrollController.position.maxScrollExtent);
      _scrollController.animateTo(scrollPoint, duration: widget.style.animationDuration, curve: Curves.linear);
    }
  }

  LeafRenderObjectWidget? getChart() {
    if(widget.style is MoonChartBarStyleUIModel) {
      return _MoonBarChartBar(
        hitXIndex: hitXIndex,
        barStyle: widget.style as MoonChartBarStyleUIModel,
        nodeGroup: widget.chartPointGroup,
        maxY: widget.yAxisLabelStyle.max,
        onPressed: (index) {
          hitXIndex =  index;
          hitXIndexNotifier.value = index;
          widget.onChangeSelectedIndex(index);
        },
      );
    } else if(widget.style is MoonChartLineStyleUIModel) {
      return _MoonLinearChartLine(
        hitXIndex: hitXIndex,
        lineStyle: widget.style as MoonChartLineStyleUIModel,
        nodeGroup: widget.chartPointGroup,
        maxY: widget.yAxisLabelStyle.max,
        onPressed: (index) {
          hitXIndex =  index;
          hitXIndexNotifier.value = index;
          widget.onChangeSelectedIndex(index);
        },
      );
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
                                  return _MoonChartXLabel(
                                      chartPointGroup: widget.chartPointGroup,
                                      labelWidth: _itemWidth + _itemBetweenPadding,
                                      hitXIndex: hitXIndex,
                                      selectedTextStyle: widget.xAxisLabelStyle.selectedTextStyle,
                                      unSelectedTextStyle: widget.xAxisLabelStyle.unSelectedTextStyle
                                  );
                                },
                              )
                          )
                      ),

                      Visibility(
                        visible: widget.isShowingSelectedYValue,
                        child: ValueListenableBuilder(
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
                      ),

                      ValueListenableBuilder(
                        valueListenable: hitXIndexNotifier,
                        builder: (_, hitXIndex, __) {
                          return Positioned(
                            bottom: _xAxisHeight,
                            left: _yAxisWidth + ((_itemBetweenPadding + _itemWidth) * hitXIndex) + (_itemWidth / 2),
                            child: SizedBox(
                              height: _chartHeight,
                              child: _MoonChartSelectedYAxis(line: widget.selectedDottedLineUIModel),
                            )
                          );
                        }
                      ),

                      Positioned(
                          bottom: _xAxisHeight,
                          left: _yAxisWidth + (_itemWidth / 2),
                          child: SizedBox(
                            width: _scrollWidthMySelf - _itemWidth - _itemBetweenPadding,
                            height: _chartHeight,
                            child: _MoonChartYAxisGroup(
                              tapAreaCount: widget.chartPointGroup.length,
                              tapAreaWidth: _itemWidth,
                              tapAreaRightPadding: _itemBetweenPadding,
                              line: widget.unSelectedDottedLineUIModel,
                            ),
                          )
                      ),

                      Positioned(
                        bottom: _xAxisHeight,
                        left: _yAxisWidth + (_itemWidth / 2),
                        child: SizedBox(
                          width: _scrollWidthMySelf - _itemWidth - _itemBetweenPadding,
                          height: _chartHeight,
                          child: getChart()!
                        ),
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
                      height: _chartHeight,
                      width: _yAxisWidth,
                      child: _MoonChartYLabel(
                          maxY: widget.yAxisLabelStyle.max,
                          yAxisScale: _yAxisScale,
                          yAxisUnitHeight: _yAxisUnitHeight,
                          xAxisLabelPrecision: widget.yAxisLabelStyle.labelPrecision,
                          xAxisLabelSuffixUnit: widget.yAxisLabelStyle.labelSuffixUnit,
                          textStyle: widget.yAxisLabelStyle.textStyle
                      ),
                    )
                ),


                Positioned(
                    top: widget.backgroundCardPadding.top / 2,
                    left: widget.backgroundCardPadding.left / 2,
                    child: _MoonChartLegend(widget.legend)
                ),
              ],
            ),
          );
        }
    );
  }
}