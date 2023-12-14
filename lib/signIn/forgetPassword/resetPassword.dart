import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';

import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:pinput/pinput.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isFocused = false;
  bool isFocused2 = false;
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
                          title: 'Reset Password',
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
                      title: 'Reset password',
                      fontSize: 20,
                      TextFontFamily: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultText(
                      TextColor: subtitlecolor,
                      title: 'Enter new password for your account',
                      fontSize: 14,
                      TextFontFamily: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    Focus(
                      onFocusChange: (value) {
                        setState(() {
                          isFocused = value;
                        });
                      },
                      child: customMaterialWidgetTextField(
                          title: 'New Password',
                          isFocused: isFocused,
                          iconColor: iconColor,
                          iconprefix: Icons.lock),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Focus(
                      onFocusChange: (value) {
                        setState(() {
                          isFocused2 = value;
                        });
                      },
                      child: customMaterialWidgetTextField(
                          title: 'Retype New Password',
                          isFocused: isFocused2,
                          iconColor: iconColor,
                          iconprefix: Icons.lock),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          "",
                          "reset",
                        );
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
                          title: 'Reset',
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
