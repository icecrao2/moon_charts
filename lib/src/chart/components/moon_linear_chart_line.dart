

part of chart_library;




class _MoonLinearChartLine extends LeafRenderObjectWidget {

  final List<MoonChartPointUIModel> nodeGroup;
  final MoonChartLineStyleUIModel lineStyle;
  final int hitXIndex;
  final double maxY;
  final Function(int index) onPressed;

  const _MoonLinearChartLine({
    required this.nodeGroup,
    required this.hitXIndex,
    required this.lineStyle,
    required this.maxY,
    required this.onPressed
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MoonBarChartLineRenderBox(
        nodeGroup: nodeGroup.map((e) => e).toList(),
        oldNodeGroup: nodeGroup.map((e) => e).toList(),
        hitXIndex: hitXIndex,
        lineStyle: lineStyle,
        maxY: maxY,
        onPressed: onPressed
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonBarChartLineRenderBox renderObject) {

    bool isChanged = false;
    bool isAnimationReady = false;

    if(renderObject.nodeGroup != nodeGroup) {
      renderObject.oldNodeGroup = renderObject.nodeGroup.map((e) => e).toList();
      renderObject.nodeGroup = nodeGroup.map((e) => e).toList();
      isAnimationReady = true;
    }
    if(renderObject.lineStyle != lineStyle) {
      renderObject.lineStyle = lineStyle;
      isChanged = true;
    }
    if(renderObject.hitXIndex != hitXIndex) {
      renderObject.hitXIndex = hitXIndex;
      isChanged = true;
    }
    if(renderObject.maxY != maxY) {
      renderObject.maxY = maxY;
      isChanged = true;
    }

    if(isChanged) {
      renderObject.markNeedsLayout();
    }
    if(isAnimationReady) {
      renderObject.startAnimation();
    }
  }
}

class _MoonBarChartLineRenderBox extends RenderBox {

  late Ticker _ticker;
  double _progress = 0.0;
  bool _pointerDown = false;
  int _downIndexMemory = 0;
  double _tapDownPosition = 0;

  Function(int index) onPressed;
  List<MoonChartPointUIModel> nodeGroup;
  List<MoonChartPointUIModel> oldNodeGroup;
  MoonChartLineStyleUIModel lineStyle;
  int hitXIndex;
  double maxY;

  _MoonBarChartLineRenderBox({
    required this.nodeGroup,
    required this.oldNodeGroup,
    required this.hitXIndex,
    required this.lineStyle,
    required this.maxY,
    required this.onPressed
  }) {
    _downIndexMemory = hitXIndex;
    _ticker = Ticker(_tick);
    _ticker.start();
  }

  void startAnimation() {
    if(_ticker.isTicking) {
      _ticker.stop();
    }
    _progress = 0;
    _ticker.start();
  }

  void _tick(Duration elapsed) {
    if (elapsed.inMilliseconds >= lineStyle.animationDuration.inMilliseconds) {
      _progress = 1.0;
      _ticker.stop();
    } else {
      _progress = elapsed.inMilliseconds / lineStyle.animationDuration.inMilliseconds;
    }
    markNeedsPaint();
  }

  @override
  void detach() {
    _ticker.dispose();
    super.detach();
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final paint = Paint()
      ..strokeWidth = lineStyle.lineWidth
      ..style = PaintingStyle.stroke
      ..color = lineStyle.lineColor;

    final circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = lineStyle.unSelectedCircleColor;

    final Path circlePath = Path();
    final Path path = Path();

    if (nodeGroup.isNotEmpty) {
      int length = math.min(oldNodeGroup.length, nodeGroup.length);

      for (int index = 0; index < nodeGroup.length; index++) {
        double realScreenX = index * size.width / nodeGroup.length;

        double newDifference = index < length ? nodeGroup[index].y - oldNodeGroup[index].y : 0;
        double y = oldNodeGroup.isEmpty
            ? nodeGroup[index].y
            : (oldNodeGroup.length > index
            ? (oldNodeGroup[index].y + newDifference * _progress)
            : (nodeGroup[index].y));
        double realScreenY = size.height - (y * (size.height / maxY));

        if(index == 0) {
          path.moveTo(realScreenX + offset.dx, realScreenY + offset.dy);
        } else {
          path.lineTo(realScreenX + offset.dx, realScreenY + offset.dy);
        }

        circlePath.addOval(
            Rect.fromCircle(
                center: Offset(realScreenX + offset.dx, realScreenY + offset.dy),
                radius: lineStyle.unSelectedCircleRadius
            )
        );
      }

      canvas.drawPath(path, paint);
      canvas.drawPath(circlePath, circlePaint);

      _paintSelectedCircle(context,offset);
    }
  }

  void _paintSelectedCircle(PaintingContext context, Offset offset) {

    final Canvas canvas = context.canvas;
    int length = math.min(oldNodeGroup.length, nodeGroup.length);

    final circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = lineStyle.selectedCircleColor;

    final Path circlePath = Path();

    int index = hitXIndex;

    double realScreenX = index * size.width / nodeGroup.length;

    double newDifference = index < length ? nodeGroup[index].y - oldNodeGroup[index].y : 0;
    double y = oldNodeGroup.isEmpty
        ? nodeGroup[index].y
        : (oldNodeGroup.length > index
        ? (oldNodeGroup[index].y + newDifference * _progress)
        : (nodeGroup[index].y));
    double realScreenY = size.height - (y * (size.height / maxY));


    circlePath.addOval(Rect.fromCircle(
      center: Offset(realScreenX + offset.dx, realScreenY + offset.dy),
      radius: lineStyle.selectedCircleRadius)
    );

    canvas.drawPath(circlePath, circlePaint);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {

    if (event is PointerDownEvent) {

      Offset tapPosition = event.localPosition;
      _tapDownPosition = tapPosition.dx;

      double width = (lineStyle.itemBetweenPadding + lineStyle.touchAreaWidth) * nodeGroup.length;

      int index = ((tapPosition.dx / width) * nodeGroup.length).round();

      _downIndexMemory = index;

      _pointerDown = true;

    } else if(event is PointerMoveEvent && _pointerDown) {

      if((_tapDownPosition - event.localPosition.dx).abs() > 5) {
        _downIndexMemory = hitXIndex;

        _pointerDown = false;
      }

    } else if(event is PointerUpEvent && _pointerDown) {

      hitXIndex = _downIndexMemory;

      _pointerDown = false;

      onPressed(hitXIndex);

      markNeedsPaint();
    }
  }

  @override
  bool get isRepaintBoundary => true;
}