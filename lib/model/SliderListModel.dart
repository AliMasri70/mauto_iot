class Items {
  final String img;
  final String title;
  final String subTitle;
  final String subTitle2;

  ///
  Items(
      {required this.img,
      required this.title,
      required this.subTitle,
      required this.subTitle2});
}

List<Items> listOfItems = [
  Items(
    img: "assets/images/onBoarding1.png",
    title: "Harnessing solar energy",
    subTitle: "Harnessing the Power of the Sun: Solar Panel ",
    subTitle2: "Technology Explained",
  ),
  Items(
    img: "assets/images/onBoarding2.png",
    title: "Panels For Sustainable Living",
    subTitle: "Solar Panels Made Simple: A Guide to ",
    subTitle2: "Renewable Energy",
  ),
  Items(
    img: "assets/images/onBoarding3.png",
    title: "Clean Energy With Solar Panel",
    subTitle: "Going Green with Solar Panels: Benefits and ",
    subTitle2: "Installation Tips",
  ),
];
