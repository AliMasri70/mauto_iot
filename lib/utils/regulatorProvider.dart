import 'package:flutter/material.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MqttConnectionMain.dart';
import 'package:mauto_iot/model/connectionModel.dart';
import 'package:mauto_iot/utils/ConnectionListProvider.dart';
import 'package:provider/provider.dart';

class RegulatorWidgetState extends ChangeNotifier {
  Map<String, double> _regulatorValues = {};

  Map<String, double> get regulatorValues => _regulatorValues;

  void addRegulator(String idRegulator, double initialValue) {
    _regulatorValues[idRegulator] = initialValue;
    notifyListeners();
  }

  void updateRegulatorValue(BuildContext context, ConnectionModel model,
      String topic, String idRegulator, double newValue) {
    if (_regulatorValues.containsKey(idRegulator)) {
      uploadtoPubTopic(model, topic, newValue.toString());
      _regulatorValues[idRegulator] = double.parse(newValue.toStringAsFixed(1));
      print("$idRegulator -- " + newValue.floorToDouble().toString());

      notifyListeners();
    }
  }

  void uploadtoPubTopic(ConnectionModel model, String topic, String value) {
    // MqttServerClient(url, id).disconnect();
    print("send to ");
    sendPubTopicData(model.willQoS, topic, value);
    // MqttServerClient(url, id).onUnsubscribed;

    notifyListeners();
  }

  double getRegulatorValue(String idRegulator) {
    return _regulatorValues[idRegulator] ?? 0.0;
  }

  void setRegulatorValue(String idRegulator, double value) {
    if (_regulatorValues.containsKey(idRegulator)) {
      _regulatorValues[idRegulator] = value;
      notifyListeners();
    }
  }
}
