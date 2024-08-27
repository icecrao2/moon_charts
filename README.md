

## Description
Moon Graphs is a versatile library designed to create animated charts with ease. <br />
Whether you're visualizing data trends over time or comparing categories, Moon Graphs provides smooth animations that make your data come to life. <br /> 
With its intuitive API, you can quickly generate dynamic and visually appealing graphs that enhance the storytelling of your data. <br />
Perfect for developers and data analysts looking to add a polished, animated touch to their presentations and reports. <br />

![Group 10.png](Group%2010.png)

## Getting started

```
flutter pub add moon_graphs
```

## Usage

``` dart
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
          backgroundCardPadding: 5,
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
```
