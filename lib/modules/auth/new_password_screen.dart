import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/modules/auth/signin_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Center(
            child: Text(
              'New Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.mainFontColor,
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'Please enter your email to receive a \nlink to  create a new password via email',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondaryFontColor,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
          SizedBox(
            height: 39.h,
          ),
          AppTextFormField(
            label: 'New Password',
            isPassword: true,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 28.h,
          ),
          AppTextFormField(
            isPassword: true,
            label: 'Confirm Password',
            onChanged: (value) {},
          ),
          SizedBox(
            height: 28.h,
          ),
          AppButton(
            label: 'Next',
            onTap: () {
              navigateTo(context, SignInScreen());
            },
          ),
        ],
      ),
    );
  }
}
