import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_text_fields/utils/extensions.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementCardSelectWidget.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/variableConfig.dart';
import 'package:mauto_iot/model/connectionModel.dart';
import 'package:mauto_iot/utils/topicProvider.dart';
import 'package:mauto_iot/utils/variablesProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/VariableModel.dart';

class VariablesScreen extends StatefulWidget {
  const VariablesScreen({super.key});

  @override
  State<VariablesScreen> createState() => _VariablesScreenState();
}

class _VariablesScreenState extends State<VariablesScreen> {
  List<VariableModel> elements = [];
  ConnectionModel? model;
  @override
  void initState() {
    if (Get.arguments != null) {
      model = Get.arguments;
      elements = model!.variableList;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (elements.length == 0) {
        print("nameel" + elements.length.toString());
        Provider.of<VariableListProvider>(context, listen: false)
            .initVariables();
      } else {
        print("nameel" + elements.length.toString());
        Provider.of<VariableListProvider>(context, listen: false)
            .setListVariable(elements.toList());
      }
      if (Provider.of<TopicListProvider>(context, listen: false)
          .topicList
          .isNotEmpty) {
        setVariables();
      }
      setState(() {});
    });

    super.initState();
  }

  setVariables() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0;
        i <
            // ignore: use_build_context_synchronously
            Provider.of<TopicListProvider>(context, listen: false)
                .topicList
                .length;
        i++) {
      setState(() {
        Provider.of<VariableListProvider>(context, listen: false)
            .setValueByTopicTitle(
                Provider.of<TopicListProvider>(context, listen: false)
                    .topicList[i]
                    .userTopic
                    .toString(),
                prefs
                    .getString(
                        Provider.of<TopicListProvider>(context, listen: false)
                            .topicList[i]
                            .userTopic
                            .toString())
                    .toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount:
                Provider.of<VariableListProvider>(context).variableList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {
                      print(index.toString());
                      Get.to(() => VariableConfig(), arguments: [
                        Provider.of<VariableListProvider>(context,
                                listen: false)
                            .variableList[index],
                        index
                      ]);
                    },
                    child: VariableCardSelectWidget1(
                        title: Provider.of<VariableListProvider>(
                          context,
                        ).variableList[index].vName.toString(),
                        sub: Provider.of<VariableListProvider>(
                          context,
                        ).variableList[index].type.toString(),
                        topicTitle: Provider.of<VariableListProvider>(
                          context,
                        )
                                .variableList[index]
                                .topicTitle
                                .toString()
                                .isNotNullOrEmpty()
                            ? Provider.of<VariableListProvider>(
                                context,
                              ).variableList[index].topicTitle.toString()
                            : '',
                        topicType: Provider.of<VariableListProvider>(
                          context,
                        )
                                .variableList[index]
                                .topicType
                                .toString()
                                .isNotNullOrEmpty()
                            ? Provider.of<VariableListProvider>(
                                context,
                              ).variableList[index].topicType.toString()
                            : '',
                        value: Provider.of<VariableListProvider>(
                          context,
                        )
                                .variableList[index]
                                .value
                                .toString()
                                .isNotNullOrEmpty()
                            ? Provider.of<VariableListProvider>(
                                context,
                              ).variableList[index].value.toString()
                            : ''),
                  ));
            }),
      ),
    );
  }
}
