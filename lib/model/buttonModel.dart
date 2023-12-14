// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mauto_iot/model/connectionModel.dart';

class ButtonModel {
  String id;
  String? nickName;
  String? leftPos;
  String? topPos;
  String? width;
  String? height;
  String? variable;
  String? variable_ID;
  ConnectionModel? value;
  Widget? offState;
  Widget? onState;
  String? onStateValue;
  String? offStateValue;
  ButtonModel({
    required this.id,
    this.nickName,
    this.leftPos,
    this.topPos,
    this.width,
    this.height,
    this.variable,
    this.variable_ID,
    this.value,
    this.offState,
    this.onState,
    this.onStateValue,
    this.offStateValue,
  });
}
