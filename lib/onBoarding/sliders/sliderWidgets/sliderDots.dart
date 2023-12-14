import 'package:flutter/material.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

class greenDot extends StatelessWidget {
  const greenDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: Stack(
        children: [
          Positioned(
            left: 4,
            top: 4,
            child: Container(
              width: 6,
              height: 6,
              decoration: const ShapeDecoration(
                color: MainColor,
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: MainColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class greyDot extends StatelessWidget {
  const greyDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const ShapeDecoration(
        color: greyColor,
        shape: OvalBorder(),
      ),
    );
  }
}
