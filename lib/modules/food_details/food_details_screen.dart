// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/modules/cart/cart_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Products product;
  FoodDetailsScreen({Key? key, required this.product}) : super(key: key);
  String? desc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        int price = product.price!;
        var snackBar = SnackBar(
          content: Text(
            'Added To Cart',
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          backgroundColor: AppColors.mainColor,
        );
        var errorSnackBar = SnackBar(
          content: Text(
            'Quantity must be more than 0',
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          backgroundColor: Colors.redAccent,
        );
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 250.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "http://mvs.bslmeiyu.com/uploads/${product.img}"),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                right: 20.w,
                top: 35.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AppIcon(
                        iconData: Icons.arrow_back,
                        iconSize: 25.sm,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        AppCubit.get(context).setTotalPrice();
                        navigateTo(context, CartScreen());
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          AppIcon(
                            iconData: Icons.shopping_cart_outlined,
                            iconSize: 25.sm,
                          ),
                          Container(
                            width: 15.w,
                            height: 15.w,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SmallText(
                                text:
                                    "${AppCubit.get(context).carts.isNotEmpty ? AppCubit.get(context).carts.length : 0}",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 230.h,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 16.w,
                      left: 16.w,
                      top: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BigText(text: product.name!),
                            SizedBox(
                              width: 24.w,
                            ),
                            BigText(text: '\$ ${product.price!}'),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(
                                product.stars!,
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
                              text: '${product.stars}',
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
                          height: 4.h,
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
                        Divider(),
                        SizedBox(
                          height: 8.h,
                        ),
                        BigText(text: "Introduce"),
                        SizedBox(
                          height: 4.h,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child:
                                ExpandableText(text: '${product.description}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r),
              ),
            ),
            padding: EdgeInsets.only(
              left: 8.w,
              right: 8.w,
              top: 4.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 120.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppIconButton(
                        onPressed: () {
                          AppCubit.get(context).setQuantity(false);
                        },
                        iconData: Icons.remove,
                      ),
                      Text(
                        '${AppCubit.get(context).quantity}',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      AppIconButton(
                        onPressed: () {
                          AppCubit.get(context).setQuantity(true);
                        },
                        iconData: Icons.add,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    CartModel cart = CartModel(
                      id: product.id,
                      img: product.img,
                      name: product.name,
                      price: product.price,
                      quantity: AppCubit.get(context).quantity,
                      time: DateTime.now().toString(),
                    );
                    if (AppCubit.get(context).quantity == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                    } else {
                      AppCubit.get(context).addToCart(cart);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: BigText(
                      text:
                          "${(price * AppCubit.get(context).quantity)}\$ | Add To Cart",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
