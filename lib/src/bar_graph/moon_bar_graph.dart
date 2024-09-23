

import 'package:flutter/material.dart';
import '../common/common_lib.dart';
import '../ui_model/ui_model_lib.dart';



class MoonBarGraph extends StatefulWidget {

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

  final TextStyle unSelectedXAxisTextStyle;
  final TextStyle selectedXAxisTextStyle;
  final TextStyle yAxisTextStyle;
  final MoonDottedLineUIModel dottedLineUIModel;

  const MoonBarGraph({
    super.key,
    required this.chartPointGroup,
    required this.maxY,
    required this.hitXIndex,
    required this.onChangeSelectedIndex,
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
    this.backgroundBoxShadow = const BoxShadow(
        color: Color.fromRGBO(200, 200, 200, 0.5),
        blurRadius: 5,
        spreadRadius: 0.1,
        offset: Offset(2, 2)
    ),
  });

  @override
  State<StatefulWidget> createState() => _BarChartState();
}

class _BarChartState extends State<MoonBarGraph> {

  late double _widthMySelf;
  late double _heightMySelf;
  final ScrollController _scrollController = ScrollController();

  double get _itemBetweenPadding => widget.itemBetweenPadding;
  double get _itemWidth => widget.barTouchAreaWidth;
  double get _itemBarWidth => widget.barWidth;
  int get _yAxisCount => widget.yAxisCount;
  Duration get _animationDuration => widget.animationDuration;

  double get _graphWidth => _widthMySelf * 0.88181818;
  double get _graphHeight => _heightMySelf * 0.7556390;

  double get _scrollWidthMySelf => ((widget.chartPointGroup.length + 1) * (_itemWidth + _itemBetweenPadding));
  double get _yAxisScale => widget.maxY / _yAxisCount;
  double get _yAxisWidth => _widthMySelf * 0.106061;
  double get _yAxisUnitHeight => _graphHeight / _yAxisCount;

  double get _xAxisHeight => _heightMySelf * 0.086466;

  @override
  void didUpdateWidget(covariant MoonBarGraph oldWidget) {

    if(oldWidget.chartPointGroup != widget.chartPointGroup ) {
      double scrollPoint = widget.hitXIndex * (_itemWidth + _itemBetweenPadding) - (_graphWidth / 2);
      _scrollController.jumpTo(scrollPoint);
    }

    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {

    return  LayoutBuilder(
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
                                  style: widget.hitXIndex == index ? widget.selectedXAxisTextStyle : widget.unSelectedXAxisTextStyle
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
                                child: MoonDottedLine.fromDottedLineUIModel(
                                  width: _itemWidth,
                                  height: _graphHeight,
                                  dottedLineUIModel: widget.dottedLineUIModel
                                )
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
                            decoration: const BoxDecoration(
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
                                  child: AnimatedContainer(
                                    duration: _animationDuration,
                                    width: _itemBarWidth,
                                    height: (_graphHeight / widget.maxY) * widget.chartPointGroup[index].y,
                                    decoration: BoxDecoration(
                                        color: widget.hitXIndex == index ? widget.selectedBarColor : widget.unSelectedBarColor,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        )
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
                    bottom: _xAxisHeight,
                    left: 0,
                    child: Container(
                      color: Colors.white,
                      height: _heightMySelf,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        verticalDirection: VerticalDirection.down,
                        children: [

                          for(double number = widget.maxY; number >= 0; number -= _yAxisScale) Container(
                            width: _yAxisWidth,
                            height: _yAxisUnitHeight,
                            alignment: Alignment.bottomCenter,
                            child: Text(
                                number.toStringAsFixed(1),
                                textAlign: TextAlign.center,
                                style: widget.yAxisTextStyle
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



