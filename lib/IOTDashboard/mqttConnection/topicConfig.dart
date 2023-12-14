import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementCardSelectWidget.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MQTTScreenConnection.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/topicList.dart';

import 'package:mauto_iot/model/VariableModel.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/utils/variablesProvider.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../model/topicModel.dart';
import '../../utils/topicProvider.dart';

class TopicConfig extends StatefulWidget {
  const TopicConfig({super.key});

  @override
  State<TopicConfig> createState() => _TopicConfigState();
}

class _TopicConfigState extends State<TopicConfig> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController userTopicController = TextEditingController();
  List<VariableModel> variables = [];
  late TopicModel model;
  bool isEmpty1 = false, isEmpty2 = false;
  final List<String> topicType = [
    'Sub-topic',
    'Pub-topic',
  ];
  final List<MqttQos> willqos = [
    MqttQos.atMostOnce,
    MqttQos.atLeastOnce,
    MqttQos.exactlyOnce
  ];
  final List<String> qos = [
    '0 - at most once',
    '1 - at least once',
    '2 - exactly once'
  ];
  late String selectedValue, selectedValue2, selectedValue3, variableNum;
  bool isChecked = false, isChecked3 = false;
  @override
  void initState() {
    // TODO: implement initState
    getTopics();

    if (Get.arguments != "new") {
      print(Get.arguments);
      model = Get.arguments;
      nicknameController = TextEditingController(text: model.nickName);
      userTopicController = TextEditingController(text: model.userTopic);
      selectedValue = model.type;
      selectedValue3 = qos[willqos.indexOf(model.willQoS)];
      isChecked = model.disableSub ?? false;
      isChecked3 = model.retianed ?? false;
      variableNum = model.variable ?? 'Not Selected';
    } else {
      print(Get.arguments);
      selectedValue = topicType[0];
      selectedValue3 = qos[0];
      variableNum = 'Not Selected';
    }
    super.initState();
  }

  getTopics() {
    variables.clear();

    setState(() {
      variables.addAll(Provider.of<VariableListProvider>(context, listen: false)
          .variableList
          .toList());
    });
  }

  topicSave(int id) {
    if (Get.arguments == "new") {
      if (nicknameController.text.trim().isEmpty) {
        setState(() {
          isEmpty1 = true;
        });
      }
      if (userTopicController.text.trim().isEmpty) {
        setState(() {
          isEmpty2 = true;
        });
      }
      if (nicknameController.text.trim().isNotEmpty &&
          userTopicController.text.trim().isNotEmpty) {
        TopicModel model = TopicModel(
            id: id.toString(),
            nickName: nicknameController.text,
            userTopic: userTopicController.text,
            type: selectedValue.toString(),
            willQoS: willqos[qos.indexOf(selectedValue3)],
            disableSub: isChecked,
            retianed: isChecked3,
            variable: variableNum);

        Provider.of<TopicListProvider>(context, listen: false)
            .addConnection(model);

        if (variableNum != '') {
          setState(() {
            Provider.of<VariableListProvider>(context, listen: false)
                .updateVariableTopicType(userTopicController.text, variableNum,
                    selectedValue.toString(), 'Cloud/Device');
          });
        }
        Provider.of<TopicListProvider>(context, listen: false)
            .setTopicData(context);
        Get.back();
      }
    } else {
      if (nicknameController.text.trim().isEmpty) {
        setState(() {
          isEmpty1 = true;
        });
      }
      if (userTopicController.text.trim().isEmpty) {
        setState(() {
          isEmpty2 = true;
        });
      }
      if (nicknameController.text.trim().isNotEmpty &&
          userTopicController.text.trim().isNotEmpty) {
        TopicModel model1 = TopicModel(
            id: model.id,
            nickName: nicknameController.text,
            userTopic: userTopicController.text,
            type: selectedValue.toString(),
            willQoS: willqos[qos.indexOf(selectedValue3)],
            disableSub: isChecked,
            retianed: isChecked3,
            variable: variableNum);

        Provider.of<TopicListProvider>(context, listen: false)
            .updateConnection(model1);

        if (variableNum != '') {
          setState(() {
            Provider.of<VariableListProvider>(context, listen: false)
                .updateVariableTopicType(nicknameController.text, variableNum,
                    selectedValue.toString(), 'Cloud/Device');
          });
        }
        Provider.of<TopicListProvider>(context, listen: false)
            .setTopicData(context);
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defaultText(
          title: "Topic Sttings",
          TextColor: textColor,
          fontSize: 22,
          TextFontFamily: FontWeight.bold,
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                  onPressed: () {
                    topicSave(
                        Provider.of<TopicListProvider>(context, listen: false)
                            .topicList
                            .length);
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 28,
                    color: textColor,
                  )))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    inputVariableTextField(
                      validate: isEmpty1,
                      controller: nicknameController,
                      TextLabel: 'Nickname',
                      icon: Icons.text_fields,
                      inputType: TextInputType.text,
                      width: 1,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    inputVariableTextField(
                      validate: isEmpty2,
                      controller: userTopicController,
                      TextLabel: 'User Topic',
                      icon: Icons.topic,
                      inputType: TextInputType.text,
                      width: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Divider(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: defaultText(
                            TextColor: textColor,
                            title: "Type",
                            fontSize: 14,
                            TextFontFamily: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: DropdownButtonFormField2<String>(
                            value: selectedValue,
                            isExpanded: true,
                            decoration: InputDecoration(
                              // Add Horizontal padding using menuItemStyleData.padding so it matches
                              // the menu padding when button's width is not specified.
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // Add more decoration..
                            ),
                            hint: const Text(
                              'Select Your Type',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: topicType
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select Type.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              print(value);
                              //Do something when selected item is changed.
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                            onSaved: (value) {
                              // setState(() {
                              //   selectedValue = value.toString();
                              // });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: defaultText(
                            TextColor: textColor,
                            title: "QoS",
                            fontSize: 14,
                            TextFontFamily: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: DropdownButtonFormField2<String>(
                            value: selectedValue3,
                            isExpanded: true,
                            decoration: InputDecoration(
                              // Add Horizontal padding using menuItemStyleData.padding so it matches
                              // the menu padding when button's width is not specified.
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // Add more decoration..
                            ),
                            hint: const Text(
                              'Select Your Type',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: qos
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select Type.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //Do something when selected item is changed.
                            },
                            onSaved: (value) {
                              selectedValue3 = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Divider(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    selectedValue == 'Sub-topic'
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 204, 204, 204),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 30.0,
                                          width: 30,
                                          child: Checkbox(
                                            side: MaterialStateBorderSide
                                                .resolveWith(
                                              (states) => BorderSide(
                                                  width: 1.0,
                                                  color: isChecked
                                                      ? MainColor
                                                      : Colors.white),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            activeColor: MainColor,
                                            value: isChecked,
                                            onChanged: (newValue) {
                                              setState(() {
                                                isChecked = newValue ?? false;
                                              });
                                            },
                                            //  <-- leading Checkbox
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isChecked = !isChecked;
                                            });
                                          },
                                          child: Opacity(
                                              opacity: 0.80,
                                              child: defaultText(
                                                  title: 'Disable Subscription',
                                                  TextColor: textColor,
                                                  fontSize: 16,
                                                  TextFontFamily:
                                                      FontWeight.w500)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  defaultDescText(
                                      title:
                                          'Disable the subscription in case the topic is subscribed by another topic that uses wildcards for multiple topics subscribing',
                                      fontSize: 12,
                                      TextColor: textColor,
                                      TextFontFamily: FontWeight.w400),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Divider(),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  defaultText(
                                      title:
                                          "The payload of this topic will be stored on the Variable below",
                                      fontSize: 16,
                                      TextColor: textColor,
                                      TextFontFamily: FontWeight.bold),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      defaultText(
                                          title: "Variable",
                                          fontSize: 14,
                                          TextColor: textColor,
                                          TextFontFamily: FontWeight.w400),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                WoltModalSheet.show<void>(
                                                  context: context,
                                                  pageListBuilder:
                                                      (modalSheetContext) {
                                                    final textTheme =
                                                        Theme.of(context)
                                                            .textTheme;
                                                    return [
                                                      WoltModalSheetPage
                                                          .withSingleChild(
                                                              hasSabGradient:
                                                                  false,
                                                              topBarTitle: Text(
                                                                  'Select Variable',
                                                                  style: textTheme
                                                                      .titleMedium),
                                                              isTopBarLayerAlwaysVisible:
                                                                  true,
                                                              trailingNavBarWidget:
                                                                  IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            16),
                                                                icon: const Icon(
                                                                    Icons
                                                                        .close),
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                              ),
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            400),
                                                                child: SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.7,
                                                                  child: ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection: Axis
                                                                              .vertical,
                                                                          itemCount: variables
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            return GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    variableNum = variables[index].variableID.toString();
                                                                                  });
                                                                                  Get.back();
                                                                                },
                                                                                child: GeneralCardSelectWidget(title: variables[index].vName.toString(), sub: variables[index].type.toString()));
                                                                          }),
                                                                ),
                                                              )),
                                                    ];
                                                  },
                                                  modalTypeBuilder: (context) {
                                                    final size =
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width;
                                                    if (size < 768) {
                                                      return WoltModalType
                                                          .bottomSheet;
                                                    } else {
                                                      return WoltModalType
                                                          .dialog;
                                                    }
                                                  },
                                                  onModalDismissedWithBarrierTap:
                                                      () {
                                                    debugPrint(
                                                        'Closed modal sheet with barrier tap');
                                                    Navigator.of(context).pop();
                                                    // pageIndexNotifier.value = 0;
                                                  },
                                                  maxDialogWidth: 560,
                                                  minDialogWidth: 400,
                                                  minPageHeight: 0.0,
                                                  maxPageHeight: 0.9,
                                                );
                                              },
                                              child: Container(
                                                width: 160,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: MainColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Center(
                                                  child: defaultText(
                                                      title: variableNum !=
                                                              'Not Selected'
                                                          ? Provider.of<
                                                                      VariableListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getVNameByVariableID(
                                                                  variableNum)
                                                              .toString()
                                                          : "Not Selected",
                                                      fontSize: 16,
                                                      TextColor: Colors.red,
                                                      TextFontFamily:
                                                          FontWeight.w500),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      defaultText(
                                          title: "Attention:",
                                          fontSize: 14,
                                          TextColor: Colors.red,
                                          TextFontFamily: FontWeight.w400),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      defaultDescText(
                                          title:
                                              "In case this topic uses MQTT \nwildcards for multiple topics \nsubscribing, you don't have to\nselect a variable",
                                          fontSize: 14,
                                          TextColor: textColor,
                                          TextFontFamily: FontWeight.w400)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40.0,
                                      width: 40,
                                      child: Checkbox(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => BorderSide(
                                              width: 1.0,
                                              color: isChecked3
                                                  ? MainColor
                                                  : greyColor),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        activeColor: MainColor,
                                        value: isChecked3,
                                        onChanged: (newValue) {
                                          setState(() {
                                            isChecked3 = newValue ?? false;
                                          });
                                        },
                                        //  <-- leading Checkbox
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isChecked3 = !isChecked3;
                                        });
                                      },
                                      child: Opacity(
                                          opacity: 0.80,
                                          child: defaultText(
                                              title: 'Retained',
                                              TextColor: textColor,
                                              fontSize: 18,
                                              TextFontFamily: FontWeight.w400)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Divider(),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: defaultText(
                                      title:
                                          "The value of the variable below will be uploaded to this topic every time it is changed",
                                      fontSize: 14,
                                      TextColor: textColor,
                                      TextFontFamily: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    defaultText(
                                        title: "Variable",
                                        fontSize: 14,
                                        TextColor: textColor,
                                        TextFontFamily: FontWeight.w400),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              WoltModalSheet.show<void>(
                                                context: context,
                                                pageListBuilder:
                                                    (modalSheetContext) {
                                                  final textTheme =
                                                      Theme.of(context)
                                                          .textTheme;
                                                  return [
                                                    WoltModalSheetPage
                                                        .withSingleChild(
                                                            hasSabGradient:
                                                                false,
                                                            topBarTitle: Text(
                                                                'Select Variable',
                                                                style: textTheme
                                                                    .titleMedium),
                                                            isTopBarLayerAlwaysVisible:
                                                                true,
                                                            trailingNavBarWidget:
                                                                IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(16),
                                                              icon: const Icon(
                                                                  Icons.close),
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                            ),
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          400),
                                                              child: SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.7,
                                                                child: ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .vertical,
                                                                        itemCount:
                                                                            31,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  variableNum = variables[index].variableID.toString();
                                                                                });
                                                                                Get.back();
                                                                              },
                                                                              child: GeneralCardSelectWidget(title: variables[index].vName.toString(), sub: variables[index].type.toString()));
                                                                        }),
                                                              ),
                                                            )),
                                                  ];
                                                },
                                                modalTypeBuilder: (context) {
                                                  final size =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;
                                                  if (size < 768) {
                                                    return WoltModalType
                                                        .bottomSheet;
                                                  } else {
                                                    return WoltModalType.dialog;
                                                  }
                                                },
                                                onModalDismissedWithBarrierTap:
                                                    () {
                                                  debugPrint(
                                                      'Closed modal sheet with barrier tap');
                                                  Navigator.of(context).pop();
                                                  // pageIndexNotifier.value = 0;
                                                },
                                                maxDialogWidth: 560,
                                                minDialogWidth: 400,
                                                minPageHeight: 0.0,
                                                maxPageHeight: 0.9,
                                              );
                                            },
                                            child: Container(
                                              width: 160,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: MainColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Center(
                                                child: defaultText(
                                                    title: variableNum !=
                                                            'Not Selected'
                                                        ? Provider.of<
                                                                    VariableListProvider>(
                                                                context,
                                                                listen: false)
                                                            .getVNameByVariableID(
                                                                variableNum)
                                                            .toString()
                                                        : "Not Selected",
                                                    fontSize: 16,
                                                    TextColor: Colors.red,
                                                    TextFontFamily:
                                                        FontWeight.w500),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 55,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
