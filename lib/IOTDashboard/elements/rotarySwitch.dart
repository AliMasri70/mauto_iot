import 'package:flutter/material.dart';

class MyRotatedBox extends StatefulWidget {
  final Function(int) onValueChanged;
  final double width;
  final double height;
  MyRotatedBox(
      {required this.onValueChanged,
      required this.width,
      required this.height});
  @override
  _MyRotatedBoxState createState() => _MyRotatedBoxState();
}

class _MyRotatedBoxState extends State<MyRotatedBox> {
  double finalAngle = 0.0;
  double oldAngle = 0.0;
  double upsetAngle = 0.0;
  int stateValue = 0;
  double convertToNearestAngle(double angle) {
    if ((angle < 0.5 && angle > 0) || (angle < 0 && angle > -0.5)) {
      // widget.onValueChanged(0);

      stateValue = 0;

      return 22.0;
    } else if ((angle > 0.5 && angle < 2.5)) {
      // widget.onValueChanged(90);

      stateValue = 90;

      return 11.0;
    } else if ((angle > -2.5 && angle < -3) || (angle < 3 && angle > 2.5)) {
      stateValue = 180;

      return 0.0;
    } else {
      stateValue = 270;

      // widget.onValueChanged(270);
      return 33.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _defaultApp(context);
  }

  _defaultApp(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: widget.width,
                height: widget.height,
                margin: EdgeInsets.all(30.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    Offset centerOfGestureDetector = Offset(
                        constraints.maxWidth / 2, constraints.maxHeight / 2);
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        final touchPositionFromCenter =
                            details.localPosition - centerOfGestureDetector;
                        upsetAngle =
                            oldAngle - touchPositionFromCenter.direction;
                      },
                      onPanEnd: (details) {
                        setState(
                          () {
                            oldAngle = finalAngle;
                          },
                        );
                        widget.onValueChanged(stateValue);
                      },
                      onPanUpdate: (details) {
                        final touchPositionFromCenter =
                            details.localPosition - centerOfGestureDetector;

                        setState(
                          () {
                            finalAngle =
                                touchPositionFromCenter.direction + upsetAngle;
                            print(finalAngle);
                          },
                        );
                      },
                      child: Transform.rotate(
                          angle: convertToNearestAngle(finalAngle),
                          child:
                              Image.asset("assets/images/rotary_switch_1.png")),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
