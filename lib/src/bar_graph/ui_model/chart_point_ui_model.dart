

part of bar_graph_library;



class ChartPointUIModel {
  final String x;
  final double y;

  ChartPointUIModel({required this.x, required this.y});
}

double findMaxY(List<ChartPointUIModel> points) {
  if (points.isEmpty) {
    return 0.0;
  }

  double maxY = points[0].y;
  for (int i = 1; i < points.length; i++) {
    if (points[i].y > maxY) {
      maxY = points[i].y;
    }
  }
  return maxY;
}