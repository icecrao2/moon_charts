

part of moon_linear_graph_library;



class _MoonLinearGraphLegend extends LeafRenderObjectWidget {
  final String _legend;

  const _MoonLinearGraphLegend(this._legend,);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MoonLinearGraphLegendRenderBox(text: _legend);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonLinearGraphLegendRenderBox renderObject) {
    if (renderObject.text != _legend) {
      renderObject.text = _legend;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is _MoonLinearGraphLegend &&
        other._legend == _legend;
  }

  @override
  int get hashCode => _legend.hashCode;
}


class _MoonLinearGraphLegendRenderBox extends RenderBox {

  late TextPainter _textPainter;
  final TextStyle _textStyle;
  String text;

  _MoonLinearGraphLegendRenderBox({required this.text,})
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
  void paint(PaintingContext context, Offset offset) {
    print('paint');
    _textPainter.paint(context.canvas, offset);
  }

  @override
  bool get isRepaintBoundary => true;
}