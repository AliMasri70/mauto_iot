// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/model/DrawerListModel.dart';

import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 55),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          height: 50,
                          'assets/images/user.svg',
                          // color: iconColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 58,
                        height: 22,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 58,
                              child: Text(
                                'Ryan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Circular Std',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listOfDrawerListModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListDrawerWidget(
                      title: listOfDrawerListModel[index].title,
                      icon: listOfDrawerListModel[index].icon,
                      onPressed: listOfDrawerListModel[index].onPressed,
                    );
                  }),
            ),
            Container(
              width: 263,
              height: 45,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                child: SizedBox(
                  width: 84,
                  child: Text(
                    'Sign out',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      height: 0,
                      letterSpacing: -0.14,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
