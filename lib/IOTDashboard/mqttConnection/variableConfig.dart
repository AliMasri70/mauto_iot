import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_text_fields/utils/extensions.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementCardSelectWidget.dart';

import 'package:mauto_iot/model/VariableModel.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

import 'package:mauto_iot/utils/variablesProvider.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../model/topicModel.dart';
import '../../utils/topicProvider.dart';

class VariableConfig extends StatefulWidget {
  const VariableConfig({super.key});

  @override
  State<VariableConfig> createState() => _VariableConfigState();
}

class _VariableConfigState extends State<VariableConfig> {
  List<TopicModel> topics = [], topics2 = [];
  late VariableModel model;
  TextEditingController nicknameController = TextEditingController();
  TextEditingController startingvalue = TextEditingController();
  TextEditingController uploadDataController = TextEditingController();
  String topictype = '', topictitile = '';
  String subTopic = '', pubTopic = '';
  bool isEmpty1 = false, isEmpty2 = false, isEmpty3 = false;
  @override
  void initState() {
    // TODO: implement initState
    getTopics();
    model = Get.arguments[0];
    nicknameController = TextEditingController(text: model.vName);
    print('model.type ${model.type}');
    selectedValue = model.type ?? type[0];
    selectedValue2 = model.subTopicValueType ?? vartype[0];
    startingvalue = TextEditingController(text: model.startingValue ?? '');
    subTopic = model.subTopicName ?? '';
    pubTopic = model.pubTopicName ?? '';
    uploadDataController =
        TextEditingController(text: model.pubTopicValueType ?? '');
    super.initState();
  }

  getTopics() {
    topics.clear();
    topics2.clear();
    setState(() {
      topics2.addAll(Provider.of<TopicListProvider>(context, listen: false)
          .topicList
          .where((element) => element.type.split('-')[0] == "Pub")
          .toList());

      topics.addAll(Provider.of<TopicListProvider>(context, listen: false)
          .topicList
          .where((element) => element.type.split('-')[0] == "Sub")
          .toList());
    });
  }

  updateVariable() {
    if (nicknameController.text.trim().isEmpty) {
      setState(() {
        isEmpty1 = true;
      });
    }
    print("updateTYpe $selectedValue");
    if (nicknameController.text.trim().isNotEmpty) {
      VariableModel model = VariableModel(
          variableID: Get.arguments[1].toString(),
          vName: nicknameController.text,
          startingValue: startingvalue.text,
          retentive: isChecked,
          type: selectedValue,
          subTopicName: subTopic,
          subTopicValueType: selectedValue2,
          pubTopicName: pubTopic,
          pubTopicValueType: uploadDataController.text);

      Provider.of<VariableListProvider>(context, listen: false)
          .updateConnection(model);

      setState(() {
        if (subTopic != '' || pubTopic != '') {
          if (pubTopic == '') {
            topictype = 'Sub';
            topictitile = subTopic;
          } else if (subTopic == '') {
            topictype = 'Pub';
            topictitile = pubTopic;
          }
        }
      });
      setState(() {
        Provider.of<VariableListProvider>(context, listen: false)
            .updateVariableTopicType(
                topictitile.toString().trim(),
                Get.arguments[1].toString().trim(),
                topictype.toString().trim(),selectedValue);
      });
      Provider.of<TopicListProvider>(context, listen: false).refresh();
      Get.back();
    }
  }

  bool isChecked = false;
  final List<String> type = [
    'Local',
    'Cloud/Device',
  ];
  final List<String> vartype = ['Number', 'Text', 'Json'];
  String selectedValue = '', selectedValue2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: defaultText(
              title: "Variable Settings",
              fontSize: 22,
              TextColor: textColor,
              TextFontFamily: FontWeight.bold),
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                    onPressed: () {
                      updateVariable();
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
                    Row(
                      children: [
                        defaultText(
                            title: "Connection or Device",
                            fontSize: 16,
                            TextColor: greyColor,
                            TextFontFamily: FontWeight.w600),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child:
                          DividerScreen(title: "MQTT: MQTT Broker", size: 0.4),
                    ),
                    const SizedBox(
                      height: 35,
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
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Divider(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        inputVariableTextField(
                          validate: false,
                          controller: startingvalue,
                          TextLabel: 'Starting Value',
                          icon: Icons.text_fields,
                          inputType: TextInputType.text,
                          width: 1,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              child: Opacity(
                                  opacity: 0.80,
                                  child: defaultText(
                                      title: 'Retentive',
                                      TextColor: textColor,
                                      fontSize: 19,
                                      TextFontFamily: FontWeight.w400)),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              height: 40.0,
                              width: 40,
                              child: Checkbox(
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 2.0,
                                      color: isChecked ? MainColor : greyColor),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
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
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Divider(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: defaultText(
                            TextColor: textColor,
                            title: "Type",
                            fontSize: 18,
                            TextFontFamily: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.06,
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
                            items: type
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
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                            onSaved: (value) {},
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
                    selectedValue.trim() == 'Cloud/Device'
                        ? Column(
                            children: [
                              DividerScreen(
                                  title: "Settings for value reading",
                                  size: 0.55),
                              const SizedBox(
                                height: 35,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color.fromARGB(255, 237, 255, 239)),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: defaultText(
                                              title: "Sub Topic",
                                              fontSize: 16,
                                              TextColor: textColor,
                                              TextFontFamily: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: GestureDetector(
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
                                                                  'SUB Topics',
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
                                                                          itemCount: topics
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            return GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    subTopic = topics[index].nickName.toString();
                                                                                  });
                                                                                  Get.back();
                                                                                  print(topics[index].id.toString());
                                                                                },
                                                                                child: GeneralCardSelectWidget(title: topics[index].nickName, sub: topics[index].userTopic));
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
                                                child: Center(
                                                  child: defaultText(
                                                      title: subTopic.isNotEmpty
                                                          ? subTopic
                                                          : "Not Selected",
                                                      fontSize: 16,
                                                      TextColor: Colors.red,
                                                      TextFontFamily:
                                                          FontWeight.w500),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: MainColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                              )),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  subTopic = '';
                                                });
                                              },
                                              icon: Icon(
                                                  Icons.cleaning_services)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: defaultText(
                                            TextColor: textColor,
                                            title: "Type",
                                            fontSize: 18,
                                            TextFontFamily: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          child:
                                              DropdownButtonFormField2<String>(
                                            value: selectedValue2,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              // Add Horizontal padding using menuItemStyleData.padding so it matches
                                              // the menu padding when button's width is not specified.
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              // Add more decoration..
                                            ),
                                            hint: const Text(
                                              'Select Your Type',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            items: vartype
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
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
                                              setState(() {
                                                selectedValue2 =
                                                    value.toString();
                                              });
                                            },
                                            onSaved: (value) {},
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),

/////////////////////////////////

                              DividerScreen(
                                  title: "Settings for value uploading",
                                  size: 0.55),
                              const SizedBox(
                                height: 35,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color.fromARGB(255, 237, 255, 239)),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: defaultText(
                                              title: "Pub Topic",
                                              fontSize: 16,
                                              TextColor: textColor,
                                              TextFontFamily: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: GestureDetector(
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
                                                                  'PUB Topics',
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
                                                                          itemCount: topics2
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            return GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    pubTopic = topics2[index].nickName.toString();
                                                                                  });
                                                                                  Get.back();
                                                                                  print(topics2[index].id.toString());
                                                                                },
                                                                                child: GeneralCardSelectWidget(title: topics2[index].nickName, sub: topics2[index].userTopic));
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
                                                child: Center(
                                                  child: defaultText(
                                                      title: pubTopic.isNotEmpty
                                                          ? pubTopic
                                                          : "Not Selected",
                                                      fontSize: 16,
                                                      TextColor: Colors.red,
                                                      TextFontFamily:
                                                          FontWeight.w500),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: MainColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                              )),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  pubTopic = '';
                                                });
                                              },
                                              icon: Icon(
                                                  Icons.cleaning_services)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: defaultText(
                                            TextColor: textColor,
                                            title: "Data for uploading",
                                            fontSize: 18,
                                            TextFontFamily: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          child: inputVariableTextField(
                                            validate: false,
                                            controller: uploadDataController,
                                            TextLabel: 'Upload Data',
                                            icon: Icons.data_array,
                                            inputType: TextInputType.text,
                                            width: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          )
                        : Container()
                  ],
                )),
              ),
            ),
          ),
        ));
  }
}
