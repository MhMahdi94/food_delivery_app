// ignore_for_file: prefer_const_constructors, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/modules/food_details/food_details_screen.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  PageController pageController = PageController(viewportFraction: 0.9);
  double _scaleFactor = 0.8;
  double _height = 220.h;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            AppCubit.get(context).getPopularProductModel();
            AppCubit.get(context).getRecommendedFood();
          },
          color: AppColors.mainColor,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
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
                    ConditionalBuilder(
                      condition: (AppCubit.get(context).productModel != null),
                      builder: (context) => Container(
                        height: 230.h,
                        width: 320.w,
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
                          itemBuilder: (context, index) => buildPageViewItem(
                            context,
                            index,
                            AppCubit.get(context)
                                .productModel!
                                .products![index],
                          ),
                          itemCount: AppCubit.get(context)
                              .productModel!
                              .products!
                              .length,
                        ),
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    if (AppCubit.get(context).productModel != null)
                      DotsIndicator(
                        dotsCount: AppCubit.get(context)
                                .productModel!
                                .products!
                                .isNotEmpty
                            ? AppCubit.get(context)
                                .productModel!
                                .products!
                                .length
                            : 1,
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
                        horizontal: 8.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(child: BigText(text: "Recommended")),
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
                      child: ConditionalBuilder(
                        condition:
                            (AppCubit.get(context).recommendedProductModel !=
                                null),
                        builder: (context) => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return buildRecommendedProductItem(
                                context,
                                AppCubit.get(context)
                                    .recommendedProductModel!
                                    .products![index]);
                          },
                          itemCount: AppCubit.get(context)
                              .recommendedProductModel!
                              .products!
                              .length,
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildPageViewItem(context, int index, Products model) {
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
      child: InkWell(
        onTap: () {
          AppCubit.get(context).initProduct();
          navigateTo(
              context,
              FoodDetailsScreen(
                product: model,
              ));
        },
        child: Stack(
          children: [
            Container(
              height: 220,
              margin: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: NetworkImage(
                      "http://192.168.43.7:8000/uploads/${model.img}"),
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
                      BigText(text: "${model.name}"),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                              model.stars!,
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
                            text: "${model.stars}",
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
      ),
    );
  }

  Widget buildRecommendedProductItem(context, Products model) {
    return InkWell(
      onTap: () {
        AppCubit.get(context).initProduct();
        navigateTo(
          context,
          FoodDetailsScreen(product: model),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: NetworkImage(
                      "http://192.168.43.7:8000/uploads/${model.img}"),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BigText(text: model.name!),
                      SmallText(
                        text: '\$ ${model.price}',
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
      ),
    );
  }
}
