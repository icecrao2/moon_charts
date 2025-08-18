part of '../chart_lib.dart';

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
      index = index.clamp(0, nodeGroup.length - 1);
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
    if (oldNodeGroup.length > index) {
      double oldY = oldNodeGroup[index].y ?? 0.0;
      double newY = nodeGroup[index].y ?? 0.0;
      return oldY + (newY - oldY) * _progress;
    } else {
      return nodeGroup[index].y ?? 0.0;
    }
  }
}