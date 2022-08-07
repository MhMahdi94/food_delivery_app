// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery/shared/constants/colors.dart';

//Light Theme
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[50],
  fontFamily: 'Manrope',
  primaryColor: AppColors.mainColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: AppColors.mainColor,
    unselectedItemColor: AppColors.paraColor,
  ),
);

//Dark Theme
ThemeData darkTheme = ThemeData();
