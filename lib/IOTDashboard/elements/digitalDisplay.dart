import 'package:flutter/material.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

class LCDDigitalDisplay extends StatelessWidget {
  final String value;

  LCDDigitalDisplay({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black
            .withOpacity(0.8), // Background color for the LCD screen
        border:
            Border.all(color: Colors.greenAccent, width: 2.0), // Border color
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            color: MainColor, // Digit color
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
