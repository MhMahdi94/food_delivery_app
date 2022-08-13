import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/modules/auth/otp_screen.dart';

import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Container(
            width: 204.w,
            height: 40.h,
            child: BigText(
              text: 'Reset Password',
              fontSize: 30.sp,
            ),
          ),
          SizedBox(
            height: 16.6.h,
          ),
          Text(
            'Please enter your email to receive a \n link to  create a new password via email',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondaryFontColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 60.h,
          ),
          AppTextFormField(
            label: 'Email',
            onChanged: (value) {},
          ),
          SizedBox(
            height: 34.h,
          ),
          AppButton(
            label: 'Send',
            onTap: () {
              navigateTo(context, Otp_Screen());
            },
          ),
        ],
      ),
    );
  }
}
