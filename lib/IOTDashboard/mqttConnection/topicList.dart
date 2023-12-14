import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/topicConfig.dart';

import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/utils/topicProvider.dart';

import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:provider/provider.dart';

import 'package:mauto_iot/model/topicModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/connectionModel.dart';
import '../../utils/variablesProvider.dart';
import 'package:slideable/Slideable.dart';

class TopicList extends StatefulWidget {
  const TopicList({super.key});

  @override
  State<TopicList> createState() => TopicListState();
}

class TopicListState extends State<TopicList> {
  List<TopicModel> connectionLists = [];
  bool isLoading = false;
  ConnectionModel? model;

  @override
  void initState() {
    if (Get.arguments != null) {
      model = Get.arguments;
      connectionLists = model!.topicList;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (connectionLists.length == 0) {
        print("nameel" + connectionLists.length.toString());
        Provider.of<TopicListProvider>(context, listen: false).initVariables();
      } else {
        print("nameel" + connectionLists.length.toString());
        Provider.of<TopicListProvider>(context, listen: false)
            .setListVariable(connectionLists.toList());
      }

      if (Provider.of<TopicListProvider>(context, listen: false)
          .topicList
          .isNotEmpty) {
        print("yyyy " +
            Provider.of<TopicListProvider>(context, listen: false)
                .topicList
                .length
                .toString());
        Provider.of<TopicListProvider>(context, listen: false)
            .setTopicData(context);
      }

      setState(() {});
    });

    super.initState();
  }

  removeVariable(BuildContext context, int idd) {
    String topicIdToRemove =
        Provider.of<TopicListProvider>(context, listen: false)
            .topicList[idd]
            .id
            .toString();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<TopicListProvider>(context, listen: false)
          .removeTopicById(topicIdToRemove);
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => TopicConfig(), arguments: "new");
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          backgroundColor: MainColor,
          elevation: 0,
          shape: const CircleBorder(eccentricity: 0)),
      body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: Provider.of<TopicListProvider>(context).topicList.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: ListView.builder(
                    itemCount:
                        Provider.of<TopicListProvider>(context, listen: false)
                            .topicList
                            .length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          print(Provider.of<VariableListProvider>(context,
                                  listen: false)
                              .getVNameByVariableID(
                                  Provider.of<TopicListProvider>(context,
                                          listen: false)
                                      .topicList[i]
                                      .variable
                                      .toString())
                              .toString());

                          Get.to(() => TopicConfig(),
                              arguments: Provider.of<TopicListProvider>(context,
                                      listen: false)
                                  .topicList[i]);
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Slideable(
                              items: <ActionItems>[
                                ActionItems(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                  onPress: () {
                                    removeVariable(context, i);
                                  },
                                  backgroudColor: Colors.transparent,
                                ),
                              ],
                              child: Container(
                                margin: EdgeInsets.only(right: 4),
                                padding: const EdgeInsets.all(18),
                                decoration: ShapeDecoration(
                                  color:
                                      const Color.fromARGB(255, 233, 232, 232),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0A1C232F),
                                      blurRadius: 16,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          defaultText(
                                              title: Provider.of<
                                                          TopicListProvider>(
                                                      context)
                                                  .topicList[i]
                                                  .nickName,
                                              fontSize: 18,
                                              TextColor: textColor,
                                              TextFontFamily: FontWeight.bold),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          ////////////////

                                          Row(
                                            children: [
                                              defaultText(
                                                TextColor: textColor,
                                                title: "Topic:",
                                                fontSize: 15,
                                                TextFontFamily: FontWeight.w400,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              defaultDescText(
                                                TextColor: textColor,
                                                title: Provider.of<
                                                            TopicListProvider>(
                                                        context)
                                                    .topicList[i]
                                                    .userTopic,
                                                fontSize: 15,
                                                TextFontFamily: FontWeight.bold,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              defaultText(
                                                TextColor: textColor,
                                                title: "Type:",
                                                fontSize: 15,
                                                TextFontFamily: FontWeight.w400,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              defaultDescText(
                                                TextColor: textColor,
                                                title: Provider.of<
                                                            TopicListProvider>(
                                                        context)
                                                    .topicList[i]
                                                    .type
                                                    .split('-')[0]
                                                    .trim(),
                                                fontSize: 15,
                                                TextFontFamily: FontWeight.bold,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              defaultText(
                                                TextColor: textColor,
                                                title: "Variable:",
                                                fontSize: 15,
                                                TextFontFamily: FontWeight.w400,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              defaultDescText(
                                                TextColor:
                                                    Provider.of<TopicListProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .topicList[i]
                                                                .variable
                                                                .toString() ==
                                                            "Not Selected"
                                                        ? Colors.red
                                                        : MainColor,
                                                title: Provider.of<
                                                            VariableListProvider>(
                                                        context,
                                                        listen: false)
                                                    .getVNameByVariableID(Provider
                                                            .of<TopicListProvider>(
                                                                context,
                                                                listen: false)
                                                        .topicList[i]
                                                        .variable
                                                        .toString())
                                                    .toString(),
                                                fontSize: 15,
                                                TextFontFamily: FontWeight.bold,
                                              )
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              defaultText(
                                                TextColor: textColor,
                                                title: "Value:",
                                                fontSize: 15,
                                                TextFontFamily: FontWeight.w400,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              defaultText(
                                                TextColor: textColor,
                                                title: Provider.of<
                                                                TopicListProvider>(
                                                            context,
                                                            listen: false)
                                                        .topicvalues
                                                        .isEmpty
                                                    ? ''
                                                    : Provider.of<
                                                                TopicListProvider>(
                                                            context,
                                                            listen: false)
                                                        .topicvalues[i],
                                                fontSize: 15,
                                                TextFontFamily: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          ////////////
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 17),
                                        child: const Icon(Icons.edit,
                                            color: MainColor))
                                  ],
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                )
              : Center(
                  child: defaultText(
                      title: "Topic List is Empty",
                      fontSize: 22,
                      TextColor: textColor,
                      TextFontFamily: FontWeight.bold),
                )),
    );
  }
}
