// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery/modules/food_details/food_details_screen.dart';
import 'package:food_delivery/modules/home/home_screen.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodDetailsScreen(), //SafeArea(child: HomeScreen()),
    );
  }
}
