

part of chart_library;



class _MoonChartXLabel extends LeafRenderObjectWidget {

  final List<MoonChartPointUIModel> chartPointGroup;
  final TextStyle unSelectedTextStyle;
  final TextStyle selectedTextStyle;
  final int hitXIndex;
  final double labelWidth;

  const _MoonChartXLabel({
    required this.chartPointGroup,
    required this.unSelectedTextStyle,
    required this.selectedTextStyle,
    required this.hitXIndex,
    required this.labelWidth,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MoonChartXLabelRenderBox(
      chartPointGroup: chartPointGroup,
      unSelectedTextStyle: unSelectedTextStyle,
      selectedTextStyle: selectedTextStyle,
      hitXIndex: hitXIndex,
      labelWidth: labelWidth
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonChartXLabelRenderBox renderObject) {

    bool isChanged = false;

    if (!const ListEquality().equals(renderObject.chartPointGroup, chartPointGroup)) {
      renderObject.chartPointGroup = chartPointGroup;
      isChanged = true;
    }
    if (renderObject.unSelectedTextStyle != unSelectedTextStyle) {
      renderObject.unSelectedTextStyle = unSelectedTextStyle;
      isChanged = true;
    }
    if (renderObject.selectedTextStyle != selectedTextStyle) {
      renderObject.selectedTextStyle = selectedTextStyle;
      isChanged = true;
    }
    if (renderObject.hitXIndex != hitXIndex) {
      renderObject.hitXIndex = hitXIndex;
      isChanged = true;
    }
    if (renderObject.labelWidth != labelWidth) {
      renderObject.labelWidth = labelWidth;
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
    return other is _MoonChartXLabel &&
        other.unSelectedTextStyle == unSelectedTextStyle &&
        const ListEquality().equals(other.chartPointGroup, chartPointGroup) &&
        other.selectedTextStyle == selectedTextStyle &&
        other.hitXIndex == hitXIndex &&
        other.labelWidth == labelWidth;
  }

  @override
  int get hashCode => Object.hash(unSelectedTextStyle, chartPointGroup, selectedTextStyle, hitXIndex, labelWidth);
}

class _MoonChartXLabelRenderBox extends RenderBox {

  late TextPainter _textPainter;
  List<MoonChartPointUIModel> chartPointGroup;
  TextStyle unSelectedTextStyle;
  TextStyle selectedTextStyle;
  int hitXIndex;
  double labelWidth;

  _MoonChartXLabelRenderBox({
    required this.chartPointGroup,
    required this.unSelectedTextStyle,
    required this.selectedTextStyle,
    required this.hitXIndex,
    required this.labelWidth,
  }) {
    _textPainter = TextPainter(textDirection: TextDirection.ltr, textAlign: TextAlign.center);
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {

    var canvas = context.canvas;
    var paint = ui.Paint()
      ..strokeWidth = 1
      ..color = Colors.black;

    List.generate(chartPointGroup.length, (index) {

      _textPainter.text = TextSpan(
        text: chartPointGroup[index].x,
        style: hitXIndex == index ? selectedTextStyle : unSelectedTextStyle
      );

      _textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);
      _textPainter.paint(canvas, ui.Offset(offset.dx + (labelWidth * index), offset.dy + (_textPainter.height / 2)));
    });

    canvas.drawLine(ui.Offset(0, offset.dy), ui.Offset(offset.dx + constraints.maxWidth, offset.dy), paint);
  }

  @override
  bool get isRepaintBoundary => true;
}
