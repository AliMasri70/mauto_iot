import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementCardSelectWidget.dart';
import 'package:mauto_iot/IOTDashboard/elements/digitalDisplay.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/variableScreen.dart';
import 'package:mauto_iot/model/connectionModel.dart';
import 'package:mauto_iot/model/ledModel.dart';
import 'package:mauto_iot/utils/ConnectionListProvider.dart';
import 'package:mauto_iot/utils/IOTListProvider.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:mauto_iot/widgets/modalSheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DigitalDisplayConfigs extends StatefulWidget {
  const DigitalDisplayConfigs({super.key});

  @override
  State<DigitalDisplayConfigs> createState() => _DigitalDisplayConfigsState();
}

class _DigitalDisplayConfigsState extends State<DigitalDisplayConfigs> {
// final double _buttonHeight = 56.0;

  List<Map<String, dynamic>> connectionVariablesList3 = [
    {"id": '0', "value": "Emulator"},
  ];
  late String selectedValue;
  late String selectedValue2;
  ConnectionModel? modelConn;
  String selectedVariable = 'Not Selected';
  String variable_ID = '';
  String selectedTopic = '';
  TextEditingController widgetName = TextEditingController(text: 'Display');
  TextEditingController leftPos = TextEditingController(text: '0');
  TextEditingController topPos = TextEditingController(text: '0');
  TextEditingController widgetWidth = TextEditingController(text: '100');
  TextEditingController widgetHeight = TextEditingController(text: '50');
  TextEditingController offStateVal = TextEditingController(text: '');
  TextEditingController onStateVal = TextEditingController(text: '1');
  @override
  void initState() {
    selectedValue2 = getElement(connectionVariablesList3, '0');

    getConnectionList();
    // TODO: implement initState
    super.initState();
  }

  void addElement(
      List<Map<String, dynamic>> list, String id, String stringValue) {
    list.add({"id": id, "value": stringValue});
  }

  String getElement(List<Map<String, dynamic>> list, String id) {
    Map<String, dynamic>? element = list.firstWhere((e) => e["id"] == id);

    print("Element with id $id: ${element['value']}");
    return element['value'];
  }

  String getElementId(List<Map<String, dynamic>> list, String nickname) {
    Map<String, dynamic>? element =
        list.firstWhere((e) => e["value"] == nickname);

    print("Element with id $nickname: ${element['id']}");
    return element['id'].toString().trim();
  }

  getConnectionList() {
    int connLen = Provider.of<ConnectionListProvider>(context, listen: false)
        .connectionsList
        .length;
    if (connLen > 0) {
      for (int i = 0; i < connLen; i++) {
        setState(() {
          addElement(
              connectionVariablesList3,
              Provider.of<ConnectionListProvider>(context, listen: false)
                  .connectionsList[i]
                  .connectionId
                  .toString(),
              Provider.of<ConnectionListProvider>(context, listen: false)
                  .connectionsList[i]
                  .nickName
                  .toString());
        });
      }
      // Now, 'connectionVariablesList' contains all the connectionIds
      // print(connectionVariablesList2);
    }
  }

  setLedWidget() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String valueData = prefs.getString(selectedTopic) ?? '';
    LedModel model = LedModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nickName: widgetName.text,
      leftPos: leftPos.text,
      topPos: topPos.text,
      width: widgetWidth.text,
      height: widgetHeight.text,
      variable: selectedVariable,
      variable_ID: variable_ID,
      topicName: selectedTopic,
      value: modelConn,
      displayData: valueData,
    );

    Provider.of<WidgetModel>(context, listen: false).addDisplayWidget(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: defaultText(
            title: "Digital Display",
            fontSize: 22,
            TextColor: textColor,
            TextFontFamily: FontWeight.w600),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              setLedWidget();
              Get.back();
              Get.back();
            },
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 9,
                ),
                inputVariableTextField(
                  controller: widgetName,
                  validate: false,
                  TextLabel: 'Widget Name',
                  icon: Icons.text_fields,
                  inputType: TextInputType.text,
                  width: 1,
                ),
                const SizedBox(
                  height: 9,
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      inputVariableTextField(
                        controller: leftPos,
                        validate: false,
                        TextLabel: 'Left',
                        icon: Icons.margin,
                        inputType: TextInputType.number,
                        width: 0.4,
                      ),
                      inputVariableTextField(
                        controller: topPos,
                        validate: false,
                        TextLabel: 'Top',
                        icon: Icons.margin,
                        inputType: TextInputType.number,
                        width: 0.4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      inputVariableTextField(
                        controller: widgetWidth,
                        validate: false,
                        TextLabel: 'Width',
                        icon: Icons.width_normal,
                        inputType: TextInputType.number,
                        width: 0.4,
                      ),
                      inputVariableTextField(
                        controller: widgetHeight,
                        validate: false,
                        TextLabel: 'Heigth',
                        icon: Icons.height,
                        inputType: TextInputType.number,
                        width: 0.4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                const DividerScreen(
                  title: 'Variable',
                  size: 0.3,
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Variable",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 25),
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                            // height: 70,
                                            child: DropdownButtonFormField2<
                                                String>(
                                              value: selectedValue2,
                                              isExpanded: true,
                                              decoration: InputDecoration(
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
                                              items: connectionVariablesList3
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item['value'],
                                                        child: Text(
                                                          item['value'],
                                                          style:
                                                              const TextStyle(
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
                                                setState(() {
                                                  selectedValue2 =
                                                      value.toString();
                                                });
                                              },
                                              buttonStyleData:
                                                  const ButtonStyleData(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
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
                                        ),
                                        SizedBox(height: 25),
                                        Expanded(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: selectedValue2 ==
                                                      'Emulator'
                                                  ? 31
                                                  : Provider.of<
                                                              ConnectionListProvider>(
                                                          context,
                                                          listen: false)
                                                      .getvariableListForConnectionId(
                                                          getElementId(
                                                              connectionVariablesList3,
                                                              selectedValue2))
                                                      .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return selectedValue2 ==
                                                        'Emulator'
                                                    ? GestureDetector(
                                                        onTap: () {},
                                                        child:
                                                            VariableCardSelectWidget(
                                                                title: index
                                                                    .toString(),
                                                                sub: 'Local'))
                                                    : GestureDetector(
                                                        onTap: () {
                                                          String _selected = (Provider.of<
                                                                      ConnectionListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getvariableListForConnectionId(
                                                                  getElementId(
                                                                      connectionVariablesList3,
                                                                      selectedValue2))[
                                                                  index]
                                                              .vName
                                                              .toString());
                                                          setState(() {
                                                            selectedTopic = (Provider.of<
                                                                        ConnectionListProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .gettopicListForConnectionId(
                                                                    getElementId(
                                                                        connectionVariablesList3,
                                                                        selectedValue2))[
                                                                    index]
                                                                .userTopic
                                                                .toString());

                                                            selectedVariable =
                                                                _selected;
                                                            variable_ID = index
                                                                .toString();
                                                            modelConn = Provider.of<
                                                                        ConnectionListProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getConnectionModelbyuID(
                                                                    getElementId(
                                                                        connectionVariablesList3,
                                                                        selectedValue2));
                                                          });

                                                          Get.back();
                                                          Get.forceAppUpdate();
                                                        },
                                                        child: GeneralCardSelectWidget(
                                                            title: Provider.of<ConnectionListProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getvariableListForConnectionId(getElementId(connectionVariablesList3, selectedValue2))[
                                                                    index]
                                                                .vName
                                                                .toString(),
                                                            sub: Provider.of<ConnectionListProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getvariableListForConnectionId(
                                                                    getElementId(connectionVariablesList3, selectedValue2))[index]
                                                                .type
                                                                .toString()));
                                              }),
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          );
                        },
                        child: Container(
                          // width: 160,
                          padding: EdgeInsets.all(10),
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: MainColor),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: defaultText(
                                title:
                                    selectedValue2 + ' - ' + selectedVariable,
                                fontSize: 16,
                                TextColor: Colors.red,
                                TextFontFamily: FontWeight.w500),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
