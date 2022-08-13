import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/layout/app_layout.dart';
import 'package:food_delivery/modules/auth/reset_password.dart';
import 'package:food_delivery/modules/auth/signup_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
                width: 74.w,
                height: 40.h,
                child: BigText(
                  text: 'Login',
                  fontSize: 30.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              SmallText(
                text: 'Add your details to login',
                fontSize: 14.sp,
              ),
              SizedBox(
                height: 24.h,
              ),
              AppTextFormField(
                label: 'Your Email',
                onChanged: (value) {},
              ),
              SizedBox(
                height: 24.h,
              ),
              AppTextFormField(
                label: 'Password',
                onChanged: (value) {},
              ),
              SizedBox(
                height: 32.h,
              ),
              AppButton(
                label: 'Login',
                onTap: () {
                  navigateToWithReplacement(context, AppLayout());
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              AppTextButton(
                onTap: () {
                  navigateTo(context, ResetPasswordScreen());
                },
                label: 'Forgot Your Password?',
              ),
              SizedBox(
                height: 64.h,
              ),
              Container(
                width: 84.w,
                height: 19.h,
                child: Text(
                  'or Login With',
                  style: TextStyle(
                    color: AppColors.secondaryFontColor,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              AppIconTextButton(
                onPressed: () {},
                iconData: Icons.facebook_outlined,
                text: 'Login with Facebook',
                backgroundColor: Color(0xff367FC0),
              ),
              SizedBox(
                height: 16.h,
              ),
              AppIconTextButton(
                onPressed: () {},
                iconData: Icons.g_mobiledata_outlined,
                text: 'Login with Google',
                backgroundColor: Color(0xffDD4B39),
              ),
              SizedBox(
                height: 64.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    'Don\'t have an Account?',
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
                      navigateTo(context, SignUpScreen());
                    },
                    label: "SignUp",
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
