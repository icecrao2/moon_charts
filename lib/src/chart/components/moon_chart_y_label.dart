

part of chart_library;



class _MoonChartYLabel extends LeafRenderObjectWidget {

  final TextStyle textStyle;
  final double maxY;
  final double yAxisScale;
  final int xAxisLabelPrecision;
  final String xAxisLabelSuffixUnit;
  final double yAxisUnitHeight;

  const _MoonChartYLabel({
    required this.textStyle,
    required this.maxY,
    required this.yAxisScale,
    required this.xAxisLabelPrecision,
    required this.xAxisLabelSuffixUnit,
    required this.yAxisUnitHeight
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MoonChartYLabelRenderBox(
      textStyle: textStyle,
      maxY: maxY,
      yAxisScale: yAxisScale,
      xAxisLabelPrecision: xAxisLabelPrecision,
      xAxisLabelSuffixUnit: xAxisLabelSuffixUnit,
      yAxisUnitHeight: yAxisUnitHeight
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonChartYLabelRenderBox renderObject) {

    debugPrint('y label update render');

    bool isChanged = false;

    if (renderObject.textStyle != textStyle) {
      renderObject.textStyle = textStyle;
      isChanged = true;
    }
    if (renderObject.maxY != maxY) {
      renderObject.maxY = maxY;
      isChanged = true;
    }
    if (renderObject.yAxisScale != yAxisScale) {
      renderObject.yAxisScale = yAxisScale;
      isChanged = true;
    }
    if (renderObject.xAxisLabelPrecision != xAxisLabelPrecision) {
      renderObject.xAxisLabelPrecision = xAxisLabelPrecision;
      isChanged = true;
    }
    if (renderObject.xAxisLabelSuffixUnit != xAxisLabelSuffixUnit) {
      renderObject.xAxisLabelSuffixUnit = xAxisLabelSuffixUnit;
      isChanged = true;
    }
    if(renderObject.yAxisUnitHeight != yAxisUnitHeight) {
      renderObject.yAxisUnitHeight = yAxisUnitHeight;
      isChanged = true;
    }

    if(isChanged) {
      renderObject.markNeedsLayout();
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is _MoonChartYLabel &&
        other.textStyle == textStyle &&
        other.maxY == maxY &&
        other.yAxisScale == yAxisScale &&
        other.xAxisLabelPrecision == xAxisLabelPrecision &&
        other.xAxisLabelSuffixUnit == xAxisLabelSuffixUnit;
  }

  @override
  int get hashCode => Object.hash(textStyle, maxY, yAxisScale, xAxisLabelPrecision, xAxisLabelSuffixUnit);
}

class _MoonChartYLabelRenderBox extends RenderBox {

  late TextPainter _textPainter;
  TextStyle textStyle;
  double maxY;
  double yAxisScale;
  int xAxisLabelPrecision;
  String xAxisLabelSuffixUnit;
  double yAxisUnitHeight;


  _MoonChartYLabelRenderBox({
    required this.textStyle,
    required this.maxY,
    required this.yAxisScale,
    required this.xAxisLabelPrecision,
    required this.xAxisLabelSuffixUnit,
    required this.yAxisUnitHeight,
  }) {
    _textPainter = TextPainter(textDirection: TextDirection.ltr, textAlign: TextAlign.center);
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {

    debugPrint('y label paint');

    var canvas = context.canvas;

    final Paint paint = Paint()..color = Colors.white;
    canvas.drawRect(offset & size, paint);

    List.generate((maxY / yAxisScale).ceil() + 1, (index) {
      final double number = maxY - index * yAxisScale;

      _textPainter.text = TextSpan(
          text: "${number.toStringAsFixed(xAxisLabelPrecision)}$xAxisLabelSuffixUnit",
          style: textStyle
      );
      _textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);
      _textPainter.paint(canvas, ui.Offset(offset.dx, offset.dy + (yAxisUnitHeight * index) - _textPainter.height));
    });
  }

  @override
  bool get isRepaintBoundary => true;
}