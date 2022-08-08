// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/layout/app_layout.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  //splash screen
  late Animation<double> animation;
  late AnimationController animationController;

  void initSplashScreenAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..forward().then((value) => {navigateTo(context, AppLayout())});
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSplashScreenAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: animation,
                child: Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/app_logo.png',
                    ),
                    width: 150.w,
                    height: 150.h,
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              BigText(
                text: "The Food App",
                fontSize: 32.sp,
                color: AppColors.mainColor,
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
