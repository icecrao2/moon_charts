

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../moon_graphs.dart';
import '../common/common_lib.dart';



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
  void initState() {

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    oldChartPointGroup = widget.chartPointGroup.map((e) => e).toList();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MoonLinearGraph oldWidget) {

    super.didUpdateWidget(oldWidget);

    if(!isEqual(oldChartPointGroup, widget.chartPointGroup) || oldWidget.chartPointGroup.isEmpty) {
      _controller.forward(from: 0.0).then((value) {
        oldChartPointGroup = oldWidget.chartPointGroup.map((e) => e).toList();
      });
    }

    if(oldWidget.chartPointGroup.isEmpty || oldWidget.chartPointGroup != widget.chartPointGroup) {
      double scrollPoint = widget.hitXIndex * (_itemWidth + _itemBetweenPadding) - (_graphWidth / 2);
      _scrollController.jumpTo(scrollPoint);
    }
  }


  bool isEqual(List<MoonChartPointUIModel> list1, List<MoonChartPointUIModel> list2) {
    if (list1.length != list2.length) {
      return false; // 길이가 다르면 다름
    }
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].x != list2[i].x || list1[i].y != list2[i].y) {
        return false; // 요소가 다르면 다름
      }
    }

    return true; // 모든 요소가 같으면 같음
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                                  dottedLineUIModel: widget.hitXIndex == index ? widget.selectedDottedLineUIModel : widget.dottedLineUIModel
                                )
                            )
                          ],
                        )
                    ),

                    Positioned(
                        top: widget.backgroundCardPadding.top,
                        left: _yAxisWidth,
                        child: Row(
                          children: [
                            for(int index = 0; index < widget.chartPointGroup.length; index++) SizedBox(
                              width: _itemWidth + _itemBetweenPadding,
                              child: Text(
                                widget.hitXIndex == index ? widget.chartPointGroup[index].y.toStringAsFixed(2) : "",
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600
                                ),
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
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                        )
                    ),

                    Positioned(
                        bottom: _xAxisHeight,
                        left: _yAxisWidth + _itemBetweenPadding + (_itemBarWidth / 2),
                        child: CustomPaint(
                          size: Size(_scrollWidthMySelf - _itemWidth - _itemBetweenPadding, _graphHeight),
                          painter: _MoonLinearGraphPainter(nodeGroup: widget.chartPointGroup, oldNodeGroup: oldChartPointGroup, animation: _animation),
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
                    width: _yAxisWidth,
                    height: _heightMySelf,
                    color: Colors.white,
                  )
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
                            "${number.toStringAsFixed(widget.xAxisLabelPrecision)}${widget.xAxisLabelSuffixUnit}",
                            textAlign: TextAlign.center,
                            style: widget.yAxisTextStyle
                          ),
                        )
                      ],
                    ),
                  )
              ),


              Positioned(
                  top: widget.backgroundCardPadding.top / 2,
                  left: widget.backgroundCardPadding.left / 2,
                  child: Text(
                    widget.legend,
                    style: const TextStyle(
                      fontSize: 10,
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










class _MoonLinearGraphPainter extends CustomPainter {

  final List<MoonChartPointUIModel> nodeGroup;
  final List<MoonChartPointUIModel> oldNodeGroup;
  final Animation<double> animation;

  List<double> get _different {
    List<double> x = [];

    int length = oldNodeGroup.length > nodeGroup.length ? nodeGroup.length : oldNodeGroup.length;

    for(int index = 0 ; index < length ; index = index + 1) {
      x.add(nodeGroup[index].y - oldNodeGroup[index].y);
    }
    return x;
  }

  const _MoonLinearGraphPainter({required this.nodeGroup, required this.oldNodeGroup, required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue.withOpacity(1);

    Path path = Path();

    if (nodeGroup.isNotEmpty) {

      for (int index = 0; index < nodeGroup.length; index++) {

        double x = index * size.width / nodeGroup.length;

        double newDifference = _different.length > index ? _different[index] : 0;
        double newFev1Per = oldNodeGroup.isEmpty ? nodeGroup[index].y : (oldNodeGroup.length > index ? (oldNodeGroup[index].y + newDifference * animation.value) : (nodeGroup[index].y)) ;
        double y = size.height - (newFev1Per * (size.height / 100));

        Offset center = Offset(x, y);

        if (index == 0) {
          path.moveTo(center.dx, center.dy);
        } else {
          path.lineTo(center.dx, center.dy);
        }

        canvas.drawCircle(center, 3, fillPaint);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}