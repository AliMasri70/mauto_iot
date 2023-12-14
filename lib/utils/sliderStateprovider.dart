import 'package:flutter/material.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MqttConnectionMain.dart';
import 'package:mauto_iot/model/connectionModel.dart';

class SliderState extends ChangeNotifier {
  Map<String, double> _sliderValues = {};

  Map<String, double> get sliderValues => _sliderValues;

  void addSlider(String idSlider, double initialValue) {
    _sliderValues[idSlider] = initialValue;
    notifyListeners();
  }

  void updateSliderValueoff(String idSlider, double newValue) {
    if (_sliderValues.containsKey(idSlider)) {
      _sliderValues[idSlider] = newValue;
      print("$idSlider -1- " + newValue.toString());
      notifyListeners();
    }
  }

  void updateSliderValue(BuildContext context, ConnectionModel model,
      String topic, String idSlider, double newValue) {
    if (_sliderValues.containsKey(idSlider)) {
      uploadtoPubTopic(model, topic, newValue.toString());
      _sliderValues[idSlider] = newValue;
      print("$idSlider -- " + newValue.floorToDouble().toString());

      notifyListeners();
    }
  }

  double getSliderValue(String idSlider) {
    return _sliderValues[idSlider] ?? 0.0;
  }

  void uploadtoPubTopic(ConnectionModel model, String topic, String value) {
    // MqttServerClient(url, id).disconnect();
    print("send to ");
    sendPubTopicData(model.willQoS, topic, value);
    // MqttServerClient(url, id).onUnsubscribed;

    notifyListeners();
  }

  void setSliderValue(String idSlider, double value) {
    if (_sliderValues.containsKey(idSlider)) {
      _sliderValues[idSlider] = value;
      notifyListeners();
    }
  }
}
