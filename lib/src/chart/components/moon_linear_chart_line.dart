part of '../chart_lib.dart';

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
