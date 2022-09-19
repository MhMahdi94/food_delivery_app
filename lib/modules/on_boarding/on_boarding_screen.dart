// ignore_for_file: prefer_const_constructors

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/layout/app_layout.dart';
import 'package:food_delivery/modules/home/home_screen.dart';
import 'package:food_delivery/modules/main/main_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/constants/constants.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:food_delivery/shared/network/local/cache_helper.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  List<String> onboardTitles = [
    'Find Food You Love',
    'Fast Delivery',
    'Live Tracking',
  ];

  List<String> onboardSubTitles = [
    'Discover the best foods from over 1,000\n restaurants and fast delivery to your doorstep',
    'Fast food delivery to your home, office\n wherever you are',
    'Real time tracking of your food on the app\n once you placed the order',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 112.h,
                ),
                Container(
                  height: 300.h,
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Image(
                          image: AssetImage(
                            AppCubit.get(context)
                                .onboardImages[AppCubit.get(context).pageIndex],
                          ),
                          width: 225.w,
                          height: 295.h,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    onPageChanged: (value) {
                      AppCubit.get(context).changeOnBoardingPageValue(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                DotsIndicator(
                  dotsCount: AppCubit.get(context).onboardImages.length,
                  position: AppCubit.get(context).pageIndex.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.mainColor,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Center(
                  child: BigText(
                    text: onboardTitles[AppCubit.get(context).pageIndex],
                    fontSize: 30.sp,
                    color: AppColors.mainFontColor,
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  onboardSubTitles[AppCubit.get(context).pageIndex],
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.secondaryFontColor,
                    height: 1.5.h,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40.h,
                ),
                AppButton(
                  label: 'Next',
                  onTap: () {
                    if (AppCubit.get(context).pageIndex == 2) {
                      CacheHelper.putBoolean(key: 'onBoard', value: true);
                      token = CacheHelper.getData(key: 'token') ?? '';
                      if (token == '') {
                        navigateToWithReplacement(
                          context,
                          MainScreen(),
                        );
                      } else {
                        navigateToWithReplacement(context, AppLayout());
                      }
                    } else {
                      AppCubit.get(context).changeOnBoardingPageValue(
                          AppCubit.get(context).pageIndex + 1);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
