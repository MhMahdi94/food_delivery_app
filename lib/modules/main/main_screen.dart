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
import 'package:shadow_clip/shadow_clip.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width.w,
              height: MediaQuery.of(context).size.height.h,
              child: Stack(
                children: [
                  //top
                  Align(
                    alignment: Alignment.topCenter,
                    child: ClipShadow(
                      clipper: CustomClipperAppBar(),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.placeHodlderColor,
                          offset: Offset(0, 15),
                          blurRadius: 10,
                        ),
                      ],
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5.h,
                        decoration: ShapeDecoration(
                          color: AppColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.r,
                            ),
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/mainBackground.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //logo
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/Logo.png'),
                  ),

                  //desc
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3.h,
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Column(
                        children: [
                          Text(
                            'Discover the best foods from over 1000,\n restaurants and fast delivery to your doorstep',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.secondaryFontColor,
                              height: 1.5.h,
                            ),
                          ),
                          Spacer(),
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
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 812.h,
            //   width: double.infinity,
            //   child: Stack(
            //     children: [
            //       Positioned(
            //         top: 24.h,
            //         left: 0,
            //         right: 0,
            //         child: Image(
            //           height: 406.h,
            //           width: 375.w,
            //           fit: BoxFit.cover,
            //           image: AssetImage('assets/images/Subtraction2.png'),
            //         ),
            //       ),
            //       Positioned(
            //         top: 0,
            //         left: 0,
            //         right: 0,
            //         child: Container(
            //           //width: double.infinity,
            //           height: 382.h,
            //           decoration: BoxDecoration(),
            //           child: Image(
            //             fit: BoxFit.cover,
            //             image:
            //                 AssetImage('assets/images/shaped_subtraction.png'),
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         left: 0,
            //         right: 0,
            //         child: Container(
            //           //width: double.infinity,
            //           height: 382.h,
            //           decoration: BoxDecoration(
            //               //color: AppColors.mainColor,
            //               ),
            //           child: Image(
            //             fit: BoxFit.cover,
            //             image: AssetImage('assets/images/mainBackground.png'),
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         left: 0,
            //         right: 0,
            //         top: 20.h,
            //         bottom: 0,
            //         child: Center(
            //           child: CircleAvatar(
            //             radius: 100.r,
            //             backgroundColor: Colors.transparent,
            //             child: Image(
            //               image: AssetImage('assets/images/Logo.png'),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         left: 52.w,
            //         right: 52.w,
            //         top: 543.h,
            //         bottom: 0,
            //         child: Text(
            //           'Discover the best foods from over 1000,\n restaurants and fast delivery to your doorstep',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 13.sp,
            //             color: AppColors.secondaryFontColor,
            //             height: 1.5.h,
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         right: 34.w,
            //         left: 34.w,
            //         top: 637.h,
            //         child: Column(
            //           // ignore: prefer_const_literals_to_create_immutables
            //           children: [
            //             AppButton(
            //               label: 'Login',
            //               onTap: () {
            //                 navigateTo(context, SignInScreen());
            //               },
            //             ),
            //             SizedBox(
            //               height: 16.h,
            //             ),
            //             AppButton(
            //               filled: false,
            //               label: 'Create an Account',
            //               onTap: () {
            //                 navigateTo(context, SignUpScreen());
            //               },
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width * 0.24, size.height);
    Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
    Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.78);
    Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.78);
    Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.78);
    Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
    Offset controlPoint4 = Offset(size.width * 0.76, size.height);
    Offset endPoint4 = Offset(size.width * 0.79, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReClip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
