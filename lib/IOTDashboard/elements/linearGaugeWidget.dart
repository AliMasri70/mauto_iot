import 'package:flutter/material.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LinearGaugeWidget extends StatelessWidget {
  final String value;
  final String min;
  final String max;

  const LinearGaugeWidget(
      {required this.value, required this.min, required this.max});

  @override
  Widget build(BuildContext context) {
    // final double range =
    //     (double.parse(min.toString()) + double.parse(max.toString())) / 2;
    // final double secndRange = range * 2;

    return Center(
        child: SfLinearGauge(
      minimum: double.parse(min),
      maximum: double.parse(max),
      orientation: LinearGaugeOrientation.vertical,
      ranges: [
        LinearGaugeRange(
          startValue: double.parse(min),
          endValue: double.parse(max),
        ),
      ],
      markerPointers: [
        LinearShapePointer(
          value: double.parse(value),
        ),
      ],
      barPointers: [LinearBarPointer(value: double.parse(value))],
    ));
  }
}
