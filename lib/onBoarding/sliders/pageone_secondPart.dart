// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

// ignore: must_be_immutable
class PageoneSecondPart extends StatelessWidget {
  String title, subtitle, subtitle2;
  PageoneSecondPart({
    super.key,
    required this.title,
    required this.subtitle,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      height: 0.06,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 318,
                  child: Text(
                    '$subtitle ',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textGreyColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 318,
                  child: Text(
                    subtitle2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textGreyColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
