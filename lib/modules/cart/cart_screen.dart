// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:food_delivery/shared/network/local/cache_helper.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!AppCubit.get(context).isCartNav)
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AppIcon(
                        iconData: Icons.arrow_back,
                        backgroundColor: AppColors.mainColor,
                        iconSize: 25.sm,
                        iconColor: Colors.white,
                      ),
                    ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ConditionalBuilder(
                    condition: AppCubit.get(context).carts.isNotEmpty,
                    builder: (context) => Expanded(
                      child: ListView.builder(
                        itemCount: AppCubit.get(context).carts.isNotEmpty
                            ? AppCubit.get(context).carts.length
                            : 1,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCartItem(
                            AppCubit.get(context).carts[index], context),
                      ),
                    ),
                    fallback: (context) => Expanded(
                      child: Center(
                        child: BigText(
                          text: "Your Cart is Empty",
                          fontSize: 20.sp,
                          color: AppColors.signColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: BigText(
                    text: '\$ ${AppCubit.get(context).totalPrice}',
                  ),
                ),
                InkWell(
                  onTap: () {},
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
                      text: "CHECK OUT",
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

  Widget buildCartItem(CartModel model, context) => Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16.r,
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(
                image: NetworkImage(
                    'http://192.168.43.7:8000/uploads/${model.img}'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: '${model.name}',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: '\$ ${model.price! * model.quantity!}',
                      ),
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
                                AppCubit.get(context).setItemQuantity(
                                  false,
                                  itemQuantity: model.quantity,
                                  id: model.id,
                                );
                                AppCubit.get(context).setTotalPrice();
                              },
                              iconData: Icons.remove,
                            ),
                            Text(
                              '${model.quantity}',
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            AppIconButton(
                              onPressed: () {
                                AppCubit.get(context).setItemQuantity(
                                  true,
                                  itemQuantity: model.quantity,
                                  id: model.id,
                                );
                                AppCubit.get(context).setTotalPrice();
                              },
                              iconData: Icons.add,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
