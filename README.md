

## Description
Moon Graphs is a versatile library designed to create animated charts with ease. <br />
Whether you're visualizing data trends over time or comparing categories, Moon Graphs provides smooth animations that make your data come to life. <br /> 
With its intuitive API, you can quickly generate dynamic and visually appealing graphs that enhance the storytelling of your data. <br />
Perfect for developers and data analysts looking to add a polished, animated touch to their presentations and reports. <br />

![video.gif](video.gif)

## Getting started

```
flutter pub add moon_charts
```

## Usage

1. linear chart
``` dart
   Container(
    width: 300,
    height: 300,
    alignment: Alignment.center,
    child: MoonChart.linearChart(
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
          color: Color.fromRGBO(200, 200, 200, 0.5),
          blurRadius: 5,
          spreadRadius: 0.1,
          offset: Offset(2, 2)
      ),
    ),
  ),
```

2. bar chart
``` dart
   Container(
    width: 300,
    height: 300,
    alignment: Alignment.center,
    child: MoonChart.barChart(
      chartPointGroup: chartPointGroup,
      hitXIndex: _hitIndex,
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
          max: 120,
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
```