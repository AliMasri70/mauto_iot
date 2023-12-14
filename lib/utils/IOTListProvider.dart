import 'package:flutter/widgets.dart';
import 'package:infinite_canvas/infinite_canvas.dart';
import 'package:mauto_iot/IOTDashboard/elements/digitalDisplay.dart';
import 'package:mauto_iot/IOTDashboard/elements/gaugeWidget.dart';
import 'package:mauto_iot/IOTDashboard/elements/linearGaugeWidget.dart';
import 'package:mauto_iot/model/ledModel.dart';
import 'package:mauto_iot/utils/ConnectionListProvider.dart';
import 'package:mauto_iot/utils/sliderStateprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class WidgetModel extends ChangeNotifier {
  List<InfiniteCanvasNode> widgets = [];
  List<LedModel> LedModelwidgets = [];

  bool isLocked = false;
  InfiniteCanvasController controller = InfiniteCanvasController();

  void addWidget(Widget widget, String label) {
    widgets.add(createCanvasNode(widget, label));
    updateController();
  }

  void deselectAll() {
    controller.deselectAll();
  }

  Future<void> addGaugeWidget(LedModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data;
    if (model.value != null) {
      LedModelwidgets.add(model);
      data = prefs.getString(model.value!
              .topicList[int.parse(model.variable_ID.toString())].nickName
              .toString()) ??
          '0';
    } else {
      data = '';
    }

    final labelwidget = model.nickName.toString() + widgets.length.toString();
    widgets.add(createCanvasNode(
        data == ''
            ? SizedBox(
                child: GaugeWidget(
                    value: "0",
                    min: model.gaugeDatamin.toString(),
                    max: model.gaugeDatamax.toString()),
              )
            : GaugeWidget(
                value: data,
                min: model.gaugeDatamin.toString(),
                max: model.gaugeDatamax.toString()),
        labelwidget,
        offset: Offset(double.parse(model.leftPos.toString()),
            double.parse(model.topPos.toString())),
        size: Size(
          double.parse(model.width.toString()),
          double.parse(model.height.toString()),
        )));
    updateController();
  }

  Future<void> addLinearGaugeWidget(LedModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data;
    if (model.value != null) {
      LedModelwidgets.add(model);
      data = prefs.getString(model.value!
              .topicList[int.parse(model.variable_ID.toString())].nickName
              .toString()) ??
          '0';
    } else {
      data = '';
    }

    final labelwidget = model.nickName.toString() + widgets.length.toString();
    widgets.add(createCanvasNode(
        data == ''
            ? SizedBox(
                child: LinearGaugeWidget(
                    value: "0",
                    min: model.linearGaugeDatamin.toString(),
                    max: model.linearGaugeDatamax.toString()),
              )
            : LinearGaugeWidget(
                value: data,
                min: model.linearGaugeDatamin.toString(),
                max: model.linearGaugeDatamax.toString()),
        labelwidget,
        offset: Offset(double.parse(model.leftPos.toString()),
            double.parse(model.topPos.toString())),
        size: Size(
          double.parse(model.width.toString()),
          double.parse(model.height.toString()),
        )));
    updateController();
  }

  Future<void> addsliderWidget(LedModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data;
    if (model.value != null) {
      LedModelwidgets.add(model);
      data = prefs.getString(model.value!
              .topicList[int.parse(model.variable_ID.toString())].nickName
              .toString()) ??
          '0';
    } else {
      data = '';
    }

    final labelwidget = model.nickName.toString() + widgets.length.toString();
    widgets.add(createCanvasNode(
        data == ''
            ? GaugeWidget(
                value: "0",
                min: model.gaugeDatamin.toString(),
                max: model.gaugeDatamax.toString())
            : GaugeWidget(
                value: data,
                min: model.gaugeDatamin.toString(),
                max: model.gaugeDatamax.toString()),
        labelwidget,
        offset: Offset(double.parse(model.leftPos.toString()),
            double.parse(model.topPos.toString())),
        size: Size(
          double.parse(model.width.toString()),
          double.parse(model.height.toString()),
        )));
    updateController();
  }

  Future<void> addLabelWidget(LedModel model) async {
    final labelwidget = model.nickName.toString() + widgets.length.toString();
    widgets.add(createCanvasNode(model.onState as Widget, labelwidget,
        offset: Offset(double.parse(model.leftPos.toString()),
            double.parse(model.topPos.toString())),
        size: Size(
          double.parse(model.width.toString()),
          double.parse(model.height.toString()),
        )));
    updateController();
  }

  Future<void> addDisplayWidget(LedModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data;
    if (model.value != null) {
      LedModelwidgets.add(model);
      data = prefs.getString(model.value!
              .topicList[int.parse(model.variable_ID.toString())].nickName
              .toString()) ??
          '0';
    } else {
      data = '';
    }

    final labelwidget = model.nickName.toString() + widgets.length.toString();
    widgets.add(createCanvasNode(
        data == ''
            ? LCDDigitalDisplay(value: "")
            : LCDDigitalDisplay(value: data),
        labelwidget,
        offset: Offset(double.parse(model.leftPos.toString()),
            double.parse(model.topPos.toString())),
        size: Size(
          double.parse(model.width.toString()),
          double.parse(model.height.toString()),
        )));
    updateController();
  }

  Future<void> addLedWidget(Widget widget, LedModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data;
    if (model.value != null) {
      LedModelwidgets.add(model);
      data = prefs.getString(model.value!
              .topicList[int.parse(model.variable_ID.toString())].nickName
              .toString()) ??
          '0';
    } else {
      data = '0';
    }

    final labelwidget = model.nickName.toString() + widgets.length.toString();
    widgets.add(createCanvasNode(
        data == model.onStateValue
            ? model.onState as Widget
            : model.offState as Widget,
        labelwidget,
        offset: Offset(double.parse(model.leftPos.toString()),
            double.parse(model.topPos.toString())),
        size: Size(
          double.parse(model.width.toString()),
          double.parse(model.height.toString()),
        )));
    updateController();
  }

  Future<void> addknobWidget(Widget widget, LedModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final labelwidget = model.nickName.toString() + widgets.length.toString();
    widgets.add(createCanvasNode(
        model.value != null
            ? model.onState as Widget
            : model.offState as Widget,
        labelwidget,
        offset: Offset(double.parse(model.leftPos.toString()),
            double.parse(model.topPos.toString())),
        size: Size(
          double.parse(model.width.toString()),
          double.parse(model.height.toString()),
        )));
    updateController();
  }

  void removeWidget(String label) {
    int index = widgets.indexWhere((element) => element.label == label);
    widgets.removeWhere((element) => element.label == label);
    // ignore: unnecessary_null_comparison
    if (index != -1 && LedModelwidgets.isNotEmpty) {
      LedModelwidgets.removeAt(index);
    }
    updateController();
  }

  void lockWidgets() {
    isLocked = true;
    updateWidgetsAllowance();
    updateController();
  }

  void unlockWidgets(BuildContext context) {
    isLocked = false;
    Provider.of<ConnectionListProvider>(context, listen: false).stopTimer();
    updateWidgetsAllowance();
    updateController();
  }

  void updateWidgetsAllowance() {
    for (int i = 0; i < widgets.length; i++) {
      updateResizePermission(
          widgets[i].label.toString(), !widgets[i].allowMove);
    }
  }

  Future<void> onUpdateValues(BuildContext context) async {
    int connectionListLen =
        Provider.of<ConnectionListProvider>(context, listen: false)
            .connectionsList
            .length;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (LedModelwidgets.isNotEmpty) {
      for (int i = 0; i < connectionListLen; i++) {
        if (LedModelwidgets[i].value != null) {
          for (int j = 0; j < LedModelwidgets[i].value!.topicList.length; j++) {
            String topicNamel = LedModelwidgets[i].value!.topicList[j].nickName;
            String valueData =
                prefs.getString(topicNamel.toString()).toString();
            print("topicNamel: $topicNamel " + valueData);

            for (int k = 0; k < LedModelwidgets.length; k++) {
              if (LedModelwidgets[k].topicName == topicNamel) {
                if (LedModelwidgets[k].sliderData != null) {
                  Provider.of<SliderState>(context, listen: false)
                      .setSliderValue(
                          LedModelwidgets[k].id, double.parse(valueData));
                }

                InfiniteCanvasNode updatedNode = InfiniteCanvasNode(
                  key: widgets[k].key,
                  label: widgets[k].label,
                  offset: widgets[k].offset,
                  size: widgets[k]
                      .size, // Keep the original size if you don't want to change it
                  allowResize: widgets[k].allowResize,
                  allowMove: widgets[k].allowMove,
                  child: GestureDetector(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate the scale factors based on the original size of the widget
                        double originalWidth = widgets[k].size.width;
                        double originalHeight = widgets[k].size.height;

                        // Calculate the scale factors
                        double scaleX = constraints.maxWidth / originalWidth;
                        double scaleY = constraints.maxHeight / originalHeight;

                        return Transform.scale(
                          scale: scaleX < scaleY ? scaleX : scaleY,
                          child: LedModelwidgets[k].linearGuageData != null
                              ? LinearGaugeWidget(
                                  value: valueData,
                                  min: LedModelwidgets[k]
                                      .linearGaugeDatamin
                                      .toString(),
                                  max: LedModelwidgets[k]
                                      .linearGaugeDatamax
                                      .toString())
                              : LedModelwidgets[k].gaugeData != null
                                  ? GaugeWidget(
                                      value: valueData,
                                      min: LedModelwidgets[k]
                                          .gaugeDatamin
                                          .toString(),
                                      max: LedModelwidgets[k]
                                          .gaugeDatamax
                                          .toString())
                                  : LedModelwidgets[k].displayData != null
                                      ? LCDDigitalDisplay(value: valueData)
                                      : valueData ==
                                              LedModelwidgets[k].onStateValue
                                          ? LedModelwidgets[k].onState as Widget
                                          : LedModelwidgets[k].offState
                                              as Widget,
                        );
                      },
                    ),
                    onLongPress: () {
                      // removeWidget(widgets[k].label.toString());
                    },
                  ),
                );

                // Replace the existing node with the updated node
                widgets[k] = updatedNode;
                updateController();
              }
            }
          }
        }
      }
    } else {
      for (int i = 0; i < widgets.length; i++) {
        InfiniteCanvasNode updatedNode = InfiniteCanvasNode(
            key: widgets[i].key,
            label: widgets[i].label,
            offset: widgets[i].offset,
            size: widgets[i]
                .size, // Keep the original size if you don't want to change it
            allowResize: widgets[i].allowResize,
            allowMove: widgets[i].allowMove,
            child: widgets[i].child);

        // Replace the existing node with the updated node
        widgets[i] = updatedNode;
        updateController();
      }
    }
  }

  void updateResizePermission(String label, bool allowResize) {
    // Find the index of the node with the specified label
    int index = widgets.indexWhere((element) => element.label == label);

    if (index != -1) {
      // Create a new node with the updated allowResize value
      InfiniteCanvasNode updatedNode = InfiniteCanvasNode(
        key: widgets[index].key,
        label: widgets[index].label,
        offset: widgets[index].offset,
        size: widgets[index].size,
        allowResize: allowResize,
        allowMove: allowResize,
        child: widgets[index].child,
      );

      // Replace the existing node with the updated node
      widgets[index] = updatedNode;

      // Update the controller
      updateController();
    }
  }

  void updateController() {
    controller = InfiniteCanvasController(nodes: List.from(widgets));
    notifyListeners();
  }

  InfiniteCanvasNode createCanvasNode(Widget widget, String label,
      {Offset? offset, Size? size}) {
    final originalOffset = offset ?? const Offset(0, 0);
    final originalSize = size ?? const Size(50, 50);

    return InfiniteCanvasNode(
      key: UniqueKey(),
      label: label,
      offset: originalOffset,
      size: originalSize,
      allowResize: !isLocked,
      allowMove: !isLocked,
      child: GestureDetector(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate the maximum size based on the constraints of the node
            double maxWidth = constraints.maxWidth;
            double maxHeight = constraints.maxHeight;

            // Calculate the scale factors
            double scaleX = originalSize.width / originalSize.width;
            double scaleY = originalSize.height / originalSize.height;

            return Transform.scale(
              scale: scaleX < scaleY
                  ? scaleX
                  : scaleY, // Use the minimum scale factor
              child: FittedBox(
                fit: BoxFit.contain,
                child: widget,
              ),
            );
          },
        ),
        onLongPress: () {
          //  removeWidget(label);
        },
      ),
    );
  }
}
