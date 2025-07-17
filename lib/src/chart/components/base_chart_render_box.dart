part of '../chart_lib.dart';

abstract class BaseChartRenderBox<T> extends RenderBox {
  BaseChartRenderBox({
    required List<T> points,
    required ValueNotifier<int?> hitXIndexNotifier,
  })  : _points = points,
        _hitXIndexNotifier = hitXIndexNotifier;

  final List<T> _points;
  final ValueNotifier<int?> _hitXIndexNotifier;

  int getIndexByPosition(Offset position);
  void paintPoint(Canvas canvas, int index);

  @override
  void paint(PaintingContext ctx, Offset offset) {
    for (var i = 0; i < _points.length; i++) {
      paintPoint(ctx.canvas, i);
    }
  }
}