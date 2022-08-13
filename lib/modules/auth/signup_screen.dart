import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/layout/app_layout.dart';
import 'package:food_delivery/modules/auth/signin_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Container(
                width: 104.w,
                height: 40.h,
                child: BigText(
                  text: 'Sign Up',
                  fontSize: 30.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              SmallText(
                text: 'Add your details to sign up',
                fontSize: 14.sp,
              ),
              SizedBox(
                height: 24.h,
              ),
              AppTextFormField(
                label: 'Name',
                onChanged: (value) {},
              ),
              SizedBox(
                height: 24.h,
              ),
              AppTextFormField(
                label: 'Email',
                onChanged: (value) {},
              ),
              SizedBox(
                height: 24.h,
              ),
              AppTextFormField(
                label: 'Mobile No',
                onChanged: (value) {},
              ),
              SizedBox(
                height: 32.h,
              ),
              AppTextFormField(
                label: 'Address',
                onChanged: (value) {},
              ),
              SizedBox(
                height: 32.h,
              ),
              AppTextFormField(
                label: 'Password',
                isPassword: true,
                onChanged: (value) {},
              ),
              SizedBox(
                height: 32.h,
              ),
              AppTextFormField(
                label: 'Confirm Password',
                isPassword: true,
                onChanged: (value) {},
              ),
              SizedBox(
                height: 32.h,
              ),
              AppButton(
                label: 'Sign Up',
                onTap: () {
                  navigateToWithReplacement(context, AppLayout());
                },
              ),
              SizedBox(
                height: 54.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    'Already have an Account?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.secondaryFontColor,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  AppTextButton(
                    onTap: () {
                      navigateTo(context, SignInScreen());
                    },
                    label: "Login",
                    color: AppColors.mainColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
