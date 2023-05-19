import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ColumnGraph extends StatelessWidget {
  final List<int> data;

  ColumnGraph({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<int, String>> seriesList = [
      charts.Series(
          id: "Data",
          data: data,
          domainFn: (int data, _) => data.toString(),
          measureFn: (int data, _) => data,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault)
    ];

    return Container(
        height: 300,
        padding: EdgeInsets.all(16),
        child: charts.BarChart(
          seriesList,
          animate: true,
        ));
  }
}
