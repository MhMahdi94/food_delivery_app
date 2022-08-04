// ignore_for_file: prefer_const_constructors, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/colors.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:food_delivery/shared/dimensions.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  PageController pageController = PageController(viewportFraction: 0.9);
  double _scaleFactor = 0.8;
  double _height = 220.h;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        BigText(
                          text: "Country",
                          color: AppColors.mainColor,
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "City",
                              color: AppColors.textColor,
                              fontSize: 12.sp,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 320,
                    //color: Colors.red,
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: pageController,
                      onPageChanged: (value) {
                        //  print(AppCubit.get(context).currentPageValue);
                        pageController.addListener(() {
                          AppCubit.get(context)
                              .changePageValue(value.toDouble());
                        });
                      },
                      itemBuilder: (context, index) =>
                          buildPageViewItem(context, index),
                      itemCount: 5,
                    ),
                  ),
                  DotsIndicator(
                    dotsCount: 5,
                    position:
                        AppCubit.get(context).currentPageValue!.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: AppColors.mainColor,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(child: BigText(text: "Popular")),
                        SizedBox(
                          width: 2.w,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          child: BigText(
                            text: ".",
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 2.h),
                          child: SmallText(
                            text: "Food Pairing",
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 900.h,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 100.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/food0.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        BigText(
                                            text:
                                                "Nutritions fruit meal in China"),
                                        SmallText(
                                          text: "With Chinese characteristics",
                                          color: AppColors.textColor,
                                        ),
                                        Row(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Expanded(
                                              child: IconTextWidget(
                                                iconData: Icons.circle,
                                                text: 'Normal',
                                                iconColor: AppColors.iconColor1,
                                                textColor: AppColors.textColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: IconTextWidget(
                                                iconData: Icons.location_pin,
                                                text: '1.7 Km',
                                                iconColor: AppColors.mainColor,
                                                textColor: AppColors.textColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: IconTextWidget(
                                                iconData: Icons.access_time,
                                                text: '32 min',
                                                iconColor: AppColors.iconColor2,
                                                textColor: AppColors.textColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildPageViewItem(context, int index) {
    double? _currentPageValue = AppCubit.get(context).currentPageValue;
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue!.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: 220,
            margin: EdgeInsets.only(
              left: 5.w,
              right: 5.w,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: AssetImage("assets/images/food0.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                bottom: 20.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 12.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Chinese Side"),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                              size: 15.sm,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        SmallText(
                          text: "4.5",
                          color: AppColors.textColor,
                        ),
                        SizedBox(
                          width: 32.w,
                        ),
                        SmallText(
                          text: "1258 comments",
                          color: AppColors.textColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Expanded(
                          child: IconTextWidget(
                            iconData: Icons.circle,
                            text: 'Normal',
                            iconColor: AppColors.iconColor1,
                            textColor: AppColors.textColor,
                          ),
                        ),
                        Expanded(
                          child: IconTextWidget(
                            iconData: Icons.location_pin,
                            text: '1.7 Km',
                            iconColor: AppColors.mainColor,
                            textColor: AppColors.textColor,
                          ),
                        ),
                        Expanded(
                          child: IconTextWidget(
                            iconData: Icons.access_time,
                            text: '32 min',
                            iconColor: AppColors.iconColor2,
                            textColor: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
