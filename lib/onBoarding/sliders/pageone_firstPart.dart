// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

// ignore: must_be_immutable
class PageOneFirst extends StatelessWidget {
  PageOneFirst({
    super.key,
    required this.images,
  });
  String images;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.45,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: sliderImagecolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 25),
            width: 300,
            height: 500,
            child: Stack(
              children: [
                Container(
                  width: 400,
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
