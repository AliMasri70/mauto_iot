import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:mauto_iot/SignUp/signupWidgets.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  bool isFocused = false;
  FocusNode focusNode = FocusNode();
  TextEditingController numberController = new TextEditingController();
  Color iconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
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
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/forgetPass.png",
                          height: MediaQuery.of(context).size.height * 0.15,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultText(
                      TextColor: titlegreyColor,
                      title: 'Forgot password?',
                      fontSize: 20,
                      TextFontFamily: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultText(
                      TextColor: titlegreyColor,
                      title: 'No Problem',
                      fontSize: 14,
                      TextFontFamily: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultText(
                      TextColor: subtitlecolor,
                      title:
                          'Enter your phone number and we’ll send\na OTP to reset your password',
                      fontSize: 14,
                      TextFontFamily: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Focus(
                            onFocusChange: (value) {
                              setState(() {
                                isFocused = value;
                              });
                            },
                            focusNode: focusNode,
                            child: MaterialTextField(
                                keyboardType: TextInputType.phone,
                                hint: "Phone Number",
                                textInputAction: TextInputAction.next,
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: isFocused ? MainColor : greyColor,
                                ),
                                style: const TextStyle(fontFamily: 'Poppins'),
                                controller: numberController,
                                validator: FormValidation.emailTextField,
                                theme: BorderlessTextTheme(
                                  hintStyle:
                                      const TextStyle(fontFamily: 'Poppins'),
                                  errorStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  prefixIconColor: iconColor,
                                  enabledColor: Colors.grey,
                                  focusedColor: MainColor,
                                  floatingLabelStyle: const TextStyle(
                                      color: MainColor, fontFamily: 'Poppins'),
                                  width: 1,
                                )),
                          ),
                        ),
                      ],
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
                          "Send OTP ",
                        );
                        Get.toNamed('/otpPage');
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
                          title: 'Send OTP',
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
