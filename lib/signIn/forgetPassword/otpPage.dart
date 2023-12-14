import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool isFocused = false;
  FocusNode focusNode = FocusNode();
  TextEditingController numberController = new TextEditingController();
  Color iconColor = Colors.grey;
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(30, 60, 87, 1);

    final defaultPinTheme =
        PinTheme(width: 65, height: 65, textStyle: TextStyle(fontSize: 20));

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: MainColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Clear focus when tapping outside the TextField
            focusNode.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        defaultText(
                          title: 'Forgot password',
                          fontSize: 30,
                          TextFontFamily: FontWeight.bold,
                          TextColor: titlegreyColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 120,
                    ),
                    defaultText(
                      TextColor: titlegreyColor,
                      title: 'Enter OTP',
                      fontSize: 20,
                      TextFontFamily: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultText(
                      TextColor: subtitlecolor,
                      title:
                          'Enter the 4 digit OTP received on you\nregistered phone number',
                      fontSize: 14,
                      TextFontFamily: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Pinput(
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.smsUserConsentApi,
                              listenForMultipleSmsOnAndroid: true,
                              separatorBuilder: (index) =>
                                  const SizedBox(width: 8),
                              validator: (value) {
                                return value == '2222'
                                    ? null
                                    : 'Pin is incorrect';
                              },
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              onCompleted: (pin) {
                                debugPrint('onCompleted: $pin');
                              },
                              onChanged: (value) {
                                debugPrint('onChanged: $value');
                              },
                              length: 4,
                              pinAnimationType: PinAnimationType.slide,
                              controller: pinController,
                              focusNode: focusNode,
                              defaultPinTheme: defaultPinTheme,
                              showCursor: true,
                              cursor: cursor,
                              preFilledWidget: preFilledWidget,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultText(
                            title: "Resend OTP",
                            fontSize: 18,
                            TextColor: MainColor,
                            TextFontFamily: FontWeight.bold)
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          "",
                          "Send OTP ",
                        );
                        Get.toNamed('/resetPass');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 45,
                        decoration: ShapeDecoration(
                          color: MainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Center(
                            child: defaultText(
                          title: 'Submit',
                          TextColor: Colors.white,
                          fontSize: 19,
                          TextFontFamily: FontWeight.bold,
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
