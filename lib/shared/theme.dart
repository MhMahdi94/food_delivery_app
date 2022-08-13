// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/constants/colors.dart';

//Light Theme
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[50],
  fontFamily: 'Metropolis',
  primaryColor: AppColors.mainColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: AppColors.mainColor,
    unselectedItemColor: AppColors.paraColor,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.grey[50],
    elevation: 0,
    actionsIconTheme: IconThemeData(
      color: AppColors.mainColor,
      size: 32.sm,
    ),
    titleTextStyle: TextStyle(
      fontSize: 24.sp,
      color: AppColors.mainColor,
      fontWeight: FontWeight.w400,
    ),
    titleSpacing: 8.w,
  ),
);

//Dark Theme
ThemeData darkTheme = ThemeData();
