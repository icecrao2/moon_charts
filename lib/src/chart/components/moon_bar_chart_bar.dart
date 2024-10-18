

part of chart_library;



class _MoonBarChartBar extends LeafRenderObjectWidget {

  final List<MoonChartPointUIModel> nodeGroup;
  final MoonChartBarStyleUIModel barStyle;
  final int hitXIndex;
  final double maxY;
  final Function(int index) onPressed;

  const _MoonBarChartBar({
    required this.nodeGroup,
    required this.hitXIndex,
    required this.barStyle,
    required this.maxY,
    required this.onPressed
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MoonBarChartBarRenderBox(
      nodeGroup: nodeGroup.map((e) => e).toList(),
      oldNodeGroup: nodeGroup.map((e) => e).toList(),
      hitXIndex: hitXIndex,
      barStyle: barStyle,
      maxY: maxY,
      onPressed: onPressed
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonBarChartBarRenderBox renderObject) {

    bool isChanged = false;

    if(renderObject.barStyle != barStyle) {
      renderObject.barStyle = barStyle;
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

    if(renderObject.nodeGroup != nodeGroup) {
      renderObject.oldNodeGroup = renderObject.nodeGroup.map((e) => e).toList();
      renderObject.nodeGroup = nodeGroup.map((e) => e).toList();
      renderObject.startAnimation();
    }
  }
}

class _MoonBarChartBarRenderBox extends RenderBox {

  late Ticker _ticker;
  double _progress = 0.0;
  bool _pointerDown = false;
  int _downIndexMemory = 0;
  double _tapDownPosition = 0;

  Function(int index) onPressed;
  List<MoonChartPointUIModel> nodeGroup;
  List<MoonChartPointUIModel> oldNodeGroup;
  MoonChartBarStyleUIModel barStyle;
  int hitXIndex;
  double maxY;

  _MoonBarChartBarRenderBox({
    required this.nodeGroup,
    required this.oldNodeGroup,
    required this.hitXIndex,
    required this.barStyle,
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
    if (elapsed.inMilliseconds >= barStyle.animationDuration.inMilliseconds) {
      _progress = 1.0;
      _ticker.stop();
    } else {
      _progress = elapsed.inMilliseconds / barStyle.animationDuration.inMilliseconds;
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
      ..strokeWidth = barStyle.lineWidth
      ..style = PaintingStyle.stroke
      ..color = barStyle.unSelectedColor;

    final circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = barStyle.unSelectedColor;

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

        if(nodeGroup[index].y == 0) {
          path
            ..moveTo(realScreenX + offset.dx, size.height + offset.dy)
            ..lineTo(realScreenX + offset.dx, realScreenY + offset.dy + 0.01);
        } else {
          path
            ..moveTo(realScreenX + offset.dx, size.height + offset.dy)
            ..lineTo(realScreenX + offset.dx, realScreenY + offset.dy);
        }

        circlePath.addOval(Rect.fromCircle(
            center: Offset(realScreenX + offset.dx, realScreenY + offset.dy),
            radius: paint.strokeWidth / 2));
      }

      canvas.drawPath(path, paint);
      canvas.drawPath(circlePath, circlePaint);

      _paintSelectedBar(context,offset);
    }
  }


  void _paintSelectedBar(PaintingContext context, Offset offset) {

    final Canvas canvas = context.canvas;
    int length = math.min(oldNodeGroup.length, nodeGroup.length);

    final paint = Paint()
      ..strokeWidth = barStyle.lineWidth
      ..style = PaintingStyle.stroke
      ..color = barStyle.selectedColor;

    final circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = barStyle.selectedColor;

    final Path circlePath = Path();
    final Path path = Path();


    int index = hitXIndex;

    double realScreenX = index * size.width / nodeGroup.length;

    double newDifference = index < length ? nodeGroup[index].y - oldNodeGroup[index].y : 0;
    double y = oldNodeGroup.isEmpty
        ? nodeGroup[index].y
        : (oldNodeGroup.length > index
        ? (oldNodeGroup[index].y + newDifference * _progress)
        : (nodeGroup[index].y));
    double realScreenY = size.height - (y * (size.height / maxY));

    if(nodeGroup[index].y == 0) {
      path
        ..moveTo(realScreenX + offset.dx, size.height + offset.dy)
        ..lineTo(realScreenX + offset.dx, realScreenY + offset.dy + 0.01);
    } else {
      path
        ..moveTo(realScreenX + offset.dx, size.height + offset.dy)
        ..lineTo(realScreenX + offset.dx, realScreenY + offset.dy);
    }


    circlePath.addOval(Rect.fromCircle(
        center: Offset(realScreenX + offset.dx, realScreenY + offset.dy),
        radius: paint.strokeWidth / 2));

    canvas.drawPath(path, paint);
    canvas.drawPath(circlePath, circlePaint);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {

    if (event is PointerDownEvent) {

      Offset tapPosition = event.localPosition;
      _tapDownPosition = event.localPosition.dx;

      double width = (barStyle.itemBetweenPadding + barStyle.touchAreaWidth) * nodeGroup.length;

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