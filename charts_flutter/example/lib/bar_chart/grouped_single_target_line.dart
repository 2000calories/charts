// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GroupedBarSingleTargetLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarSingleTargetLineChart(this.seriesList, {this.animate});

  factory GroupedBarSingleTargetLineChart.withSampleData() {
    return new GroupedBarSingleTargetLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(seriesList,
        animate: animate,
        barGroupingType: charts.BarGroupingType.grouped,
        customSeriesRenderers: [
          new charts.BarTargetLineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customTargetLine',
              groupingType: charts.BarGroupingType.grouped)
        ]);
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    final targetLineData = [
      new OrdinalSales('2014', 30),
      new OrdinalSales('2015', 55),
      new OrdinalSales('2016', 15),
      new OrdinalSales('2017', 25),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Desktop',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Tablet',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: tableSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Mobile',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: mobileSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Desktop Target Line',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: targetLineData)
        // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customTargetLine'),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}