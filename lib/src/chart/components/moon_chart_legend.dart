

part of chart_library;



class _MoonChartLegend extends LeafRenderObjectWidget {
  final String _legend;

  const _MoonChartLegend(this._legend,);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MoonChartLegendRenderBox(text: _legend);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonChartLegendRenderBox renderObject) {
    if (renderObject.text != _legend) {
      debugPrint('update render legend');
      renderObject.text = _legend;
      renderObject.markNeedsLayout();
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is _MoonChartLegend &&
        other._legend == _legend;
  }

  @override
  int get hashCode => _legend.hashCode;
}


class _MoonChartLegendRenderBox extends RenderBox {

  late TextPainter _textPainter;
  final TextStyle _textStyle;
  String text;

  _MoonChartLegendRenderBox({required this.text,})
    :_textStyle = const TextStyle(fontSize: 10, color: Colors.black)
  {
    _textPainter = TextPainter(textDirection: TextDirection.ltr,);
  }

  @override
  void performLayout() {
    _textPainter.text = TextSpan(text: text, style: _textStyle);
    _textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);

    size = Size(_textPainter.width, _textPainter.height);
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void paint(PaintingContext context, Offset offset) {

    debugPrint('paint legend');

    _textPainter.paint(context.canvas, offset);
  }
}