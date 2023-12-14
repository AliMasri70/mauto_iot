// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/model/tabBarWidgetModel.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

class DetailPageElement extends StatefulWidget {
  TabBarWidgetModel model;
  int index;
  DetailPageElement({Key? key, required this.model, required this.index})
      : super(key: key);
  @override
  State<DetailPageElement> createState() => _DetailPageElementState();
}

class _DetailPageElementState extends State<DetailPageElement> {
  String? imageSet;

  @override
  void initState() {
    imageSet = widget.model.img[0];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Hero(
                        tag: "heroimg${widget.index}",
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 375,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imageSet!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 60),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: OvalBorder(),
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(Icons.arrow_back)),
                                  ),
                                  SizedBox(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'Home / ${widget.model.title}',
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              height: 0.09,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: OvalBorder(),
                                    ),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.share,
                                            color: MainColor)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: OvalBorder(),
                                    ),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite,
                                            color: MainColor)),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 55,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.model.img.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          imageSet = widget.model.img[index];
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 60,
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                widget.model.img[index]),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 330,
                              // height: 100,
                              child: Text(
                                widget.model.title,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Color(0xFF333542),
                                  fontSize: 18,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  // height: 0.06,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  child: RatingBar.builder(
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    initialRating: widget.model.rate,
                                    glow: false,
                                    itemSize: 20,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Color(0xFFF9CC4A),
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '${widget.model.rate}',
                                  style: const TextStyle(
                                    color: Color(0xFFF9CC4A),
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '124 reviews',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFF9A9DB1),
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Center(
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: greyColor, size: 13),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 327,
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  color: Color(0xFF333542),
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          // width: 327,
                          child: Text(
                            widget.model.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: Color(0xFF757889),
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Spesification',
                              style: TextStyle(
                                color: Color(0xFF333542),
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 130,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 102,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 24,
                      offset: Offset(0, -4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 32,
                        height: 32,
                        decoration: ShapeDecoration(
                          color: Color(0xFFE2E3E8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Icon(Icons.remove, color: Colors.white)),
                    Text(
                      '1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF333542),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: Color(0xFF474A5C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                    Container(
                        width: 195,
                        height: 54,
                        decoration: ShapeDecoration(
                          color: Color(0xFF333542),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 141,
                              child: Center(
                                child: Text(
                                  '\$${widget.model.price}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    height: 0.09,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: 54,
                                height: 54,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF47495C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(18),
                                  child: SvgPicture.asset(
                                    'assets/images/cart.svg',
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
