import 'package:flutter/material.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/elementsWidgets.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

class ElementCardSelectWidget extends StatelessWidget {
  final String img;
  final String title;

  const ElementCardSelectWidget(
      {super.key, required this.img, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.only(bottom: 8, top: 12),
      height: 100,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A1C232F),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 95,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF333542),
              fontSize: 17,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              // height: 0.10,
            ),
          ),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(right: 17),
              child: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    ));
  }
}

class NeumorphicElementWidget extends StatelessWidget {
  final String img;
  final String title;

  const NeumorphicElementWidget(
      {super.key, required this.img, required this.title});

  @override
  Widget build(BuildContext context) {
    final sizeSc = MediaQuery.of(context).size.height * 0.17;
    return Center(
        child: Container(
      margin: const EdgeInsets.only(bottom: 8, top: 12),
      height: sizeSc,
      width: sizeSc,
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            depth: 15,
            lightSource: LightSource.topLeft,
            color: Color.fromARGB(255, 255, 255, 255)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 95,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(img),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF333542),
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  // height: 0.10,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class VariableCardSelectWidget1 extends StatelessWidget {
  final String sub;
  final String title;
  final String topicType;
  final String topicTitle;
  final String value;

  const VariableCardSelectWidget1(
      {super.key,
      required this.sub,
      required this.title,
      required this.topicType,
      required this.topicTitle,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
          child: Container(
        margin: const EdgeInsets.only(bottom: 8, top: 12),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 100,
        decoration: ShapeDecoration(
          color: Color.fromARGB(255, 226, 226, 226),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A1C232F),
              blurRadius: 16,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    // height: 0.10,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(
                    color: Color(0xFF333542),
                    fontSize: 13,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    // height: 0.10,
                  ),
                ),
                if (sub == 'Cloud/Device')
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "$topicType : ",
                            style: const TextStyle(
                              color: Color(0xFF333542),
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              // height: 0.10,
                            ),
                          ),
                          Text(
                            topicTitle,
                            style: const TextStyle(
                              color: Color(0xFF333542),
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              // height: 0.10,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Value : ",
                            style: TextStyle(
                              color: Color(0xFF333542),
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              // height: 0.10,
                            ),
                          ),
                          Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFF333542),
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              // height: 0.10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(right: 17),
                child: const Icon(Icons.edit, color: MainColor))
          ],
        ),
      )),
    );
  }
}

class VariableCardSelectWidget extends StatelessWidget {
  final String sub;
  final String title;

  const VariableCardSelectWidget({
    super.key,
    required this.sub,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
          child: Container(
        margin: const EdgeInsets.only(bottom: 8, top: 12),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 100,
        decoration: ShapeDecoration(
          color: Color.fromARGB(255, 226, 226, 226),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A1C232F),
              blurRadius: 16,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    // height: 0.10,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(
                    color: Color(0xFF333542),
                    fontSize: 13,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w200,
                    // height: 0.10,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(right: 17),
                child: const Icon(Icons.edit, color: MainColor))
          ],
        ),
      )),
    );
  }
}

class GeneralCardSelectWidget extends StatelessWidget {
  final String sub;
  final String title;

  const GeneralCardSelectWidget(
      {super.key, required this.sub, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
          child: Container(
        margin: const EdgeInsets.only(bottom: 8, top: 12),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 100,
        decoration: ShapeDecoration(
          color: Color.fromARGB(255, 226, 226, 226),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A1C232F),
              blurRadius: 16,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    // height: 0.10,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(
                    color: Color(0xFF333542),
                    fontSize: 13,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w200,
                    // height: 0.10,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(right: 17),
                child: const Icon(Icons.arrow_forward_ios, color: MainColor))
          ],
        ),
      )),
    );
  }
}

class GeneralCardSelectWidget1 extends StatelessWidget {
  final String sub;
  final IconData icondata;

  const GeneralCardSelectWidget1(
      {super.key, required this.sub, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
          child: Container(
        margin: const EdgeInsets.only(bottom: 8, top: 12),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 100,
        decoration: ShapeDecoration(
          color: Color.fromARGB(255, 226, 226, 226),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A1C232F),
              blurRadius: 16,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Icon(
              icondata,
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
              sub,
              style: const TextStyle(
                color: Color(0xFF333542),
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                // height: 0.10,
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class DividerScreen extends StatelessWidget {
  final String title;
  final double size;

  const DividerScreen({super.key, required this.title, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * ((0.85 - size) / 2),
            child: const Divider()),
        Opacity(
            opacity: 0.60,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * size,
              child: defaultText(
                title: title,
                fontSize: 16,
                TextFontFamily: FontWeight.w500,
                TextColor: titlegreyColor,
              ),
            )),
        SizedBox(
            width: MediaQuery.of(context).size.width * ((0.85 - size) / 2),
            child: const Divider()),
      ],
    );
  }
}
