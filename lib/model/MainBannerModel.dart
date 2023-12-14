class BannerModel {
  final String img;
  final String title;

  ///
  BannerModel({
    required this.img,
    required this.title,
  });
}

List<BannerModel> listOfBannerModel = [
  BannerModel(
    img: "assets/images/pan2.jpeg",
    title: "Dyness 5 kWh",
  ),
  BannerModel(
    img: "assets/images/pan1.jpeg",
    title: "Dyness 5 kWh",
  ),
  BannerModel(
    img: "assets/images/pc.jpeg",
    title: "Recomend Notebook",
  ),
];
