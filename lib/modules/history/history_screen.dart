// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return SafeArea(
          child: ConditionalBuilder(
            condition: AppCubit.get(context).cartsHistory.isNotEmpty,
            builder: (context) => Padding(
              padding: EdgeInsets.all(16.sp),
              child: ListView.separated(
                itemBuilder: (context, index) => buildHistoryItem(
                  context,
                  AppCubit.get(context).cartsHistory[index],
                ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: AppCubit.get(context).cartsHistory.length,
              ),
            ),
            fallback: (context) => SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 64.h,
                    ),
                    Container(
                      width: 280.w,
                      height: 280.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/empty_box.png",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    BigText(
                      text: "Your History is Empty",
                      fontSize: 20.sp,
                      color: AppColors.signColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildHistoryItem(context, CartModel model) {
    var parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(model.time!);
    var dateParsed = DateTime.parse(parseDate.toString());
    var dateFormat = DateFormat('yMMMMd');
    var timeFormat = DateFormat('jms');
    var date = dateFormat.format(dateParsed);
    var time = timeFormat.format(dateParsed);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Image(
            image:
                NetworkImage('http://mvs.bslmeiyu.com/uploads/${model.img!}'),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
            ),
            BigText(
              text: '${model.name}',
            ),
            SmallText(
              text: '${date}     ${time}',
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  fontSize: 12.sp,
                  text: 'Quantity: ${model.quantity}',
                ),
                SizedBox(
                  width: 16.w,
                ),
                SmallText(
                  fontSize: 12.sp,
                  text: 'Price: \$ ${model.price}',
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ],
    );
  }
}
