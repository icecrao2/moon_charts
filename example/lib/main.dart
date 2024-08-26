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

  int _hitIndex = 10;

  List<MoonChartPointUIModel> chartPointGroup = [
    MoonChartPointUIModel(x: '0', y: 40),
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
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            width: 300,
            height: 300,
            alignment: Alignment.center,
            child: MoonBarGraph(
              chartPointGroup: chartPointGroup,
              maxY: 60,
              hitXIndex: _hitIndex,
              yAxisCount: 5,
              barTouchAreaWidth: 27,
              itemBetweenPadding: 10,
              onChangeSelectedIndex: (index) {
                setState(() {
                  _hitIndex = index;
                });
              },
            ),
          ),

          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      chartPointGroup[0] = const MoonChartPointUIModel(x: '3', y: 10);
                      chartPointGroup[1] = const MoonChartPointUIModel(x: '1', y: 40);
                      _hitIndex = 9;
                    });
                  },
                  child: Text('aa')
              ),

              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      chartPointGroup[0] = const MoonChartPointUIModel(x: '3', y: 40);
                      chartPointGroup[1] = const MoonChartPointUIModel(x: '1', y: 10);
                      _hitIndex = 9;
                    });
                  },
                  child: Text('aa')
              ),
            ],
          )
        ],
      )

    );
  }
}
