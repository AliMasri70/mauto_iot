import 'package:flutter/material.dart';
import 'package:mauto_iot/model/VariableModel.dart';

class VariableListProvider extends ChangeNotifier {
  List<VariableModel> _variableList = [];

  List<VariableModel> get variableList => List.from(_variableList);

  initVariables() {
    _variableList.clear();
    for (int i = 0; i < 11; i++) {
      _variableList.add(
          VariableModel(variableID: i.toString(), vName: "V$i", type: "Local"));
    }

    notifyListeners();
  }

  void setListVariable(List<VariableModel> list) {
    _variableList =
        List.from(list); // Create a new list and update the reference
    notifyListeners();
  }

  void addConnection(VariableModel model) {
    _variableList = [
      ..._variableList,
      model
    ]; // Create a new list and update the reference
    notifyListeners();
  }

  String? getVNameByVariableID(String variableID) {
    if (variableID == 'Not Selected') {
      return variableID;
    } else {
      VariableModel variable = _variableList.firstWhere(
        (element) => element.variableID == variableID,
      );
      return variable.vName;
    }
  }

  void updateVariableTopicType(
      String topicName, String varID, String topicType, String type) {
    int index = int.parse(varID.toString());
    print('topicType0: $topicName ' + topicType);
    if (index >= 0 && index < _variableList.length) {
      _variableList = List.from(
          _variableList); // Create a new list to avoid modifying the original
      _variableList[index].type = type;
      if (topicType.split('-')[0].toString() == 'Sub') {
        _variableList[index].subTopicName = topicName;
      } else if (topicType.split('-')[0].toString() == 'Pub') {
        _variableList[index].pubTopicName = topicName;
      }
      _variableList[index].topicType = topicType.split('-')[0].toString();
      _variableList[index].topicTitle = topicName;

      notifyListeners();
    }
  }

  void setValueByTopicTitle(String topicTitle, String newValue) {
    _variableList = List.from(_variableList);

    for (int i = 0; i < _variableList.length; i++) {
      if (_variableList[i].subTopicName == topicTitle ||
          _variableList[i].pubTopicName == topicTitle) {
        _variableList[i].value = newValue;
      }
    }
    notifyListeners();
  }

  void updateConnection(VariableModel model) {
    int index = int.parse(model.variableID.toString());

    if (index >= 0 && index < _variableList.length) {
      _variableList = List.from(
          _variableList); // Create a new list to avoid modifying the original
      _variableList[index] = model;
      notifyListeners();
    }
  }
}
