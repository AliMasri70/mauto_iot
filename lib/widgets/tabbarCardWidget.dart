import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mauto_iot/utils/colorsApp.dart';

class TabBarCardWidget extends StatefulWidget {
  final String img;
  final String title;
  final double price;
  final double rate;
  final bool fav;

  const TabBarCardWidget(
      {super.key,
      required this.img,
      required this.title,
      required this.price,
      required this.rate,
      required this.fav});

  @override
  State<TabBarCardWidget> createState() => _TabBarCardWidgetState();
}

class _TabBarCardWidgetState extends State<TabBarCardWidget> {
  bool isFav = false;
  double rated = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    isFav = widget.fav;
    rated = widget.rate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, top: 12),
        // width: 327,
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 95,
              height: 95,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.img),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 201,
                          height: 52,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              color: Color(0xFF333542),
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              // height: 0.10,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isFav = !isFav;
                              });
                            },
                            icon: isFav
                                ? const Icon(
                                    Icons.favorite,
                                    color: MainColor,
                                  )
                                : const Icon(
                                    Icons.favorite_border_rounded,
                                    color: Color.fromARGB(255, 216, 216, 218),
                                  )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.price}',
                          style: const TextStyle(
                            color: Color(0xFFF9CC4A),
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: RatingBar.builder(
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                initialRating: rated,
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
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    rated = rating;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '$rated',
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
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
