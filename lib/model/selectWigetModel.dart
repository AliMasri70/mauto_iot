import 'package:flutter/material.dart';
import 'package:mauto_iot/IOTDashboard/configPages/buttonConfigs.dart';
import 'package:mauto_iot/IOTDashboard/configPages/digitalDisplayConfig.dart';
import 'package:mauto_iot/IOTDashboard/configPages/frameConfig.dart';
import 'package:mauto_iot/IOTDashboard/configPages/gaugeConfig.dart';
import 'package:mauto_iot/IOTDashboard/configPages/imageConfig.dart';
import 'package:mauto_iot/IOTDashboard/configPages/labelConfig.dart';
import 'package:mauto_iot/IOTDashboard/configPages/ledConfigs.dart';
import 'package:mauto_iot/IOTDashboard/configPages/linearGaugeConfig.dart';
import 'package:mauto_iot/IOTDashboard/configPages/regulatorConfig.dart';
import 'package:mauto_iot/IOTDashboard/configPages/rotarySwitchConfig.dart';
import 'package:mauto_iot/IOTDashboard/elements/rotarySwitch.dart';
import 'package:mauto_iot/IOTDashboard/configPages/sliderConfig.dart';
import 'package:mauto_iot/SignUp/SignUpPage.dart';
import 'package:mauto_iot/signIn/SignInMainPage.dart';

class SelectWidget {
  final int selectwidgetId;
  final String img;
  final String title;

  ///
  SelectWidget({
    required this.selectwidgetId,
    required this.img,
    required this.title,
  });
}

List<SelectWidget> listOfSelectWidget = [
  SelectWidget(
    selectwidgetId: 1,
    img: "assets/images/led.png",
    title: "Led",
  ),
  SelectWidget(
    selectwidgetId: 2,
    img: "assets/images/button.png",
    title: "Button",
  ),
  SelectWidget(
    selectwidgetId: 3,
    img: "assets/images/valuedisplay.png",
    title: "Value Display",
  ),
  SelectWidget(
    selectwidgetId: 4,
    img: "assets/images/gauge.png",
    title: "Gauge",
  ),
  SelectWidget(
    selectwidgetId: 5,
    img: "assets/images/label.png",
    title: "Label",
  ),
  SelectWidget(
    selectwidgetId: 6,
    img: "assets/images/frame.png",
    title: "Frame",
  ),
  SelectWidget(
    selectwidgetId: 7,
    img: "assets/images/slider.png",
    title: "Slider",
  ),
  SelectWidget(
    selectwidgetId: 8,
    img: "assets/images/image.png",
    title: "Image",
  ),
  SelectWidget(
    selectwidgetId: 9,
    img: "assets/images/linear.png",
    title: "Linear Gauge",
  ),
  SelectWidget(
    selectwidgetId: 10,
    img: "assets/images/regulator.png",
    title: "Regulator",
  ),
  SelectWidget(
    selectwidgetId: 11,
    img: "assets/images/rotary.png",
    title: "Rotary Switch",
  ),
];

List<Widget> pages1 = [
  LedConfigs(),
  ButtonConfigs(),
  DigitalDisplayConfigs(),
  GaugeConfigs(),
  LabelConfig(),
  FrameConfig(),
  SliderConfig(),
  ImageConfig(),
  LinearGaugeConfig(),
  RegulatorConfig(),
  RotarySwitchConfig(),
];
