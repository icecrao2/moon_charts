

part of chart_library;


class _MoonChartRenderBoxBase<T extends MoonChartStyle> extends RenderBox {
  late T style;
  late List<MoonChartPointUIModel> nodeGroup;
  late List<MoonChartPointUIModel> oldNodeGroup;
  late int hitXIndex;
  late double maxY;
  late Function(int) onPressed;

  late Ticker _ticker;
  double _progress = 0.0;
  bool _pointerDown = false;
  int _downIndexMemory;
  double _tapDownPosition = 0.0;

  _MoonChartRenderBoxBase({
    required this.nodeGroup,
    required this.oldNodeGroup,
    required this.hitXIndex,
    required this.style,
    required this.maxY,
    required this.onPressed,
  }) : _downIndexMemory = hitXIndex {
    _ticker = Ticker(_tick);
    _ticker.start();
  }

  void _tick(Duration elapsed) {
    if (elapsed.inMilliseconds >= style.animationDuration.inMilliseconds) {
      _progress = 1.0;
      _ticker.stop();
    } else {
      _progress = elapsed.inMilliseconds / style.animationDuration.inMilliseconds;
    }
    markNeedsPaint();
  }

  void startAnimation() {
    if (_ticker.isTicking) {
      _ticker.stop();
    }
    _progress = 0.0;
    _ticker.start();
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
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent) {
      Offset tapPosition = event.localPosition;
      _tapDownPosition = tapPosition.dx;
      double width = (style.itemBetweenPadding + style.touchAreaWidth) * nodeGroup.length;
      int index = ((tapPosition.dx / width) * nodeGroup.length).round();
      _pointerDown = true;
      if (nodeGroup[index].y == null) {
        return;
      }
      _downIndexMemory = index;
    } else if (event is PointerMoveEvent && _pointerDown) {
      if ((_tapDownPosition - event.localPosition.dx).abs() > 5) {
        _downIndexMemory = hitXIndex;
        _pointerDown = false;
      }
    } else if (event is PointerUpEvent && _pointerDown) {
      hitXIndex = _downIndexMemory;
      _pointerDown = false;
      onPressed(hitXIndex);
      markNeedsPaint();
    }
  }

  @override
  bool get isRepaintBoundary => true;

  double _interpolateValue(int index) {
    if (oldNodeGroup.isEmpty) {
      return nodeGroup[index].y ?? 0.0;
    }
    int length = math.min(oldNodeGroup.length, nodeGroup.length);
    if (index < length) {
      double oldY = oldNodeGroup[index].y ?? 0.0;
      double newY = nodeGroup[index].y ?? 0.0;
    }
    if (oldNodeGroup.length > index) {
      double oldY = oldNodeGroup[index].y ?? 0.0;
      double newY = nodeGroup[index].y ?? 0.0;
      return oldY + (newY - oldY) * _progress;
    } else {
      return nodeGroup[index].y ?? 0.0;
    }
  }
}

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
    required this.onPressed,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MoonLinearChartLineRenderBox(
      nodeGroup: nodeGroup.toList(),
      oldNodeGroup: nodeGroup.toList(),
      hitXIndex: hitXIndex,
      lineStyle: lineStyle,
      maxY: maxY,
      onPressed: onPressed,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonLinearChartLineRenderBox renderObject) {
    bool isChanged = false;
    if (renderObject.style != lineStyle) {
      renderObject.style = lineStyle;
      isChanged = true;
    }
    if (renderObject.hitXIndex != hitXIndex) {
      renderObject.hitXIndex = hitXIndex;
      isChanged = true;
    }
    if (renderObject.maxY != maxY) {
      renderObject.maxY = maxY;
      isChanged = true;
    }
    if (isChanged) {
      renderObject.markNeedsLayout();
    }
    if (renderObject.nodeGroup != nodeGroup) {
      renderObject.oldNodeGroup = List.from(renderObject.nodeGroup);
      renderObject.nodeGroup = nodeGroup.toList();
      renderObject.startAnimation();
    }
  }
}

class _MoonLinearChartLineRenderBox extends _MoonChartRenderBoxBase<MoonChartLineStyleUIModel> {
  _MoonLinearChartLineRenderBox({
    required super.nodeGroup,
    required super.oldNodeGroup,
    required super.hitXIndex,
    required MoonChartLineStyleUIModel lineStyle,
    required super.maxY,
    required super.onPressed,
  }) : super(
    style: lineStyle,
  );

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..strokeWidth = style.lineWidth
      ..style = PaintingStyle.stroke
      ..color = style.lineColor;
    final Paint circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = style.unSelectedCircleColor;
    final Path path = Path();
    final Path circlePath = Path();

    if (nodeGroup.isNotEmpty) {
      int dataCount = nodeGroup.length;
      for (int index = 0; index < dataCount; index++) {
        if (nodeGroup[index].y == null) {
          continue;
        }
        double realScreenX = index * size.width / dataCount;
        double yValue = _interpolateValue(index);
        double realScreenY = size.height - (yValue * (size.height / maxY));
        if (index == 0) {
          path.moveTo(realScreenX + offset.dx, realScreenY + offset.dy);
        } else {
          path.lineTo(realScreenX + offset.dx, realScreenY + offset.dy);
        }
        circlePath.addOval(Rect.fromCircle(
          center: Offset(realScreenX + offset.dx, realScreenY + offset.dy),
          radius: style.unSelectedCircleRadius,
        ));
      }
      canvas.drawPath(path, paint);
      canvas.drawPath(circlePath, circlePaint);
      _paintSelectedCircle(context, offset);
    }
  }

  void _paintSelectedCircle(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    int index = hitXIndex;
    if (nodeGroup[index].y == null) {
      return;
    }
    double yValue = _interpolateValue(index);
    double realScreenX = index * size.width / nodeGroup.length;
    double realScreenY = size.height - (yValue * (size.height / maxY));
    final Paint circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = style.selectedCircleColor;
    final Path circlePath = Path();
    circlePath.addOval(Rect.fromCircle(
      center: Offset(realScreenX + offset.dx, realScreenY + offset.dy),
      radius: style.selectedCircleRadius,
    ));
    canvas.drawPath(circlePath, circlePaint);
  }
}