import 'dart:io';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementCardSelectWidget.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MqttConnectionMain.dart';
import 'package:mauto_iot/model/connectionModel.dart';
import 'package:mauto_iot/model/VariableModel.dart';

import 'package:mauto_iot/utils/ConnectionListProvider.dart';
import 'package:mauto_iot/utils/IOTListProvider.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/utils/topicProvider.dart';
import 'package:mauto_iot/utils/variablesProvider.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

import 'package:mauto_iot/model/topicModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MQTTScreenConnection extends StatefulWidget {
  const MQTTScreenConnection({super.key});

  @override
  State<MQTTScreenConnection> createState() => MQTTScreenConnectionState();
}

class MQTTScreenConnectionState extends State<MQTTScreenConnection> {
  bool isChecked = false, isChecked2 = false, isChecked3 = false;
  // MqttHandler mqttHandler = MqttHandler();
  ConnectionModel? model;
  bool isEmpty1 = false,
      isEmpty2 = false,
      isEmpty3 = false,
      isEmpty4 = false,
      isEmpty5 = false,
      isEmpty6 = false,
      isEmpty7 = false;
  File? file;
  String connectionID = '', encryptionFileName = '';
  final List<String> encryptionItem = [
    'No Encryption',
    'CA signed server certificate',
    'CA certificate file'
  ];
  final List<String> mqttVersion = ['Default', '3.1', '3.1.1'];
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
  late String selectedValue, selectedValue2, selectedValue3;
  TextEditingController nicknameController = TextEditingController();
  TextEditingController clientIDController = TextEditingController();

  TextEditingController urlController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController userTopicController = TextEditingController();
  TextEditingController timeOutController = TextEditingController();
  TextEditingController keepAliveController = TextEditingController();
  TextEditingController willTopicController = TextEditingController();
  TextEditingController willMessageController = TextEditingController();
  updateTopicValue(String topic, String message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(topic, message);
    print("message/// $topic --- $message");

    // ignore: use_build_context_synchronously
  }

  Future<void> submitConnectionVariables(
      List<VariableModel> list, List<TopicModel> topicList) async {
    String uniqID = generateRandomClientID(22);
    print("inside fun innn");
    String clientIdAuto = (clientIDController.text != ''
        ? clientIDController.text
        : generateRandomClientID(22));
    setState(() {
      isEmpty1 = false;
      isEmpty2 = false;
      isEmpty3 = false;
      isEmpty4 = false;
      isEmpty5 = false;
      isEmpty6 = false;
      isEmpty7 = false;
    });
    if (nicknameController.text.trim().isNotEmpty &&
            urlController.text.trim().isNotEmpty &&
            portController.text.trim().isNotEmpty &&
            timeOutController.text.trim().isNotEmpty &&
            keepAliveController.text.trim().isNotEmpty
        // userTopicController.text.trim().isNotEmpty &&
        ) {
      String statusCon = await MqttConnectionMain(
          (String topic, String message) {
        updateTopicValue(topic, message);
      },
          list,
          topicList,
          urlController.text.trim(),
          clientIdAuto,
          int.parse(keepAliveController.text),
          int.parse(portController.text),
          int.parse(timeOutController.text),
          willTopicController.text,
          willMessageController.text,
          usernameController.text,
          passController.text,
          userTopicController.text,
          isChecked2,
          willqos[qos.indexOf(selectedValue3)],
          selectedValue2,
          selectedValue,
          isChecked3);

      ConnectionModel model = ConnectionModel(
        variableList: list,
        topicList: topicList,
        connectionId: connectionID.isNotEmpty ? connectionID : uniqID,
        nickName: nicknameController.text,
        icon: Icons.cloud,
        clientId: clientIdAuto,
        url: urlController.text,
        port: int.parse(portController.text),
        userTopic: userTopicController.text,
        timeOut: int.parse(timeOutController.text),
        keepAlive: int.parse(keepAliveController.text),
        mqttVersion: selectedValue2,
        lastWillTopic: willTopicController.text,
        lastWillMsg: willMessageController.text,
        sessionClean: isChecked2,
        retained: isChecked3,
        status: statusCon,
        encryption: selectedValue,
        willQoS: willqos[qos.indexOf(selectedValue3)],
      );
      print("statusCon $statusCon");
      if (statusCon == "Connected" && connectionID.isEmpty) {
        print("namee1:iff1 ");
        // ignore: use_build_context_synchronously
        Provider.of<ConnectionListProvider>(context, listen: false)
            .addConnection(model);
        // ignore: use_build_context_synchronously

        Get.snackbar("", "Client Connected", icon: Icon(Icons.cloud));

        Navigator.pop(context);
      } else if (statusCon == "Connected" && connectionID.isNotEmpty) {
        print("namee1:iff2 ");
        Provider.of<ConnectionListProvider>(context, listen: false)
            .updateConnection(model);

        Get.back();
      } else {
        Get.back();
        Get.snackbar("", "Client Connection Failed", icon: Icon(Icons.cloud));
      }
    } else {
      if (nicknameController.text.trim().isEmpty) {
        setState(() {
          isEmpty1 = true;
        });
      }
      if (urlController.text.trim().isEmpty) {
        setState(() {
          isEmpty2 = true;
        });
      }
      if (portController.text.trim().isEmpty) {
        setState(() {
          isEmpty3 = true;
        });
      }
      if (timeOutController.text.trim().isEmpty) {
        setState(() {
          isEmpty4 = true;
        });
      }
      if (keepAliveController.text.trim().isEmpty) {
        setState(() {
          isEmpty5 = true;
        });
      }
      if (userTopicController.text.trim().isEmpty && isChecked) {
        setState(() {
          isEmpty6 = true;
        });
      }
      if (willTopicController.text.trim().isEmpty) {
        setState(() {
          isEmpty7 = true;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (Get.arguments != null) {
      setState(() {
        model = Get.arguments;
        connectionID = model!.connectionId;
        clientIDController.text = model!.clientId;
        nicknameController.text = model!.nickName.toString();
        urlController.text = model!.url.toString();
        portController.text = model!.port.toString();
        timeOutController.text = model!.timeOut.toString();
        keepAliveController.text = model!.keepAlive.toString();

        willTopicController.text = model!.lastWillTopic.toString();
        willMessageController.text = model!.lastWillMsg.toString();
        usernameController.text = model!.userName.toString();
        passController.text = model!.password.toString();
        userTopicController.text = model!.userTopic.toString();
        isChecked2 = model!.sessionClean;
        selectedValue3 = qos[willqos.indexOf(model!.willQoS)];
        selectedValue2 =
            mqttVersion[mqttVersion.indexOf(model!.mqttVersion.toString())];
        isChecked3 = model!.retained;
        // selectedValue = model?.encryption.toString()!=null? encryptionItem[
        //     encryptionItem.indexOf(model!.encryption.toString())]:encryptionItem[0];

        selectedValue = encryptionItem[0];
      });
    } else {
      setState(() {
        nicknameController.text = 'MQTT Broker';
        urlController.text = "broker.hivemq.com";
        portController.text = "1883";
        timeOutController.text = "10";
        keepAliveController.text = "20";
        selectedValue = encryptionItem[0];
        selectedValue2 = mqttVersion[0];
        selectedValue3 = qos[0];
      });
    }

    super.initState();
  }

  Future<void> pickEncryptionFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile files = result!.files.first;
      setState(() {
        file = File(result.files.single.path!);
        encryptionFileName = files.name;
      });
    } else {
      // User canceled the picker
      Get.snackbar("Mauto IOT", "Select File Please");
    }
  }

  String generateRandomClientID(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    String rand = String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    return rand;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: Icon(
                      Icons.cloud_outlined,
                      size: 50,
                    ),
                  ),
                  defaultText(
                      title: "MQTT",
                      fontSize: 17,
                      TextColor: textColor,
                      TextFontFamily: FontWeight.bold),
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
                    height: 30,
                  ),
                  inputVariableTextField(
                    validate: false,
                    controller: clientIDController,
                    TextLabel: 'Client ID',
                    hint: "Auto Generated",
                    icon: Icons.perm_identity,
                    inputType: TextInputType.text,
                    width: 1,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  inputVariableTextField(
                    validate: isEmpty2,
                    controller: urlController,
                    TextLabel: 'URL',
                    icon: Icons.link,
                    inputType: TextInputType.text,
                    width: 1,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      inputVariableTextField(
                        validate: isEmpty3,
                        controller: portController,
                        TextLabel: 'Port',
                        icon: Icons.numbers,
                        inputType: TextInputType.number,
                        width: 0.4,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  inputVariableTextField(
                    validate: false,
                    controller: usernameController,
                    TextLabel: 'Username',
                    icon: Icons.person,
                    inputType: TextInputType.text,
                    width: 1,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  inputVariableTextField(
                    validate: false,
                    controller: passController,
                    TextLabel: 'Password',
                    icon: Icons.password,
                    inputType: TextInputType.text,
                    width: 1,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const DividerScreen(
                    title: 'User Topic',
                    size: 0.3,
                  ),
                  const SizedBox(
                    height: 25,
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
                                title: 'Set User Topic',
                                TextColor: textColor,
                                fontSize: 18,
                                TextFontFamily: FontWeight.w400)),
                      )
                    ],
                  ),
                  isChecked
                      ? inputVariableTextField(
                          validate: isEmpty6,
                          controller: userTopicController,
                          TextLabel: 'User Topic',
                          icon: Icons.topic,
                          inputType: TextInputType.text,
                          width: 1,
                        )
                      : Container(),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Divider(),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: defaultText(
                          TextColor: textColor,
                          title: "Encryption SSL/TLS",
                          fontSize: 14,
                          TextFontFamily: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
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
                          items: encryptionItem
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
                  selectedValue.toString() == 'CA certificate file'
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              defaultText(
                                  title: encryptionFileName,
                                  fontSize: 14,
                                  TextColor: greyColor,
                                  TextFontFamily: FontWeight.w400),
                              IconButton(
                                onPressed: () {
                                  pickEncryptionFile();
                                },
                                icon: Icon(Icons.folder_open_rounded),
                              )
                            ],
                          ),
                        )
                      : Container(
                          child: Text(selectedValue),
                        ),
                  const SizedBox(
                    height: 35,
                  ),
                  const DividerScreen(
                    title: 'Clean Session',
                    size: 0.3,
                  ),
                  const SizedBox(
                    height: 25,
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
                                color: isChecked2 ? MainColor : greyColor),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          activeColor: MainColor,
                          value: isChecked2,
                          onChanged: (newValue) {
                            setState(() {
                              isChecked2 = newValue ?? false;
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
                            isChecked2 = !isChecked2;
                          });
                        },
                        child: Opacity(
                            opacity: 0.80,
                            child: defaultText(
                                title: 'Set Clean Session',
                                TextColor: textColor,
                                fontSize: 18,
                                TextFontFamily: FontWeight.w400)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Divider(),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      inputVariableTextField(
                        validate: isEmpty4,
                        controller: timeOutController,
                        TextLabel: 'TimeOut',
                        icon: Icons.timelapse,
                        inputType: TextInputType.number,
                        width: 0.4,
                      ),
                      inputVariableTextField(
                        validate: isEmpty5,
                        controller: keepAliveController,
                        TextLabel: 'Keep Alive',
                        icon: Icons.timer,
                        inputType: TextInputType.number,
                        width: 0.4,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Divider(),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: defaultText(
                          TextColor: textColor,
                          title: "MQTT Version",
                          fontSize: 15,
                          TextFontFamily: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: DropdownButtonFormField2<String>(
                          value: selectedValue2,
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
                          items: mqttVersion
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
                            selectedValue2 = value.toString();
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
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Divider(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            defaultText(
                                title: "Last Will Message",
                                fontSize: 15,
                                TextColor: textColor,
                                TextFontFamily: FontWeight.w400),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        inputVariableTextField(
                          validate: false,
                          controller: willTopicController,
                          TextLabel: 'Last Will Topic',
                          icon: Icons.topic,
                          inputType: TextInputType.text,
                          width: 1,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        inputVariableTextField(
                          validate: false,
                          controller: willMessageController,
                          TextLabel: 'Last Will Message',
                          icon: Icons.message,
                          inputType: TextInputType.text,
                          width: 1,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: defaultText(
                                TextColor: textColor,
                                title: "Last-Will QoS",
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
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40.0,
                              width: 40,
                              child: Checkbox(
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 1.0,
                                      color:
                                          isChecked3 ? MainColor : greyColor),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
