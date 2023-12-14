import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MqttConnectionMain.dart';
import 'package:mauto_iot/model/connectionModel.dart';
import 'package:mauto_iot/model/topicModel.dart';
import 'package:mauto_iot/utils/IOTListProvider.dart';
import 'package:mauto_iot/utils/topicProvider.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'package:provider/provider.dart';
import 'package:mauto_iot/model/VariableModel.dart';
import '../../utils/variablesProvider.dart';

class ConnectionListProvider extends ChangeNotifier {
  List<ConnectionModel> _connectionsList = [];
  Timer timer = new Timer.periodic(Duration(seconds: 0), (Timer t) {});
  List<ConnectionModel> get connectionsList => List.from(_connectionsList);
  // MqttHandler mqttHandler = MqttHandler();
  void addConnection(ConnectionModel model) {
    _connectionsList.add(model);

    notifyListeners();
  }

  void startTimer(BuildContext context) {
    print("in timerrr");
    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      Provider.of<WidgetModel>(context, listen: false).onUpdateValues(context);
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  void removeConnection(String id) {
    _connectionsList.removeWhere(
      (element) => element.connectionId == id,
    );
    notifyListeners();
  }

  void disconnectMqtt(
      ConnectionModel model, String url, String id, String topic) {
    // MqttServerClient(url, id).disconnect();

    unsubscribeFromTopic(topic);
    // MqttServerClient(url, id).onUnsubscribed;
    model.setStatus("Disconnected");
    notifyListeners();
  }



  String getNicknameForConnectionId(String connectionId) {
    var connection = _connectionsList.firstWhere(
      (element) => element.connectionId == connectionId,
      orElse: () => _connectionsList[0],
    );
    return connection?.getNickName ?? '';
  }

  List<VariableModel> getvariableListForConnectionId(String connectionId) {
    List<VariableModel> connection = _connectionsList
        .firstWhere(
          (element) => element.connectionId == connectionId,
        )
        .variableList;

    return connection;
  }

  List<TopicModel> gettopicListForConnectionId(String connectionId) {
    List<TopicModel> connection = _connectionsList
        .firstWhere(
          (element) => element.connectionId == connectionId,
        )
        .topicList;

    return connection;
  }

  ConnectionModel getConnectionModelbyuID(String connectionId) {
    ConnectionModel connection = _connectionsList.firstWhere(
      (element) => element.connectionId == connectionId,
    );

    return connection;
  }

  void refresh() {
    notifyListeners();
  }

  Future<void> reconnectMqtt(
      BuildContext context,
      ConnectionModel model,
      String url,
      String clientIdentifier,
      int keepAlivePeriod,
      int port,
      int connectTimeoutPeriod,
      String willtopic,
      String WillMessage,
      String userName,
      String pass,
      String userTopic,
      bool cleanSession,
      MqttQos willQoS,
      String mqttVersion,
      String encryption,
      bool retained) async {
    List<String> topicstoSub = [];
    List<TopicModel> list2 =
        Provider.of<TopicListProvider>(context, listen: false).topicList;
    List<VariableModel> list =
        Provider.of<VariableListProvider>(context, listen: false).variableList;
    // if (list2.isNotEmpty) {
    //   for (int i = 0; i < list2.length; i++) {
    //     topicstoSub.add(list2[i].userTopic);
    //   }
    // }
    await MqttConnectionMain((String topic, String message) {
      // updateTopicValue(topic, message);
      print("lasttest: $topic $message");
    },
        list,
        list2,
        url,
        clientIdentifier,
        keepAlivePeriod,
        port,
        connectTimeoutPeriod,
        willtopic,
        WillMessage,
        userName,
        pass,
        userTopic,
        cleanSession,
        willQoS,
        mqttVersion,
        encryption,
        retained);
    model.setStatus("Connected");
    notifyListeners();
  }

  void updateConnection(ConnectionModel model) {
    print("updateeeeeee");

    _connectionsList
        .removeWhere((element) => element.connectionId == model.connectionId);
    _connectionsList.add(model);

    notifyListeners();
  }
}
