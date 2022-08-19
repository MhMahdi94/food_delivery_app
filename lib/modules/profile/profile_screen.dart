// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/modules/main/main_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:food_delivery/shared/network/local/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 62.r,
                      backgroundColor: AppColors.mainColor,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[50],
                        radius: 60.r,
                        child: Image(
                          image: AssetImage('assets/images/appLogo.png'),
                        ),
                      ),
                    ),
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 32.sm,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextButton(
                        onTap: () {},
                        label: 'Edit Profile',
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      BigText(text: 'Hi There John Doe'),
                      SizedBox(
                        height: 4.h,
                      ),
                      AppTextButton(
                        onTap: () {
                          CacheHelper.removeData('token');
                          navigateToWithReplacement(context, MainScreen());
                        },
                        label: 'Sign Out',
                      ),
                      SizedBox(
                        height: 47.h,
                      ),
                      //name
                      AppTextFormField(
                        controller: nameController,
                        label: 'Name',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name is Required Field';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      //email
                      AppTextFormField(
                        controller: emailController,
                        label: 'Email',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email is Required Field';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      AppTextFormField(
                        controller: mobileNumberController,
                        label: 'Mobile No',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Mobile No is Required Field';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      AppTextFormField(
                        controller: addressController,
                        label: 'Address',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Address is Required Field';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                AppButton(
                    label: 'Save',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        print('ok');
                      }
                    }),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
