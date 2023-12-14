// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

class defaultText extends StatelessWidget {
  String title;
  double fontSize;
  Color TextColor;
  FontWeight TextFontFamily;
  defaultText({
    Key? key,
    required this.title,
    required this.fontSize,
    required this.TextColor,
    required this.TextFontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: TextColor,
        fontSize: fontSize,
        fontFamily: 'Poppins',
        fontWeight: TextFontFamily,
        height: 0,
      ),
    );
  }
}

class defaultDescText extends StatelessWidget {
  String title;
  double fontSize;
  Color TextColor;
  FontWeight TextFontFamily;
  defaultDescText({
    Key? key,
    required this.title,
    required this.fontSize,
    required this.TextColor,
    required this.TextFontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: TextColor,
        fontSize: fontSize,
        fontFamily: 'Poppins',
        fontWeight: TextFontFamily,
        height: 0,
      ),
    );
  }
}

class customMaterialWidgetTextField extends StatelessWidget {
  customMaterialWidgetTextField({
    super.key,
    required this.title,
    required this.isFocused,
    required this.iconColor,
    required this.iconprefix,
  });
  String title;
  bool isFocused;
  Color iconColor;
  IconData iconprefix;
  @override
  Widget build(BuildContext context) {
    return MaterialTextField(
        keyboardType: TextInputType.emailAddress,
        hint: title,
        textInputAction: TextInputAction.next,
        prefixIcon: Icon(
          iconprefix,
          color: isFocused ? MainColor : greyColor,
        ),
        style: TextStyle(fontFamily: 'Poppins'),
        //  controller: _emailTextController,
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

class ListDrawerWidget extends StatelessWidget {
  String title;
  IconData icon;
  Function onPressed;

  ListDrawerWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          iconColor: Colors.white,
          textColor: Colors.white,
          leading: Icon(icon),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: onPressed(),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Divider(color: Color(0xffEDEDED)),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class inputVariableTextField extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String TextLabel;
  final IconData icon;
  final TextInputType inputType;
  final double width;
  TextEditingController? controller;
  String? hint;
  bool validate;
  // ignore: non_constant_identifier_names
  inputVariableTextField(
      {super.key,
      required this.TextLabel,
      required this.icon,
      required this.inputType,
      required this.width,
      this.controller,
      this.hint,
      required this.validate});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * width!,
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
              errorText: validate ? "Field Can't Be Empty" : null,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  borderSide: BorderSide(color: Colors.teal)),
              // hintText: 'Tell us about yourself',
              labelText: TextLabel,
              hintText: hint,
              prefixIcon: Icon(
                icon,
                color: MainColor,
              ),
              prefixText: ' ',
              suffixStyle: const TextStyle(color: MainColor)),
        ),
      ),
    );
  }
}
