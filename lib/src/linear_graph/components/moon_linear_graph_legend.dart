

part of moon_linear_graph_library;



class _MoonLinearGraphLegend extends StatelessWidget {

  final String _legend;

  const _MoonLinearGraphLegend(this._legend);

  @override
  Widget build(BuildContext context) {

    debugPrint('rebuild legend');

    return Text(
      _legend,
      style: const TextStyle(
        fontSize: 10,
      ),
    );
  }
}

