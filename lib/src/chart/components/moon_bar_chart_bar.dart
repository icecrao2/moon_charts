part of '../chart_lib.dart';

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
    required this.onPressed,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MoonBarChartBarRenderBox(
      nodeGroup: nodeGroup.toList(),
      oldNodeGroup: nodeGroup.toList(),
      hitXIndex: hitXIndex,
      barStyle: barStyle,
      maxY: maxY,
      onPressed: onPressed,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonBarChartBarRenderBox renderObject) {
    bool isChanged = false;
    if (renderObject.style != barStyle) {
      renderObject.style = barStyle;
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

class _MoonBarChartBarRenderBox extends _MoonChartRenderBoxBase<MoonChartBarStyleUIModel> {
  _MoonBarChartBarRenderBox({
    required super.nodeGroup,
    required super.oldNodeGroup,
    required super.hitXIndex,
    required MoonChartBarStyleUIModel barStyle,
    required super.maxY,
    required super.onPressed,
  }) : super(
          style: barStyle,
        );

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..strokeWidth = style.lineWidth
      ..style = PaintingStyle.stroke
      ..color = style.unSelectedColor;
    final Paint circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = style.unSelectedColor;
    final Path path = Path();
    final Path circlePath = Path();

    if (nodeGroup.isNotEmpty) {
      for (int index = 0; index < nodeGroup.length; index++) {
        if (nodeGroup[index].y == null) {
          continue;
        }
        double realScreenX = index * size.width / nodeGroup.length;
        double yValue = _interpolateValue(index);
        double realScreenY = size.height - (yValue * (size.height / maxY));
        if (nodeGroup[index].y != 0) {
          path.moveTo(realScreenX + offset.dx, size.height + offset.dy);
          path.lineTo(realScreenX + offset.dx, realScreenY + offset.dy);
          circlePath.addArc(
            Rect.fromCircle(
                center: Offset(realScreenX + offset.dx, realScreenY + offset.dy), radius: paint.strokeWidth / 2),
            math.pi,
            math.pi,
          );
        }
      }
      canvas.drawPath(path, paint);
      canvas.drawPath(circlePath, circlePaint);
      _paintSelectedBar(context, offset);
    }
  }

  void _paintSelectedBar(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..strokeWidth = style.lineWidth
      ..style = PaintingStyle.stroke
      ..color = style.selectedColor;
    final Paint circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = style.selectedColor;
    final Path path = Path();
    final Path circlePath = Path();
    int index = hitXIndex;
    if (nodeGroup[index].y == null) {
      return;
    }
    if (nodeGroup[index].y == 0) {
      return;
    }
    double yValue = _interpolateValue(index);
    double realScreenX = index * size.width / nodeGroup.length;
    double realScreenY = size.height - (yValue * (size.height / maxY));
    path.moveTo(realScreenX + offset.dx, size.height + offset.dy);
    path.lineTo(realScreenX + offset.dx, realScreenY + offset.dy);
    circlePath.addArc(
      Rect.fromCircle(center: Offset(realScreenX + offset.dx, realScreenY + offset.dy), radius: paint.strokeWidth / 2),
      math.pi,
      math.pi,
    );
    canvas.drawPath(path, paint);
    canvas.drawPath(circlePath, circlePaint);
  }
}
