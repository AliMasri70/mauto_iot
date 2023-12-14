import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:mauto_iot/SignUp/bottomSugnUp.dart';

import 'package:mauto_iot/SignUp/signupWidgets.dart';
import 'package:mauto_iot/signIn/BottomSignin.dart';
import 'package:mauto_iot/signIn/SocialLogin/SocialMain.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

class SignUpMainPage extends StatefulWidget {
  const SignUpMainPage({super.key});

  @override
  State<SignUpMainPage> createState() => _SignUpMainPageState();
}

class _SignUpMainPageState extends State<SignUpMainPage> {
  Color iconColor = Colors.grey;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  bool isFocused = false,
      isFocused2 = false,
      isFocused3 = false,
      isFocused4 = false,
      isFocused5 = false,
      isVisible = false,
      isVisible2 = false,
      isChecked = false,
      isError = false; // Track focus state
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController confPassController = new TextEditingController();
  @override
  void dispose() {
    focusNode.dispose(); // Don't forget to dispose the focus node.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Clear focus when tapping outside the TextField
            focusNode.unfocus();
            focusNode2.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: titlegreyColor,
                            fontSize: 30,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Let’s Get Started!!!',
                          style: TextStyle(
                            color: titlegreyColor,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Column(
                      children: [
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
                                child: CustomTextField(
                                    hint: "First Name",
                                    controller: firstNameController,
                                    isFocused: isFocused,
                                    iconColor: iconColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Focus(
                                onFocusChange: (value) {
                                  setState(() {
                                    isFocused2 = value;
                                  });
                                },
                                focusNode: focusNode,
                                child: CustomTextField(
                                    hint: "Last Name",
                                    controller: lastNameController,
                                    isFocused: isFocused2,
                                    iconColor: iconColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Focus(
                                onFocusChange: (value) {
                                  setState(() {
                                    isFocused3 = value;
                                  });
                                },
                                focusNode: focusNode,
                                child: CustomTextField(
                                    hint: "Email",
                                    controller: emailController,
                                    isFocused: isFocused3,
                                    iconColor: iconColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Focus(
                                onFocusChange: (value) {
                                  setState(() {
                                    isFocused2 = value;
                                  });
                                },
                                focusNode: focusNode2,
                                child: MaterialTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  hint: isError
                                      ? 'Password incorrect'
                                      : 'Password',
                                  textInputAction: TextInputAction.done,
                                  obscureText: isVisible,
                                  theme: BorderlessTextTheme(
                                    hintStyle:
                                        const TextStyle(fontFamily: 'Poppins'),
                                    errorStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    enabledColor: Colors.grey,
                                    focusedColor:
                                        isError ? errorColor : MainColor,
                                    floatingLabelStyle: TextStyle(
                                        color: isError ? errorColor : MainColor,
                                        fontFamily: 'Poppins'),
                                    width: 1,
                                  ),

                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    child: Icon(
                                      isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: isError
                                          ? errorColor
                                          : isFocused2
                                              ? MainColor
                                              : greyColor,
                                    ),
                                  ),
                                  //  controller: _passwordTextController,
                                  validator: FormValidation.requiredTextField,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Focus(
                                onFocusChange: (value) {
                                  setState(() {
                                    isFocused2 = value;
                                  });
                                },
                                focusNode: focusNode2,
                                child: MaterialTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  hint: isError
                                      ? 'Password incorrect'
                                      : 'Confirm Password',
                                  textInputAction: TextInputAction.done,
                                  obscureText: isVisible2,
                                  theme: BorderlessTextTheme(
                                    hintStyle:
                                        const TextStyle(fontFamily: 'Poppins'),
                                    errorStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    enabledColor: Colors.grey,
                                    focusedColor:
                                        isError ? errorColor : MainColor,
                                    floatingLabelStyle: TextStyle(
                                        color: isError ? errorColor : MainColor,
                                        fontFamily: 'Poppins'),
                                    width: 1,
                                  ),

                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isVisible2 = !isVisible2;
                                      });
                                    },
                                    child: Icon(
                                      isVisible2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: isError
                                          ? errorColor
                                          : isFocused2
                                              ? MainColor
                                              : greyColor,
                                    ),
                                  ),
                                  //  controller: _passwordTextController,
                                  validator: FormValidation.requiredTextField,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        titleDivider(),
                        const SizedBox(
                          height: 20,
                        ),
                        const SocialMain(),
                      ],
                    )
                  ],
                ),
                const BottomSignUp()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
