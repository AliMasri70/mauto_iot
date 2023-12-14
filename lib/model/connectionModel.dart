import 'package:flutter/material.dart';
import 'package:mauto_iot/model/topicModel.dart';
import 'package:mauto_iot/model/VariableModel.dart';
import 'package:mqtt_client/mqtt_client.dart';

class ConnectionModel {
  String connectionId;
  List<VariableModel> variableList;
  List<TopicModel> topicList;

  String nickName;
  IconData icon;
  String clientId;
  String url;
  int port;
  String? userName;
  String? password;
  String userTopic;

  String? encryption;
  int timeOut;
  int keepAlive;
  String mqttVersion;
  String lastWillTopic;
  String lastWillMsg;
  bool sessionClean;
  MqttQos willQoS;
  bool retained;
  String status;

  ConnectionModel(
      {this.encryption,
      this.password,
      this.userName,
      required this.connectionId,
      required this.variableList,
      required this.topicList,
      required this.nickName,
      required this.icon,
      required this.clientId,
      required this.url,
      required this.port,
      required this.userTopic,
      required this.timeOut,
      required this.keepAlive,
      required this.mqttVersion,
      required this.lastWillTopic,
      required this.lastWillMsg,
      required this.sessionClean,
      required this.willQoS,
      required this.retained,
      required this.status});
  get getVariableList => this.variableList;

  set setVariableList(variableList) => this.variableList = variableList;

  get getTopicList => this.topicList;

  set setTopicList(topicList) => this.topicList = topicList;

  get getConnectionId => connectionId;

  set setConnectionId(final connectionId) => this.connectionId = connectionId;

  get getNickName => this.nickName;

  set setNickName(nickName) => this.nickName = nickName;

  get getIcon => this.icon;

  set setIcon(icon) => this.icon = icon;

  get getClientId => this.clientId;

  set setClientId(clientId) => this.clientId = clientId;

  get getUrl => this.url;

  set setUrl(url) => this.url = url;

  get getPort => this.port;

  set setPort(port) => this.port = port;

  get getUserName => this.userName;

  set setUserName(userName) => this.userName = userName;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getUserTopic => this.userTopic;

  set setUserTopic(userTopic) => this.userTopic = userTopic;

  get getEncryption => this.encryption;

  set setEncryption(encryption) => this.encryption = encryption;

  get getTimeOut => this.timeOut;

  set setTimeOut(timeOut) => this.timeOut = timeOut;

  get getKeepAlive => this.keepAlive;

  set setKeepAlive(keepAlive) => this.keepAlive = keepAlive;

  get getMqttVersion => this.mqttVersion;

  set setMqttVersion(mqttVersion) => this.mqttVersion = mqttVersion;

  get getLastWillTopic => this.lastWillTopic;

  set setLastWillTopic(lastWillTopic) => this.lastWillTopic = lastWillTopic;

  get getLastWillMsg => this.lastWillMsg;

  set setLastWillMsg(lastWillMsg) => this.lastWillMsg = lastWillMsg;

  get getSessionClean => this.sessionClean;

  set setSessionClean(sessionClean) => this.sessionClean = sessionClean;

  get getRetained => this.retained;

  set setRetained(retained) => this.retained = retained;

  void setStatus(String s) {
    status = s;
  }
}
