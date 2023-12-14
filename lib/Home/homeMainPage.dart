import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/Drawer/drawer_screen.dart';
import 'package:mauto_iot/Home/homeElementDetail/detailsPageElement.dart';
import 'package:mauto_iot/model/MainBannerModel.dart';
import 'package:mauto_iot/model/tabBarWidgetModel.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/widgets/TabBar.dart';
import 'package:badges/badges.dart' as badges;

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  bool userInfoImg = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        height: 50,
                        'assets/images/user.svg',
                        // color: iconColor,
                      ),
                    ),
                    Row(
                      children: [
                        AnimSearchBar(
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                          textFieldColor: Colors.transparent,
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.52,
                          boxShadow: false,
                          textController: searchController,
                          onSuffixTap: () {
                            setState(() {
                              searchController.clear();
                            });
                          },
                          onSubmitted: (String) {},
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: badges.Badge(
                                badgeAnimation: badges.BadgeAnimation.scale(),
                                badgeStyle:
                                    badges.BadgeStyle(badgeColor: MainColor),
                                badgeContent: Text(
                                  '2',
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: SvgPicture.asset(
                                  height: 25,
                                  'assets/images/cart.svg',
                                  color: iconColor,
                                ))),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                            onTap: () => _key.currentState!.openDrawer(),
                            child: SvgPicture.asset(
                              height: 20,
                              'assets/images/menu.svg',
                              color: iconColor,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
                const Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hello,',
                            style: TextStyle(
                              color: Color(0xFF333542),
                              fontSize: 32,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: Color(0xFF333542),
                              fontSize: 32,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'Ryan!',
                            style: TextStyle(
                              color: Color(0xFF333542),
                              fontSize: 32,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  children: [
                    Text(
                      'Good morning, welcome back',
                      style: TextStyle(
                        color: Color(0xFF47495C),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listOfTabBarWidgetModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => DetailPageElement(
                                model: listOfTabBarWidgetModel[index],
                                index: index,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Hero(
                                    tag: "heroimg$index",
                                    child: Container(
                                      width: 260,
                                      height: 120,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              listOfTabBarWidgetModel[index]
                                                  .img[0]),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: 18,
                                      margin: const EdgeInsets.only(
                                          bottom: 15, left: 10),
                                      child: Text(
                                        listOfTabBarWidgetModel[index].title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          height: 0.08,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Brands',
                      style: TextStyle(
                        color: Color(0xFF333542),
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                    Text(
                      'See all',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFAEB0C0),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Container(
                              width: 120.56,
                              height: 62,
                              decoration: ShapeDecoration(
                                color: Color(0xFFF3F3F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Brand',
                                  style: TextStyle(
                                    color: Color(0xFF333542),
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: -0.72,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            )
                          ],
                        );
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: TabBarWidget()),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.8,
          shape: RoundedRectangleBorder(),
          backgroundColor: MainColor,
          child: DrawerScreen() // Populate the Drawer in the next step.
          ),
    );
  }
}
