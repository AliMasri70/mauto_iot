// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mauto_iot/model/connectionModel.dart';

class LedModel {
  String id;
  String? nickName;
  String? leftPos;
  String? topPos;
  String? width;
  String? height;
  String? variable;
  String? variable_ID;
  String? topicName;
  ConnectionModel? value;
  Widget? offState;
  Widget? onState;
  String? onStateValue;
  String? offStateValue;
  String? displayData;
  String? gaugeData;
  String? gaugeDatamin;
  String? gaugeDatamax;
  String? sliderData;
  String? linearGuageData;
  String? linearGaugeDatamin;
  String? linearGaugeDatamax;
  String? regulatorData;
  LedModel(
      {required this.id,
      this.nickName,
      this.leftPos,
      this.topPos,
      this.width,
      this.height,
      this.variable,
      this.variable_ID,
      this.topicName,
      this.value,
      this.offState,
      this.onState,
      this.onStateValue,
      this.offStateValue,
      this.displayData,
      this.gaugeData,
      this.gaugeDatamin,
      this.gaugeDatamax,
      this.sliderData,
      this.linearGuageData,
      this.linearGaugeDatamin,
      this.linearGaugeDatamax,
      this.regulatorData});
}
