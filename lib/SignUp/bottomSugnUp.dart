import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';

class BottomSignUp extends StatelessWidget {
  const BottomSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      "",
                      "Sign Up ",
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: MainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                        child: defaultText(
                      title: 'Sign Up',
                      TextColor: Colors.white,
                      fontSize: 19,
                      TextFontFamily: FontWeight.bold,
                    )),
                  ),
                ),
              ],
            ),
           
            const SizedBox(
              height: 17,
            ),
            Row(
              children: [
                Opacity(
                  opacity: 0.70,
                  child: defaultText(
                      title: 'Already have an account',
                      fontSize: 13,
                      TextColor: Color(0xFF3D3D3D),
                      TextFontFamily: FontWeight.w400),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offNamed("/signinPage");
                  },
                  child: defaultText(
                      title: 'Sign In',
                      fontSize: 15,
                      TextColor: Color(0xFF196371),
                      TextFontFamily: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
