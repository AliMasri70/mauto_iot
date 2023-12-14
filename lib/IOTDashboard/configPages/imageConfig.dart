import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ImageConfig extends StatefulWidget {
  const ImageConfig({super.key});

  @override
  State<ImageConfig> createState() => _ImageConfigState();
}

class _ImageConfigState extends State<ImageConfig> {
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
  bool isCheckedColor = false, icCheckedVer = false, icCheckedHor = false;
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
  TextEditingController widgetName = TextEditingController(text: 'Image');
  TextEditingController leftPos = TextEditingController(text: '50');
  TextEditingController topPos = TextEditingController(text: '100');
  TextEditingController widgetWidth = TextEditingController(text: '100');
  TextEditingController widgetHeight = TextEditingController(text: '100');
  TextEditingController labelVal = TextEditingController(text: '0');
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

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<bool> _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
    ].request();

    if (statuses[Permission.photos] == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  setLedWidget() async {
    ColorFilter colorFilter = ColorFilter.mode(
      isCheckedColor ? pickerColor : Colors.transparent,
      BlendMode.overlay,
    );
    Matrix4 transformMatrix = Matrix4.identity()
      ..scale(
        icCheckedHor ? -1.0 : 1.0,
        icCheckedVer ? -1.0 : 1.0,
      )
      ..rotateZ(double.parse(labelVal.text));
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
      onState: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(
            icCheckedHor ? -1.0 : 1.0,
            icCheckedVer ? -1.0 : 1.0,
          )
          ..rotateZ(double.parse(labelVal.text)),
        child: Image.file(
          color: isCheckedColor ? pickerColor : Colors.transparent,
          colorBlendMode: BlendMode.modulate,
          _image!,
          // height: 200,
          // width: 400,
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
            title: "Image",
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: _image == null
                        ? Image.asset(
                            "assets/images/placeholder.png",
                            height: 200,
                            width: 400,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Image.file(
                                  _image!,
                                  height: 400,
                                  width: 400,
                                ),
                              ),
                              SizedBox(
                                // width: MediaQuery.of(context).size.width * 0.3,
                                // height: MediaQuery.of(context).size.width * 0.3,
                                child: IconButton(
                                    onPressed: () {
                                      print("removee");
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCheckedColor = !isCheckedColor;
                        });
                      },
                      child: Opacity(
                          opacity: 0.80,
                          child: defaultText(
                              title: 'Color',
                              TextColor: textColor,
                              fontSize: 18,
                              TextFontFamily: FontWeight.w400)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    SizedBox(
                      height: 30.0,
                      width: 30,
                      child: Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                              width: 1.0,
                              color: isCheckedColor ? MainColor : greyColor),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: MainColor,
                        value: isCheckedColor,
                        onChanged: (newValue) {
                          setState(() {
                            isCheckedColor = newValue ?? false;
                          });
                        },
                        //  <-- leading Checkbox
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    isCheckedColor
                        ? GestureDetector(
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
                                        setState(
                                            () => currentColor = pickerColor);
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
                            ))
                        : Container()
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
                    defaultText(
                        title: "Angle",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
                    SizedBox(
                      width: 15,
                    ),
                    inputVariableTextField(
                      controller: labelVal,
                      validate: false,
                      TextLabel: 'Angle',
                      icon: Icons.text_fields_rounded,
                      inputType: TextInputType.number,
                      width: 0.4,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    defaultText(
                        title: "0-360",
                        fontSize: 16,
                        TextColor: textColor,
                        TextFontFamily: FontWeight.normal),
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          icCheckedHor = !icCheckedHor;
                        });
                      },
                      child: Opacity(
                          opacity: 0.80,
                          child: defaultText(
                              title: 'Mirror Horizontal',
                              TextColor: textColor,
                              fontSize: 18,
                              TextFontFamily: FontWeight.w400)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    SizedBox(
                      height: 30.0,
                      width: 30,
                      child: Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                              width: 1.0,
                              color: icCheckedHor ? MainColor : greyColor),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: MainColor,
                        value: icCheckedHor,
                        onChanged: (newValue) {
                          setState(() {
                            icCheckedHor = newValue ?? false;
                          });
                        },
                        //  <-- leading Checkbox
                      ),
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          icCheckedVer = !icCheckedVer;
                        });
                      },
                      child: Opacity(
                          opacity: 0.80,
                          child: defaultText(
                              title: 'Mirror Vertical',
                              TextColor: textColor,
                              fontSize: 18,
                              TextFontFamily: FontWeight.w400)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    SizedBox(
                      height: 30.0,
                      width: 30,
                      child: Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                              width: 1.0,
                              color: icCheckedVer ? MainColor : greyColor),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: MainColor,
                        value: icCheckedVer,
                        onChanged: (newValue) {
                          setState(() {
                            icCheckedVer = newValue ?? false;
                          });
                        },
                        //  <-- leading Checkbox
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
