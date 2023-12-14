// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

class TopicModel {
  String id;
  String nickName;

  String type;
  String userTopic;

  MqttQos willQoS;
  bool? disableSub;
  bool? retianed;
  String? variable;
  String? data;

  TopicModel({
    required this.id,
    required this.nickName,
    required this.type,
    required this.userTopic,
    required this.willQoS,
    this.disableSub,
    this.retianed,
    this.variable,
    this.data,
  });
}
