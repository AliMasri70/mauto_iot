import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mauto_iot/model/SliderListModel.dart';
import 'package:mauto_iot/onBoarding/sliders/pageone_firstPart.dart';
import 'package:mauto_iot/onBoarding/sliders/pageone_secondPart.dart';
import 'package:mauto_iot/onBoarding/sliders/sliderWidgets/sliderDots.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:provider/provider.dart';

class SliderMain extends StatefulWidget {
  const SliderMain({super.key});

  @override
  State<SliderMain> createState() => _SliderMainState();
}

class _SliderMainState extends State<SliderMain> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget animationDo(
    int index,
    int delay,
    Widget child,
  ) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    pageController = context.watch<PageController>();
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.7,
          child: PageView.builder(
            controller: pageController,
            itemCount: listOfItems.length,
            onPageChanged: (newIndex) {
              setState(() {
                currentIndex = newIndex;
              });
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  /// IMG

                  Container(
                      margin: const EdgeInsets.only(left: 28, right: 28),
                      child: PageOneFirst(images: listOfItems[index].img)),
                  const SizedBox(
                    height: 40,
                  ),
                  // /// SUBTITLE TEXT
                  animationDo(
                      index,
                      500,
                      Center(
                        child: PageoneSecondPart(
                          title: listOfItems[index].title,
                          subtitle: listOfItems[index].subTitle,
                          subtitle2: listOfItems[index].subTitle2,
                        ),
                      )),
                ],
              );
            }),
          ),
        ),

        /// ---------------------------

        // const SizedBox(height: 32),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.12,
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              currentIndex == 0
                  ? const greenDot()
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastOutSlowIn);
                        });
                      },
                      child: const greyDot(),
                    ),
              currentIndex == 1
                  ? const greenDot()
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastOutSlowIn);
                        });
                      },
                      child: const greyDot(),
                    ),
              currentIndex == 2
                  ? const greenDot()
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.animateToPage(2,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastOutSlowIn);
                        });
                      },
                      child: const greyDot(),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
