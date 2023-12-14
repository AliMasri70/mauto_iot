import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementCardSelectWidget.dart';
import 'package:mauto_iot/IOTDashboard/elements/colorPicker.dart';
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

class FrameConfig extends StatefulWidget {
  const FrameConfig({super.key});

  @override
  State<FrameConfig> createState() => _FrameConfigState();
}

class _FrameConfigState extends State<FrameConfig> {
// create some values
  late Alignment selectedAlignment;
  late String selectedAlignmentName;

  late String selectedfontFamily;
  late FontStyle fontStyle;
  late FontWeight fontWeight;
  late String selectedfontStyle;
  late String selectedfontweight;
  bool isChecked = false, isShadow = false;
  Color pickerColor = Color(0xfff44336),
      pickerColor2 = Color(0xff673AB7),
      pickerColor3 = Color(0xff607d8b);
  Color currentColor = Color(0xfff44336),
      currentColor2 = Color(0xff673AB7),
      currentColor3 = Color(0xff607d8b);
  String variable_ID = '';
  late String selectedBorderWidth;

  String selectedTopic = '';
  var borderWidthList = Iterable<int>.generate(31).toList();
  TextEditingController widgetName = TextEditingController(text: 'Frame');
  TextEditingController leftPos = TextEditingController(text: '30');
  TextEditingController topPos = TextEditingController(text: '150');
  TextEditingController widgetWidth = TextEditingController(text: '50');
  TextEditingController widgetHeight = TextEditingController(text: '25');
  TextEditingController labelVal = TextEditingController(text: 'Label');
  TextEditingController colorVal = TextEditingController(text: 'Label');
  TextEditingController fontheightVal = TextEditingController(text: '3.0');
  TextEditingController maxLinesVal = TextEditingController(text: '1');
  TextEditingController cornerRadiusVal = TextEditingController(text: '6');

  @override
  void initState() {
    selectedBorderWidth = borderWidthList[3].toString();
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

  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void changeColor3(Color color) {
    setState(() => pickerColor3 = color);
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
      // variable: selectedVariable,
      variable_ID: variable_ID,
      // topicName: selectedTopic,
      // value: modelConn,
      onState: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: pickerColor3, width: double.parse(selectedBorderWidth)),
          color: pickerColor,
          borderRadius:
              BorderRadius.circular(double.parse(cornerRadiusVal.text)),
          boxShadow: isShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ]
              : [],
        ),
        height: double.parse(widgetHeight.text),
        width: double.parse(widgetWidth.text),
      ),
    );

    Provider.of<WidgetModel>(context, listen: false).addLabelWidget(model);
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
            title: "Frame",
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
                  height: 25,
                ),
                SizedBox(
                  child: Divider(),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Color",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    const SizedBox(
                      width: 0,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            builder: (context) => AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: changeColor,
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text(
                                    'Apply',
                                    style: TextStyle(color: MainColor),
                                  ),
                                  onPressed: () {
                                    setState(() => currentColor = pickerColor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            context: context,
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 60,
                          decoration: BoxDecoration(
                              color: pickerColor,
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    const SizedBox(
                      width: 0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Border Color",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            builder: (context) => AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor3,
                                  onColorChanged: changeColor3,
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text(
                                    'Apply',
                                    style: TextStyle(color: MainColor),
                                  ),
                                  onPressed: () {
                                    setState(
                                        () => currentColor3 = pickerColor3);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            context: context,
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 60,
                          decoration: BoxDecoration(
                              color: pickerColor3,
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    const SizedBox(
                      width: 0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Border Width",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    const SizedBox(
                      width: 0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: DropdownButtonFormField2<String>(
                        value: selectedBorderWidth.toString(),
                        isExpanded: true,
                        decoration: InputDecoration(
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
                        items: borderWidthList
                            .map((item) => DropdownMenuItem<String>(
                                  value: item.toString(),
                                  child: Text(
                                    item.toString(),
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
                            selectedBorderWidth = value.toString();
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
                    const SizedBox(
                      width: 6,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Corner Radius",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    inputVariableTextField(
                      controller: cornerRadiusVal,
                      validate: false,
                      TextLabel: 'Corner Radius',
                      icon: Icons.line_weight_sharp,
                      inputType: TextInputType.number,
                      width: 0.4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 35,
                    ),
                    SizedBox(
                      height: 30.0,
                      width: 30,
                      child: Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                              width: 1.0,
                              color: isShadow ? MainColor : greyColor),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: MainColor,
                        value: isShadow,
                        onChanged: (newValue) {
                          setState(() {
                            isShadow = newValue ?? false;
                          });
                        },
                        //  <-- leading Checkbox
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isShadow = !isShadow;
                        });
                      },
                      child: Opacity(
                          opacity: 0.80,
                          child: defaultText(
                              title: 'Shadow',
                              TextColor: textColor,
                              fontSize: 18,
                              TextFontFamily: FontWeight.w400)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
