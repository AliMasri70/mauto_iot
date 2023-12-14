import 'package:flutter/material.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MqttConnectionMain.dart';
import 'package:mauto_iot/model/connectionModel.dart';

class RotaryState extends ChangeNotifier {
  Map<String, double> _rotaryValues = {};

  Map<String, double> get rotaryValues => _rotaryValues;

  void addRotary(String _rotaryid, double initialValue) {
    _rotaryValues[_rotaryid] = initialValue;
    notifyListeners();
  }

  void updateRotaryValueoff(String _rotaryid, double newValue) {
    if (_rotaryValues.containsKey(_rotaryid)) {
      _rotaryValues[_rotaryid] = newValue;
      print("$_rotaryid -1- " + newValue.toString());
      notifyListeners();
    }
  }

  void updateRotaryValue(BuildContext context, ConnectionModel model,
      String topic, String _rotaryid, double newValue) {
    if (_rotaryValues.containsKey(_rotaryid)) {
      uploadtoPubTopic(model, topic, newValue.toString());
      _rotaryValues[_rotaryid] = newValue;
      print("$_rotaryid -- " + newValue.floorToDouble().toString());

      notifyListeners();
    }
  }

  double getRotaryValue(String _rotaryid) {
    return _rotaryValues[_rotaryid] ?? 0.0;
  }

  void uploadtoPubTopic(ConnectionModel model, String topic, String value) {
    // MqttServerClient(url, id).disconnect();
    print("send to ");
    sendPubTopicData(model.willQoS, topic, value);
    // MqttServerClient(url, id).onUnsubscribed;

    notifyListeners();
  }

  void setRotaryValue(String _rotaryid, double value) {
    if (_rotaryValues.containsKey(_rotaryid)) {
      _rotaryValues[_rotaryid] = value;
      notifyListeners();
    }
  }
}
