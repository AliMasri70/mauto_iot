import 'package:flutter/material.dart';
import 'package:mauto_iot/model/tabBarWidgetModel.dart';
import 'package:mauto_iot/widgets/tabbarCardWidget.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarState();
}

class _TabBarState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          TabBar(
            isScrollable: true,
            dividerColor: Colors.transparent,
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Montserrat',
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              // first tab [you can add an icon using the icon property]
              Tab(
                text: 'For You',
              ),

              // second tab [you can add an icon using the icon property]
              Tab(
                text: 'New Gadget',
              ),
              Tab(
                text: 'Best Silling',
              ),
              Tab(
                text: 'Popular',
              ),
            ],
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget

                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listOfTabBarWidgetModel2.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TabBarCardWidget(
                              img: listOfTabBarWidgetModel2[index].img[0],
                              title: listOfTabBarWidgetModel2[index].title,
                              price: listOfTabBarWidgetModel2[index].price,
                              rate: listOfTabBarWidgetModel2[index].rate,
                              fav: listOfTabBarWidgetModel2[index].fav,
                            );
                          }),
                    ),
                  ],
                ),

                // second tab bar view widget
                Text(
                  'Buy Now',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Center(
                  child: Text(
                    'Place Bid',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    'Place Bid',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
