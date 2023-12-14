import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MQTTScreenConnection.dart';

import 'package:mauto_iot/IOTDashboard/mqttConnection/topicList.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/variableScreen.dart';
import 'package:mauto_iot/model/VariableModel.dart';
import 'package:mauto_iot/model/topicModel.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:polar_tab_bar/models/polar_tab_item.dart';
import 'package:polar_tab_bar/polar_tab_bar.dart';
import 'package:polar_tab_bar/widgets/polar_tab_page.dart';
import 'package:provider/provider.dart';

import '../../model/connectionModel.dart';
import '../../utils/topicProvider.dart';
import '../../utils/variablesProvider.dart';

class MQTTGeneralSetting extends StatefulWidget {
  @override
  State<MQTTGeneralSetting> createState() => _MQTTGeneralSettingState();
}

class _MQTTGeneralSettingState extends State<MQTTGeneralSetting> {
  late final GlobalKey<MQTTScreenConnectionState> keyFunc;
  PageController pageController = PageController();
  List<VariableModel> elements = [];
  ConnectionModel? model;
  bool loading = false;
  List<PolarTabItem> tabs = [];
  List<String> topicstoSub = [];
  @override
  void initState() {
    keyFunc = GlobalKey();

    tabs = [
      PolarTabItem(
        index: 0,
        title: "Setting",
        page: PolarTabPage(
          child: MQTTScreenConnection(key: keyFunc),
        ),
      ),
      PolarTabItem(
        index: 1,
        title: "Topics",
        page: const PolarTabPage(child: TopicList()),
      ),
      PolarTabItem(
        index: 2,
        title: "Variables",
        page: const PolarTabPage(child: VariablesScreen()),
      ),
    ];
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

      setState(() {});
    });
    pageController.addListener(_handleTabChange);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    print("oncahnge page");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () async {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: defaultText(
            title: "Connection Setting",
            fontSize: 19,
            TextColor: textColor,
            TextFontFamily: FontWeight.bold),
        actions: [
          loading == false
              ? Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });

                        List<VariableModel> list =
                            Provider.of<VariableListProvider>(context,
                                    listen: false)
                                .variableList;

                        List<TopicModel> list2 = Provider.of<TopicListProvider>(
                                context,
                                listen: false)
                            .topicList;

                        // if (list2.isNotEmpty) {
                        //   for (int i = 0; i < list2.length; i++) {
                        //     setState(() {
                        //       topicstoSub.add(list2[i].userTopic);
                        //     });
                        //   }
                        // }

                        if (keyFunc.currentState != null &&
                            keyFunc.currentState!.mounted) {
                          keyFunc.currentState!
                              .submitConnectionVariables(
                                   list, list2)
                              .whenComplete(() => setState(() {
                                    loading = false;
                                  }));
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                        size: 28,
                        color: textColor,
                      )))
              : Container(
                  margin: const EdgeInsets.only(right: 14),
                  child: const CupertinoActivityIndicator())
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: PolarTabBar(
            pageController: pageController,
            curve: Curves.fastOutSlowIn,
            activeTitleStyle: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            activeBackground: MainColor,
            type: PolarTabType.pill, // Default Type
            tabs: tabs),
      ),
    );
  }
}
