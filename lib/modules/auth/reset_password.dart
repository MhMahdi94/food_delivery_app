import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/modules/auth/otp_screen.dart';

import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
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
              height: 34.h,
            ),
            AppButton(
              label: 'Send',
              onTap: () {
                if (formKey.currentState!.validate())
                  navigateTo(context, Otp_Screen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
