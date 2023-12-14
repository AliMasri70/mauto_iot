import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.isFocused,
      required this.iconColor,
      required this.hint,
      required this.controller,
      preIcon});

  final bool isFocused;
  final Color iconColor;
  String hint;
  TextEditingController controller;
  Icon? preIcon;
  @override
  Widget build(BuildContext context) {
    return MaterialTextField(
        keyboardType: TextInputType.emailAddress,
        hint: hint,
        textInputAction: TextInputAction.next,
        prefixIcon: preIcon,
        style: TextStyle(fontFamily: 'Poppins'),
        controller: controller,
        validator: FormValidation.emailTextField,
        theme: BorderlessTextTheme(
          hintStyle: const TextStyle(fontFamily: 'Poppins'),
          errorStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          prefixIconColor: iconColor,
          enabledColor: Colors.grey,
          focusedColor: MainColor,
          floatingLabelStyle:
              const TextStyle(color: MainColor, fontFamily: 'Poppins'),
          width: 1,
        ));
  }
}

class titleDivider extends StatelessWidget {
  const titleDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: const Divider()),
          Opacity(
              opacity: 0.60,
              child: defaultText(
                title: 'You can sign up with',
                fontSize: 13,
                TextFontFamily: FontWeight.w500,
                TextColor: titlegreyColor,
              )),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: const Divider()),
        ],
      ),
    );
  }
}
