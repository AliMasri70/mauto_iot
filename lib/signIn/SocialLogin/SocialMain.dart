import 'package:flutter/material.dart';
import 'package:mauto_iot/signIn/SocialLogin/SocialWidget.dart';

class SocialMain extends StatelessWidget {
  const SocialMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SocialWidget(
          image: "assets/images/googleicon.png",
          title: "Google",
        ),
        SizedBox(
          width: 20,
        ),
        SocialWidget(
          image: "assets/images/facebook.png",
          title: "Facebook",
        ),
      ],
    );
  }
}
