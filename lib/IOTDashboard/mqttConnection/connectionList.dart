import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/mqttConnectionsetting.dart';

import 'package:mauto_iot/model/connectionModel.dart';
import 'package:mauto_iot/utils/ConnectionListProvider.dart';
import 'package:mauto_iot/utils/IOTListProvider.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:slideable/slideable.dart';

class ConnectionList extends StatefulWidget {
  const ConnectionList({super.key});

  @override
  State<ConnectionList> createState() => _ConnectionListState();
}

class _ConnectionListState extends State<ConnectionList> {
  List<ConnectionModel> connectionLists = [];
  bool isLoading = false;
  // MqttHandler mqttHandler = MqttHandler();

  @override
  void initState() {
    super.initState();
  }

  removeVariable(BuildContext context, int idd) {
    String topicIdToRemove =
        Provider.of<ConnectionListProvider>(context, listen: false)
            .connectionsList[idd]
            .connectionId
            .toString();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<ConnectionListProvider>(context, listen: false)
          .removeConnection(topicIdToRemove);
      print(topicIdToRemove);
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: defaultText(
              title: "Connection List",
              fontSize: 22,
              TextColor: textColor,
              TextFontFamily: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(() => MQTTGeneralSetting());

              // final currDir =
              //     '..${path.current}assets${path.separator}mosquitto.org.crt';

              // print("namee2: $currDir");
            },
            icon: const Icon(
              Icons.add,
              size: 28,
              color: textColor,
            ),
          )
        ],
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: Provider.of<ConnectionListProvider>(context)
                  .connectionsList
                  .isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: ListView.builder(
                    itemCount: Provider.of<ConnectionListProvider>(context)
                        .connectionsList
                        .length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => MQTTGeneralSetting(),
                              arguments: Provider.of<ConnectionListProvider>(
                                      context,
                                      listen: false)
                                  .connectionsList[i]);
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
                                  // Provider.of<ConnectionListProvider>(context,
                                  //         listen: false)
                                  //     .stopTimer();
                                  removeVariable(context, i);
                                },
                                backgroudColor: Colors.transparent,
                              ),
                            ],
                            child: Container(
                              margin: EdgeInsets.only(right: 4),
                              padding: const EdgeInsets.all(18),
                              decoration: ShapeDecoration(
                                color: const Color.fromARGB(255, 233, 232, 232),
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
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.cloud,
                                              size: 35,
                                              color: textColor,
                                            ),
                                            defaultText(
                                                title: "MQTT",
                                                fontSize: 14,
                                                TextColor: textColor,
                                                TextFontFamily: FontWeight.w500)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              defaultText(
                                                  title: Provider.of<
                                                              ConnectionListProvider>(
                                                          context)
                                                      .connectionsList[i]
                                                      .nickName,
                                                  fontSize: 20,
                                                  TextColor: textColor,
                                                  TextFontFamily:
                                                      FontWeight.bold),
                                              defaultText(
                                                  title:
                                                      "URL: ${Provider.of<ConnectionListProvider>(context).connectionsList[i].url}",
                                                  fontSize: 12,
                                                  TextColor: textColor,
                                                  TextFontFamily:
                                                      FontWeight.w300),
                                              defaultText(
                                                  title: "Protocol: MQTT",
                                                  fontSize: 12,
                                                  TextColor: textColor,
                                                  TextFontFamily:
                                                      FontWeight.w300),
                                              defaultText(
                                                  title:
                                                      "Status: ${Provider.of<ConnectionListProvider>(context).connectionsList[i].status}",
                                                  fontSize: 12,
                                                  TextColor:
                                                      Provider.of<ConnectionListProvider>(
                                                                      context)
                                                                  .connectionsList[
                                                                      i]
                                                                  .status ==
                                                              "Connected"
                                                          ? MainColor
                                                          : Colors.red,
                                                  TextFontFamily:
                                                      FontWeight.w300)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Provider.of<ConnectionListProvider>(context)
                                              .connectionsList[i]
                                              .status ==
                                          "Connected"
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.17,
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  Provider.of<ConnectionListProvider>(
                                                          context,
                                                          listen: false)
                                                      .disconnectMqtt(
                                                          Provider.of<ConnectionListProvider>(
                                                                      context,
                                                                      listen: false)
                                                                  .connectionsList[
                                                              i],
                                                          Provider.of<ConnectionListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .connectionsList[
                                                                  i]
                                                              .url,
                                                          Provider.of<ConnectionListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .connectionsList[
                                                                  i]
                                                              .clientId,
                                                          Provider.of<ConnectionListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .connectionsList[
                                                                  i]
                                                              .lastWillTopic);
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                ),
                                              ),
                                              defaultText(
                                                  title: "Disconnect",
                                                  fontSize: 10,
                                                  TextColor: textGreyColor,
                                                  TextFontFamily:
                                                      FontWeight.w400)
                                            ],
                                          ),
                                        )
                                      : isLoading == false
                                          ? SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.17,
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      Provider.of<ConnectionListProvider>(context, listen: false).reconnectMqtt(
                                                          context,
                                                          Provider.of<ConnectionListProvider>(context, listen: false)
                                                                  .connectionsList[
                                                              i],
                                                          Provider.of<ConnectionListProvider>(context, listen: false)
                                                              .connectionsList[
                                                                  i]
                                                              .url,
                                                          Provider.of<ConnectionListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .connectionsList[
                                                                  i]
                                                              .clientId,
                                                          Provider.of<ConnectionListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .connectionsList[
                                                                  i]
                                                              .keepAlive,
                                                          Provider.of<ConnectionListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .connectionsList[i]
                                                              .port,
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].timeOut,
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].lastWillTopic,
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].lastWillMsg,
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].userName.toString(),
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].password.toString(),
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].userTopic,
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].sessionClean,
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].willQoS,
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].mqttVersion,
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].encryption.toString(),
                                                          Provider.of<ConnectionListProvider>(context, listen: false).connectionsList[i].retained);
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    },
                                                    icon:
                                                        const Icon(Icons.wifi),
                                                  ),
                                                  defaultText(
                                                      title: "Connect",
                                                      fontSize: 10,
                                                      TextColor: textGreyColor,
                                                      TextFontFamily:
                                                          FontWeight.w400)
                                                ],
                                              ),
                                            )
                                          : const CupertinoActivityIndicator(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: defaultText(
                      title: "Connection List is Empty",
                      fontSize: 22,
                      TextColor: textColor,
                      TextFontFamily: FontWeight.bold),
                )),
    );
  }
}
