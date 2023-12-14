import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/onBoarding/sliders/SliderMain.dart';
import 'package:mauto_iot/onBoarding/sliders/pageone_firstPart.dart';
import 'package:mauto_iot/onBoarding/sliders/pageone_secondPart.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    final pageController = context.watch<PageController>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Logo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0.08,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: tealColor,
                  textStyle: const TextStyle(
                    color: MainColor,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.08,
                  ),
                ),
                onPressed: () {
                  pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                child: const Center(
                    child: Text(
                  'Skip',
                  textAlign: TextAlign.center,
                )),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
              width: size.width,
              height: size.height * 0.75,
              child: const SliderMain()),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print("sign in");
                    Get.offNamed("/signinPage");
                  },
                  child: Container(
                    height: 56,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 57, vertical: 0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFF49D7A8)),
                        borderRadius: BorderRadius.circular(56),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF49D7A8),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            height: 0.10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Get.offNamed("/SignUpPage");
                  },
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 37, vertical: 18),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF49D7A8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(56),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Create Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            height: 0.10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
