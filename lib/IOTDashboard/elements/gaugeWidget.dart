import 'package:flutter/material.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatelessWidget {
  final String value;
  final String min;
  final String max;

  const GaugeWidget(
      {required this.value, required this.min, required this.max});

  @override
  Widget build(BuildContext context) {
    final double range =
        (double.parse(min.toString()) + double.parse(max.toString())) / 3;
    final double secndRange = range * 2;
    return Center(
        child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 2000,
            axes: <RadialAxis>[
          RadialAxis(

              labelsPosition: ElementsPosition.outside,

              axisLabelStyle: const GaugeTextStyle(fontSize: 5),
              minimum: double.parse(min.toString()),
              maximum: double.parse(max.toString()),
              ranges: <GaugeRange>[
                GaugeRange(
                    labelStyle: const GaugeTextStyle(fontSize: 2),
                    startValue: double.parse(min.toString()),
                    endValue: range,
                    color: Colors.green),
                GaugeRange(
                    labelStyle: const GaugeTextStyle(fontSize: 2),
                    startValue: range,
                    endValue: secndRange,
                    color: Colors.orange),
                GaugeRange(
                    labelStyle: const GaugeTextStyle(fontSize: 2),
                    startValue: secndRange,
                    endValue: double.parse(max.toString()),
                    color: Colors.red)
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                    value: double.parse(value.toString()),
                    needleEndWidth: 4,
                    needleStartWidth: 0.5,
                    needleLength: 0.45,
                    needleColor: textColor.withOpacity(0.8))
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Text(value, style: const TextStyle(fontSize: 8)),
                    angle: 90,
                    positionFactor: 0.5)
              ])
        ]));
  }
}
