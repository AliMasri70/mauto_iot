import 'package:flutter/material.dart';
import 'package:mauto_iot/model/topicModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicListProvider extends ChangeNotifier {
  List<TopicModel> _topicList = [];
  List<String> _topicvalues = [];
  List<TopicModel> get topicList => List.from(_topicList);
  List<String> get topicvalues => List.from(_topicvalues);

  initVariables() {
    _topicList.clear();
    notifyListeners();
  }

  void setListVariable(List<TopicModel> list) {
    _topicList = List.from(list); // Create a new list and update the reference
    notifyListeners();
  }

  Future<void> setTopicData(BuildContext context) async {
    _topicvalues.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0;
        i <
            // ignore: use_build_context_synchronously
            Provider.of<TopicListProvider>(context, listen: false)
                .topicList
                .length;
        i++) {
      _topicvalues.add(prefs.getString(
                  // ignore: use_build_context_synchronously
                  Provider.of<TopicListProvider>(context, listen: false)
                      .topicList[i]
                      .userTopic
                      .toString()) ==
              null
          ? ''
          : prefs
              .getString(Provider.of<TopicListProvider>(context, listen: false)
                  .topicList[i]
                  .userTopic
                  .toString())
              .toString());
    }
    notifyListeners();
  }

  void setVAriableMSG(String list) {
    print(list);
  }

  void addConnection(TopicModel model) {
    _topicList = [
      ..._topicList,
      model
    ]; // Create a new list and update the reference
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void updateConnection(TopicModel model) {
    int index = int.parse(model.id.toString());

    if (index >= 0 && index < _topicList.length) {
      _topicList = List.from(
          _topicList); // Create a new list to avoid modifying the original
      _topicList[index] = model;
      notifyListeners();
    }
  }

  String getType(String variableID) {
    TopicModel variable = _topicList.firstWhere(
      (element) => element.id == variableID,
    );
    return variable.type;
  }

  void updateTopicValue(String topic, var data) {
    int index = 0;

    while (index < _topicList.length) {
      print("message:: 2");
      _topicList = List.from(_topicList);
      // Create a new list to avoid modifying the original
      if (_topicList[index].userTopic == topic) {
        _topicList[index].data = data;
        print("message:: $data $topic");
      }
      index++;
    }
    notifyListeners();
  }

  void removeTopicById(String id) {
    _topicList.removeWhere((topic) => topic.id == id);
    notifyListeners();
  }
}
