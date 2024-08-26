import 'package:flutter/material.dart';
import 'package:moon_graphs/moon_graphs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        width: 300,
        height: 300,
        alignment: Alignment.center,
        child: MoonBarGraph(
          chartPointGroup: [
            MoonChartPointUIModel(x: '0', y: 1),
            MoonChartPointUIModel(x: '1', y: 20),
            MoonChartPointUIModel(x: '2', y: 10),
            MoonChartPointUIModel(x: '3', y: 40),
            MoonChartPointUIModel(x: '0', y: 10),
            MoonChartPointUIModel(x: '1', y: 20),
            MoonChartPointUIModel(x: '2', y: 10),
            MoonChartPointUIModel(x: '3', y: 40),
            MoonChartPointUIModel(x: '0', y: 10),
            MoonChartPointUIModel(x: '1', y: 20),
            MoonChartPointUIModel(x: '2', y: 10),
            MoonChartPointUIModel(x: '3', y: 40),
            MoonChartPointUIModel(x: '0', y: 10),
            MoonChartPointUIModel(x: '1', y: 20),
            MoonChartPointUIModel(x: '2', y: 10),
            MoonChartPointUIModel(x: '3', y: 40),
          ],
          maxY: 60,
          hitXIndex: 2,
          yAxisCount: 5,
          onChangeSelectedIndex: (index) {

          }
        ),
      ),

    );
  }
}
