// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:food_delivery/shared/network/local/cache_helper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getPopularProductModel()
        ..getRecommendedFood()
        ..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppCubit.get(context)
                    .titles[AppCubit.get(context).currentIndex],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search_outlined),
                )
              ],
            ),
            body: AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex],
            bottomNavigationBar: MotionTabBar(
              initialSelectedTab: "Home",
              labels: const ["Home", "History", "Cart", "Profile"],
              icons: const [
                Icons.home_outlined,
                Icons.history_outlined,
                Icons.shopping_cart_outlined,
                Icons.person_outline
              ],

              // optional badges, length must be same with labels
              badges: [
                // Default Motion Badge Widget
                null,

                // custom badge Widget

                // allow null
                null,
                Container(
                  width: 15.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: AppColors.iconColor2,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${AppCubit.get(context).carts.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Default Motion Badge Widget with indicator only
                null,
              ],

              tabSize: 50,
              tabBarHeight: 55,
              textStyle: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              tabIconColor: AppColors.paraColor,
              tabIconSize: 28.sm,
              tabIconSelectedSize: 26.sm,
              tabSelectedColor: AppColors.mainColor,
              tabIconSelectedColor: Colors.white,
              tabBarColor: AppColors.buttonBackgroundColor,
              onTabItemSelected: (int value) {
                AppCubit.get(context).changeBottomTabIndex(value);
              },
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
