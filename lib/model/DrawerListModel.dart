import 'package:flutter/material.dart';

class DrawerListModel {
  final String title;
  final IconData icon;
  Function onPressed;

  ///
  DrawerListModel({
    required this.icon,
    required this.title,
    required this.onPressed,
  });
}

List<DrawerListModel> listOfDrawerListModel = [
  DrawerListModel(icon: Icons.home, title: "Home", onPressed: () {}),
  DrawerListModel(
      icon: Icons.public_rounded, title: "Search", onPressed: () {}),
  DrawerListModel(
      icon: Icons.compare_arrows, title: "Transaction", onPressed: () {}),
  DrawerListModel(
      icon: Icons.settings_rounded, title: "Settings", onPressed: () {}),
  DrawerListModel(
      icon: Icons.speed_rounded, title: "iOT dashboard", onPressed: () {}),
  DrawerListModel(
      icon: Icons.flag_rounded, title: "Terms of Service", onPressed: () {}),
  DrawerListModel(
      icon: Icons.info_rounded, title: "About App", onPressed: () {}),
];
