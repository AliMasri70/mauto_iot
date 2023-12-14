import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_canvas/infinite_canvas.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementCardSelectWidget.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementsScreen.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MQTTScreenConnection.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/MqttConnectionMain.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/connectionList.dart';
import 'package:mauto_iot/utils/ConnectionListProvider.dart';
import 'package:mauto_iot/utils/IOTListProvider.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/utils/gridBackground.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MainIOT extends StatefulWidget {
  const MainIOT({super.key});

  @override
  State<MainIOT> createState() => _MainIOTState();
}

class _MainIOTState extends State<MainIOT> {
  InfiniteCanvasController controller = InfiniteCanvasController();
  List<InfiniteCanvasNode<dynamic>> nodes = [];

  @override
  void initState() {
    super.initState();
  }

  bool _start = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // nodes = Provider.of<WidgetModel>(context).widgets;
    bool isLock = Provider.of<WidgetModel>(context, listen: false).isLocked;
    double _pagePadding = 16.0;
    return Scaffold(
      backgroundColor: isLock ? Colors.grey : Colors.white,
      appBar:
          AppBar(title: const Text('Mauto IOT'), centerTitle: false, actions: [
        IconButton(
          icon: isLock ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
          onPressed: () async {
            if (isLock) {
              Provider.of<WidgetModel>(context, listen: false)
                  .unlockWidgets(context);
            } else {
              Provider.of<WidgetModel>(context, listen: false).lockWidgets();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            Get.to(() => const ElementsScreen());
          },
        ),
        IconButton(
          icon: _start
              ? const Icon(Icons.pause_circle_sharp, color: greyColor)
              : const Icon(Icons.play_circle_sharp, color: MainColor),
          onPressed: () async {
            setState(() {
              _start = !_start;
            });
            if (_start) {
              Provider.of<WidgetModel>(context, listen: false).lockWidgets();
              Provider.of<ConnectionListProvider>(context, listen: false)
                  .startTimer(context);
            } else {
              Provider.of<WidgetModel>(context, listen: false)
                  .unlockWidgets(context);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () async {
            WoltModalSheet.show<void>(
              context: context,
              pageListBuilder: (modalSheetContext) {
                final textTheme = Theme.of(context).textTheme;
                return [
                  WoltModalSheetPage.withSingleChild(
                      hasSabGradient: false,
                      topBarTitle:
                          Text('Mauto IOT', style: textTheme.titleMedium),
                      isTopBarLayerAlwaysVisible: true,
                      trailingNavBarWidget: IconButton(
                        padding: EdgeInsets.all(_pagePadding),
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 400),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("My connection");
                                  Get.back();
                                  Get.to(() => const ConnectionList());
                                },
                                child: GeneralCardSelectWidget1(
                                  sub: "My Connections",
                                  icondata: Icons.device_hub,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ];
              },
              modalTypeBuilder: (context) {
                final size = MediaQuery.of(context).size.width;
                if (size < 768) {
                  return WoltModalType.bottomSheet;
                } else {
                  return WoltModalType.dialog;
                }
              },
              onModalDismissedWithBarrierTap: () {
                debugPrint('Closed modal sheet with barrier tap');
                Navigator.of(context).pop();
                // pageIndexNotifier.value = 0;
              },
              maxDialogWidth: 560,
              minDialogWidth: 400,
              minPageHeight: 0.0,
              maxPageHeight: 0.9,
            );
          },
        )
      ]),
      body: Stack(
        children: [
          GridBackgroundBuilder(
            cellWidth: 50.0,
            cellHeight: 50.0,
          ),
          InteractiveViewer(
            boundaryMargin: EdgeInsets.all(double.infinity),
            minScale: 0.5,
            maxScale: 2.0,
            child: InfiniteCanvas(
              edgesUseStraightLines: false,
              drawVisibleOnly: true,
              menuVisible: false,
              backgroundBuilder: (context, rect) {
                return SizedBox.shrink(); // Empty SizedBox to avoid overlapping
              },
              controller: Provider.of<WidgetModel>(context).controller,
            ),
          ),
        ],
      ),
    );
  }
}
