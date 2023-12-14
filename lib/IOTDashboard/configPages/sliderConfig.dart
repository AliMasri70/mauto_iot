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
import 'package:mauto_iot/utils/sliderStateprovider.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:mauto_iot/widgets/modalSheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class SliderConfig extends StatefulWidget {
  const SliderConfig({super.key});

  @override
  State<SliderConfig> createState() => _SliderConfigState();
}

class _SliderConfigState extends State<SliderConfig> {
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
  late String selectedOrientation;
  List<Map<String, dynamic>> connectionVariablesList3 = [
    {"id": '0', "value": "Emulator"},
  ];
  ConnectionModel? modelConn;
  late String selectedValue2;
  String selectedVariable = 'Not Selected';
  String selectedTopic = '';
  double value = 0.0;
  List<String> orientationList = ["Horizontal", "Vertical"];
  TextEditingController widgetName = TextEditingController(text: 'Slider');
  TextEditingController leftPos = TextEditingController(text: '30');
  TextEditingController topPos = TextEditingController(text: '150');
  TextEditingController widgetWidth = TextEditingController(text: '50');
  TextEditingController widgetHeight = TextEditingController(text: '25');
  TextEditingController labelVal = TextEditingController(text: 'Label');
  TextEditingController colorVal = TextEditingController(text: 'Label');
  TextEditingController roundingController = TextEditingController(text: '1');
  TextEditingController divisionsController = TextEditingController(text: '0');
  TextEditingController limitDownController =
      TextEditingController(text: '0.0');
  TextEditingController limitupController =
      TextEditingController(text: '100.0');

  @override
  void initState() {
    getConnectionList();
    selectedOrientation = orientationList[0].toString();
    selectedValue2 = getElement(connectionVariablesList3, '0');
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
    double intevalVal = (double.parse(limitDownController.text) +
            double.parse(limitupController.text)) /
        double.parse(divisionsController.text);
    String idSlider = DateTime.now().millisecondsSinceEpoch.toString();
    Provider.of<SliderState>(context, listen: false).addSlider(idSlider, 0.0);
    String valueData = prefs.getString(selectedTopic) ?? '';
    LedModel model = LedModel(
      id: idSlider,
      nickName: widgetName.text,
      leftPos: leftPos.text,
      topPos: topPos.text,
      width: widgetWidth.text,
      height: widgetHeight.text,
      variable: selectedVariable,
      variable_ID: variable_ID,
      sliderData: Provider.of<SliderState>(context, listen: false)
          .getSliderValue(idSlider)
          .toString(),
      topicName: selectedTopic,
      value: modelConn,
      onState: selectedOrientation == "Horizontal"
          ? Center(child: Consumer<SliderState>(
              builder: (context, sliderState, _) {
                return SfSlider(
                  min: double.parse(limitDownController.text),
                  max: double.parse(limitupController.text),
                  value: sliderState.sliderValues[idSlider],
                  interval: intevalVal,
                  activeColor: pickerColor3,
                  inactiveColor: pickerColor,
                  showDividers:
                      double.parse(divisionsController.text) > 0 ? true : false,
                  showTicks: false,
                  showLabels: false,
                  onChanged: (dynamic newValue) {
                    sliderState.updateSliderValue(
                        context, modelConn!, selectedTopic, idSlider, newValue);
                  },
                );
              },
            ))
          : Center(child: Consumer<SliderState>(
              builder: (context, sliderState, _) {
                return SfSlider.vertical(
                  min: double.parse(limitDownController.text),
                  max: double.parse(limitupController.text),
                  value: sliderState.sliderValues[idSlider],
                  interval: intevalVal,
                  activeColor: pickerColor3,
                  inactiveColor: pickerColor,
                  showDividers:
                      double.parse(divisionsController.text) > 0 ? true : false,
                  showTicks: false,
                  showLabels: false,
                  onChanged: (dynamic newValue) {
                    sliderState.updateSliderValue(
                        context, modelConn!, selectedTopic, idSlider, newValue);
                  },
                );
              },
            )),
      offState: selectedOrientation == "Horizontal"
          ? Center(child: Consumer<SliderState>(
              builder: (context, sliderState, _) {
                return SfSlider(
                  min: double.parse(limitDownController.text),
                  max: double.parse(limitupController.text),
                  value: sliderState.sliderValues[idSlider],
                  interval: intevalVal,
                  activeColor: pickerColor3,
                  inactiveColor: pickerColor,
                  showDividers:
                      double.parse(divisionsController.text) > 0 ? true : false,
                  showTicks: false,
                  showLabels: false,
                  onChanged: (dynamic newValue) {
                    sliderState.updateSliderValueoff(idSlider, newValue);
                  },
                );
              },
            ))
          : Center(child: Consumer<SliderState>(
              builder: (context, sliderState, _) {
                return SfSlider.vertical(
                  min: double.parse(limitDownController.text),
                  max: double.parse(limitupController.text),
                  value: sliderState.sliderValues[idSlider],
                  interval: intevalVal,
                  activeColor: pickerColor3,
                  inactiveColor: pickerColor,
                  showDividers:
                      double.parse(divisionsController.text) > 0 ? true : false,
                  showTicks: false,
                  showLabels: false,
                  onChanged: (dynamic newValue) {
                    sliderState.updateSliderValueoff(idSlider, newValue);
                  },
                );
              },
            )),
    );

    Provider.of<WidgetModel>(context, listen: false)
        .addknobWidget(Container(), model);
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
            title: "Slider",
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
                const DividerScreen(
                  title: 'Displayed value settings',
                  size: 0.3,
                ),
                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Limit Down",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    inputVariableTextField(
                      controller: limitDownController,
                      validate: false,
                      TextLabel: 'Limit Down',
                      icon: Icons.arrow_drop_down,
                      inputType: TextInputType.number,
                      width: 0.4,
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
                        title: "Limit Up",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    inputVariableTextField(
                      controller: limitupController,
                      validate: false,
                      TextLabel: 'Limit Up',
                      icon: Icons.arrow_drop_up,
                      inputType: TextInputType.number,
                      width: 0.4,
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
                        title: "Rounding",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    inputVariableTextField(
                      controller: roundingController,
                      validate: false,
                      TextLabel: 'Rounding',
                      icon: Icons.adjust,
                      inputType: TextInputType.number,
                      width: 0.4,
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
                        title: "Divisions",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    inputVariableTextField(
                      controller: divisionsController,
                      validate: false,
                      TextLabel: 'Divisions',
                      icon: Icons.straighten,
                      inputType: TextInputType.number,
                      width: 0.4,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),
                const DividerScreen(
                  title: 'Widget settings',
                  size: 0.3,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Orientation",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    const SizedBox(
                      width: 0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: DropdownButtonFormField2<String>(
                        value: selectedOrientation.toString(),
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
                        items: orientationList
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
                            selectedOrientation = value.toString();
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

                /////color

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Slider Color",
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
                        title: "Active Color",
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

                /////////
                const DividerScreen(
                  title: 'Action settings',
                  size: 0.3,
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
                              title: 'Auto Reset',
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
