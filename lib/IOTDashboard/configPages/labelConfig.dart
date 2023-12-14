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

class LabelConfig extends StatefulWidget {
  const LabelConfig({super.key});

  @override
  State<LabelConfig> createState() => _LabelConfigState();
}

class _LabelConfigState extends State<LabelConfig> {
  List<FontStyle> fontStyles = [
    FontStyle.normal,
    FontStyle.italic,
  ];
  final List<String> fontStyleName = [
    "Normal",
    "Italic",
  ];
  List<FontWeight> fontWeightList = [
    FontWeight.bold,
    FontWeight.normal,
  ];

  final List<String> fontFamilyName = [
    "Roboto",
    "RobotoMono",
    "Quantico",
    "Silkscreen",
    "Caveat",
    "PixelifySans",
    "PlayfairDisplay"
  ];

  final List<Alignment> alignments = [
    Alignment.center,
    Alignment.centerLeft,
    Alignment.centerRight,
    Alignment.bottomCenter,
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topCenter,
    Alignment.topLeft,
    Alignment.topRight,
  ];
  final List<String> alignmentsName = [
    "Center",
    "Center Left",
    "Center Right",
    "Bottom Center",
    "Bottom Left",
    "Bottom Right",
    "Top Center",
    "Top Left",
    "Top Right",
  ];
// create some values
  late Alignment selectedAlignment;
  late String selectedAlignmentName;

  late String selectedfontFamily;
  late FontStyle fontStyle;
  late FontWeight fontWeight;
  late String selectedfontStyle;
  late String selectedfontweight;
  bool isChecked = false, isFrame = false;
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
  TextEditingController widgetName = TextEditingController(text: 'Label');
  TextEditingController leftPos = TextEditingController(text: '50');
  TextEditingController topPos = TextEditingController(text: '100');
  TextEditingController widgetWidth = TextEditingController(text: '100');
  TextEditingController widgetHeight = TextEditingController(text: '60');
  TextEditingController labelVal = TextEditingController(text: 'Label');
  TextEditingController colorVal = TextEditingController(text: 'Label');
  TextEditingController fontheightVal = TextEditingController(text: '3.0');
  TextEditingController maxLinesVal = TextEditingController(text: '1');
  TextEditingController cornerRadiusVal = TextEditingController(text: '6');

  @override
  void initState() {
    selectedAlignment = alignments[0];
    selectedAlignmentName = alignmentsName[0];
    fontStyle = fontStyles[0];
    fontWeight = fontWeightList[0];
    selectedfontStyle = fontStyleName[0];
    selectedfontFamily = fontFamilyName[0];
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
    print(alignments[alignmentsName.indexOf(selectedAlignmentName)]);
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
              color: isFrame ? pickerColor3 : Colors.transparent,
              width: isFrame ? double.parse(selectedBorderWidth) : 0),
          color: isFrame ? pickerColor2 : Colors.transparent,
          borderRadius: BorderRadius.circular(
              isFrame ? double.parse(cornerRadiusVal.text) : 0),
        ),
        height: double.parse(widgetHeight.text),
        width: double.parse(widgetWidth.text),
        child: Align(
          alignment: alignments[alignmentsName.indexOf(selectedAlignmentName)],
          child: Text(
            labelVal.text,
            maxLines: int.parse(maxLinesVal.text),
            style: TextStyle(
              fontWeight: isChecked ? fontWeightList[0] : fontWeightList[1],
              fontStyle: fontStyles[fontStyleName.indexOf(selectedfontStyle)],
              fontFamily: selectedfontFamily,
              color: pickerColor,
              height: double.parse(fontheightVal.text),
            ),
          ),
        ),
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
            title: "Label",
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
                        title: "Label",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    inputVariableTextField(
                      controller: labelVal,
                      validate: false,
                      TextLabel: 'Label',
                      icon: Icons.text_fields_rounded,
                      inputType: TextInputType.text,
                      width: 0.6,
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
                        title: "Align",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: DropdownButtonFormField2<String>(
                        value: selectedAlignmentName.toString(),
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
                        items: alignmentsName
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
                            selectedAlignmentName = value.toString();
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
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Font Style",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: DropdownButtonFormField2<String>(
                        value: selectedfontStyle.toString(),
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
                        items: fontStyleName
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
                            selectedfontStyle = value.toString();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.0,
                          width: 30,
                          child: Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                  width: 1.0,
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
                        const SizedBox(
                          width: 3,
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
                                  title: 'Bold',
                                  TextColor: textColor,
                                  fontSize: 18,
                                  TextFontFamily: FontWeight.bold)),
                        )
                      ],
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
                        title: "Font Family",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: DropdownButtonFormField2<String>(
                        value: selectedfontFamily.toString(),
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
                        items: fontFamilyName
                            .map((item) => DropdownMenuItem<String>(
                                  value: item.toString(),
                                  child: Text(
                                    item.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: item.toString()),
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
                            selectedfontFamily = value.toString();
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
                 
                 
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultText(
                        title: "Font Height",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    inputVariableTextField(
                      controller: fontheightVal,
                      validate: false,
                      TextLabel: 'Font Height',
                      icon: Icons.height,
                      inputType: TextInputType.number,
                      width: 0.6,
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
                        title: "Max Lines",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    inputVariableTextField(
                      controller: maxLinesVal,
                      validate: false,
                      TextLabel: 'Max Lines',
                      icon: Icons.line_weight_sharp,
                      inputType: TextInputType.number,
                      width: 0.6,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  child: Divider(),
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
                              color: isFrame ? MainColor : greyColor),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: MainColor,
                        value: isFrame,
                        onChanged: (newValue) {
                          setState(() {
                            isFrame = newValue ?? false;
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
                          isFrame = !isFrame;
                        });
                      },
                      child: Opacity(
                          opacity: 0.80,
                          child: defaultText(
                              title: 'Frame',
                              TextColor: textColor,
                              fontSize: 18,
                              TextFontFamily: FontWeight.w400)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                isFrame
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              defaultText(
                                  title: "Background Color",
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
                                            pickerColor: pickerColor2,
                                            onColorChanged: changeColor2,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: const Text(
                                              'Apply',
                                              style:
                                                  TextStyle(color: MainColor),
                                            ),
                                            onPressed: () {
                                              setState(() =>
                                                  currentColor2 = pickerColor2);
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
                                        color: pickerColor2,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              defaultText(
                                  title: "Border Color         ",
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
                                              style:
                                                  TextStyle(color: MainColor),
                                            ),
                                            onPressed: () {
                                              setState(() =>
                                                  currentColor3 = pickerColor3);
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              defaultText(
                                  title: "Border Width      ",
                                  fontSize: 16,
                                  TextColor: textColor,
                                  TextFontFamily: FontWeight.normal),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: DropdownButtonFormField2<String>(
                                  value: selectedBorderWidth.toString(),
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
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
                        ],
                      )
                    : Container(),
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
