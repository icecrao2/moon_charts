import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon_charts/moon_charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _hitIndex = 10;

  late List<MoonChartPointUIModel> chartPointGroup = [];

  _MyHomePageState() {
    getRandomChart();
  }

  void getRandomChart() {
    if(chartPointGroup.isEmpty) {
      chartPointGroup = [
        MoonChartPointUIModel(x: '3', y: 0),
        MoonChartPointUIModel(x: '3', y: 10),
        MoonChartPointUIModel(x: '3', y: null),
        MoonChartPointUIModel(x: '3', y: 10),

        MoonChartPointUIModel(x: '4', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '5ss', y: null),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '5s', y: null),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
        MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble()),
      ];
    } else {
      List.generate(chartPointGroup.length, (index) {
        chartPointGroup[index] = MoonChartPointUIModel(x: '3', y: Random().nextInt(100).toDouble());
      });
    }
  }

  void getZeroChart() {
    List.generate(chartPointGroup.length, (index) {
      chartPointGroup[index] = MoonChartPointUIModel(x: '3', y: 0);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Moon Chart'),
        ),
        body: Container(
          color: Colors.red,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  child: MoonChart.linearChart(
                    backgroundColor: Colors.transparent,
                    chartPointGroup: chartPointGroup,
                    hitXIndex: _hitIndex,
                    onChangeSelectedIndex: (index) {
                      _hitIndex = index;
                    },
                    isShowingSelectedYValue: true,
                    style: const MoonChartLineStyleUIModel.fromDefault(),
                    backgroundCardPadding: const EdgeInsets.all(5),
                    legend: "FEV1%",
                    unSelectedDottedLineUIModel: MoonDottedLineUIModel(
                        dotWidth: 1,
                        dotHeight: 6,
                        space: 0,
                        dotColor: Colors.blue.withOpacity(0.5)
                    ),
                    selectedDottedLineUIModel: MoonDottedLineUIModel(
                        dotWidth: 2,
                        dotHeight: 6,
                        space: 0,
                        dotColor: Colors.blue.withOpacity(1)
                    ),
                    backgroundBoxShadow: const BoxShadow(
                        color: Colors.transparent,
                        // blurRadius: 5,
                        // spreadRadius: 0.1,
                        // offset: Offset(2, 2)
                    ),
                  ),
                ),


                Container(
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  child: MoonChart.barChart(
                    chartPointGroup: chartPointGroup,
                    hitXIndex: _hitIndex,
                    isShowingSelectedYValue: true,
                    onChangeSelectedIndex: (index) {
                      _hitIndex = index;
                    },
                    legend: "min",
                    backgroundCardPadding: const EdgeInsets.all(5),
                    unSelectedDottedLineUIModel: MoonDottedLineUIModel(
                        dotWidth: 1,
                        dotHeight: 6,
                        space: 4,
                        dotColor: Colors.blue.withOpacity(0.5)
                    ),
                    backgroundBoxShadow: const BoxShadow(
                        color: Color.fromRGBO(200, 200, 200, 0.5),
                        blurRadius: 5,
                        spreadRadius: 0.1,
                        offset: Offset(2, 2)
                    ),
                    style: const MoonChartBarStyleUIModel.fromDefault(),
                    yAxisLabelStyle: const MoonChartYLabelStyleUIModel(
                        max: 100,
                        labelCount: 5,
                        labelPrecision: 0,
                        labelSuffixUnit: "",
                        textStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(81, 81, 81, 1),
                        )
                    ),
                    xAxisLabelStyle: const MoonChartXLabelStyleUIModel(
                      selectedTextStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(89, 147, 255, 1),
                      ),
                      unSelectedTextStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(81, 81, 81, 1),
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [

                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            getRandomChart();
                            _hitIndex = Random().nextInt(25);
                          });
                        },
                        child: const Text('aa')
                    ),

                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            getZeroChart();
                            _hitIndex = Random().nextInt(25);
                          });
                        },
                        child: const Text('aa')
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}

