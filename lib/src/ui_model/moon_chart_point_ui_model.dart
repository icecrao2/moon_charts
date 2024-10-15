

part of ui_model_library;



class MoonChartPointUIModel {
  final String x;
  final double y;

  const MoonChartPointUIModel({required this.x, required this.y});

  @override
  bool operator ==(Object other) {

    if (other is MoonChartPointUIModel) {
      return x == other.x && y == other.y;
    }
    return false;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

}