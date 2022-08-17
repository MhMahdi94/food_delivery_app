// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/modules/auth/cubit/cubit.dart';
import 'package:food_delivery/modules/auth/cubit/states.dart';
import 'package:food_delivery/modules/auth/signin_screen.dart';
import 'package:food_delivery/modules/auth/signup_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: 812.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: 24.h,
                    left: 0,
                    right: 0,
                    child: Image(
                      height: 406.h,
                      width: 375.w,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/Subtraction2.png'),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      //width: double.infinity,
                      height: 382.h,
                      decoration: BoxDecoration(),
                      child: Image(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/images/shaped_subtraction.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      //width: double.infinity,
                      height: 382.h,
                      decoration: BoxDecoration(
                          //color: AppColors.mainColor,
                          ),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/mainBackground.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 20.h,
                    bottom: 0,
                    child: Center(
                      child: CircleAvatar(
                        radius: 100.r,
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage('assets/images/Logo.png'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 52.w,
                    right: 52.w,
                    top: 543.h,
                    bottom: 0,
                    child: Text(
                      'Discover the best foods from over 1000,\n restaurants and fast delivery to your doorstep',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.secondaryFontColor,
                        height: 1.5.h,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 34.w,
                    left: 34.w,
                    top: 637.h,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        AppButton(
                          label: 'Login',
                          onTap: () {
                            navigateTo(context, SignInScreen());
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        AppButton(
                          filled: false,
                          label: 'Create an Account',
                          onTap: () {
                            navigateTo(context, SignUpScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
