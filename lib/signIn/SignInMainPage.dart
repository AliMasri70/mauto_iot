import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:mauto_iot/signIn/BottomSignin.dart';
import 'package:mauto_iot/signIn/SocialLogin/SocialMain.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';

class SignInMainPage extends StatefulWidget {
  const SignInMainPage({super.key});

  @override
  State<SignInMainPage> createState() => _SignInMainPageState();
}

class _SignInMainPageState extends State<SignInMainPage> {
  Color iconColor = Colors.grey;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  bool isFocused = false,
      isFocused2 = false,
      isVisible = false,
      isChecked = false,
      isError = false; // Track focus state

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
                          'Welcome Back',
                          style: TextStyle(
                            color: Color(0xFF3D3D3D),
                            fontSize: 30,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFF3D3D3D),
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
                                child: MaterialTextField(
                                    keyboardType: TextInputType.emailAddress,
                                    hint: 'Enter your Email',
                                    textInputAction: TextInputAction.next,
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: isFocused ? MainColor : greyColor,
                                    ),
                                    style: TextStyle(fontFamily: 'Poppins'),
                                    //  controller: _emailTextController,
                                    validator: FormValidation.emailTextField,
                                    theme: BorderlessTextTheme(
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      errorStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                      prefixIconColor: iconColor,
                                      enabledColor: Colors.grey,
                                      focusedColor: MainColor,
                                      floatingLabelStyle: const TextStyle(
                                          color: MainColor,
                                          fontFamily: 'Poppins'),
                                      width: 1,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
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
                                  prefixIcon: isError
                                      ? const Icon(Icons.close,
                                          color: errorColor)
                                      : Icon(
                                          Icons.lock,
                                          color: isFocused2
                                              ? MainColor
                                              : greyColor,
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
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 30.0,
                                  width: 30,
                                  child: Checkbox(
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                          width: 1.0,
                                          color: isChecked
                                              ? MainColor
                                              : greyColor),
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
                                          title: 'Keep me Signed In',
                                          TextColor: keepSignedColor,
                                          fontSize: 15,
                                          TextFontFamily: FontWeight.w400)),
                                )
                              ],
                            ),
                         
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed("/ForgetPassPage");
                                },
                                child: defaultText(
                                    title: 'Forgot password?',
                                    TextColor: darkGreenMain,
                                    fontSize: 16,
                                    TextFontFamily: FontWeight.w400))
                          ],
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        const SocialMain(),
                      ],
                    )
                  ],
                ),
                const BottomSignIn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
