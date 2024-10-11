

part of moon_linear_graph_library;



class _MoonLinearGraphLegend extends LeafRenderObjectWidget {

  final String legend;

  const _MoonLinearGraphLegend(this.legend);

  @override
  _MoonLinearGraphLegendRenderBox createRenderObject(BuildContext context) {
    return _MoonLinearGraphLegendRenderBox(text: legend);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MoonLinearGraphLegendRenderBox renderObject) {
    renderObject
      ..text = legend
      ..needsPaint = true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is _MoonLinearGraphLegend && other.legend == legend;
  }

  @override
  int get hashCode => legend.hashCode;
}


class _MoonLinearGraphLegendRenderBox extends RenderBox {
  final TextPainter _textPainter;
  String text;
  bool needsPaint = false;

  _MoonLinearGraphLegendRenderBox({required this.text})
    : _textPainter = TextPainter(textDirection: TextDirection.ltr,);

  @override
  void performLayout() {
    _textPainter.text = TextSpan(text: text, style: const TextStyle(fontSize: 10, color: Colors.black),);

    _textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);
    size = Size(_textPainter.width, _textPainter.height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {

    final canvas = context.canvas;

    _textPainter.paint(canvas, offset);
  }
}