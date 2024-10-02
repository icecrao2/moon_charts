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
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        ),
        child: child!,
      ),
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
    MoonChartPointUIModel(x: '0', y: 100),
    MoonChartPointUIModel(x: '1', y: 20),
    MoonChartPointUIModel(x: '2', y: 10),
    MoonChartPointUIModel(x: '3', y: 40),
    MoonChartPointUIModel(x: '0', y: 100),
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
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              child: MoonLinearGraph(
                chartPointGroup: chartPointGroup,
                maxY: 100,
                hitXIndex: _hitIndex,
                yAxisCount: 4,
                onChangeSelectedIndex: (index) {
                  setState(() {
                    _hitIndex = index;
                  });
                },
                backgroundCardPadding: const EdgeInsets.all(5),
                animationDuration: const Duration(milliseconds: 500),
                selectedBarColor: Colors.blue,
                unSelectedBarColor: Colors.grey,
                barWidth: 7,
                barTouchAreaWidth: 27,
                itemBetweenPadding: 10,
                xAxisLabelPrecision: 0,
                xAxisLabelSuffixUnit: "%",
                legend: "FEV1%",
                unSelectedXAxisTextStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),
                selectedXAxisTextStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue
                ),
                yAxisTextStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),
                dottedLineUIModel: MoonDottedLineUIModel(
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
                    color: Color.fromRGBO(200, 200, 200, 0.5),
                    blurRadius: 5,
                    spreadRadius: 0.1,
                    offset: Offset(2, 2)
                ),
              ),
            ),


            Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              child: MoonBarGraph(
                chartPointGroup: chartPointGroup,
                maxY: 60,
                hitXIndex: _hitIndex,
                yAxisCount: 5,
                onChangeSelectedIndex: (index) {
                  setState(() {
                    _hitIndex = index;
                  });
                },
                backgroundCardPadding: const EdgeInsets.all(5),
                animationDuration: const Duration(milliseconds: 500),
                selectedBarColor: Colors.blue,
                unSelectedBarColor: Colors.grey,
                barWidth: 7,
                barTouchAreaWidth: 27,
                itemBetweenPadding: 10,
                unSelectedXAxisTextStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),
                selectedXAxisTextStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue
                ),
                yAxisTextStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),
                dottedLineUIModel: MoonDottedLineUIModel(
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

                ElevatedButton(
                    onPressed: () {
                      setState(() {

                        chartPointGroup = [
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                          const MoonChartPointUIModel(x: '3', y: 40),
                        ];
                        _hitIndex = 10;
                      });
                    },
                    child: Text('aa')
                ),
              ],
            )
          ],
        ),
      )

    );
  }
}
