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
            bottomNavigationBar: BottomNavigationBar(
              elevation: 10,
              type: BottomNavigationBarType.fixed,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history_outlined,
                  ),
                  label: "History",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                  ),
                  label: "Profile",
                ),
              ],
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (int value) {
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
