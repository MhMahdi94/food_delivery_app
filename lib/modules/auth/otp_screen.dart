// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/modules/auth/new_password_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:pinput/pinput.dart';

class Otp_Screen extends StatelessWidget {
  const Otp_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.w,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.textFieldBackgroundColor,
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Center(
            child: Text(
              'We have sent an OTP to\n your Mobile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.mainFontColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              'Please check your mobile number 071*****12 \ncontinue to reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.mainFontColor,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 54.h,
          ),
          Pinput(
            obscureText: true,
            obscuringWidget: Center(
              child: Center(
                child: Text(
                  '*',
                  style: TextStyle(
                    fontSize: 37.sp,
                    color: AppColors.secondaryFontColor,
                  ),
                ),
              ),
            ),
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            // validator: (s) {
            //   return s == '2222' ? null : 'Pin is incorrect';
            // },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          SizedBox(
            height: 36.h,
          ),
          AppButton(
            label: 'Next',
            onTap: () {
              navigateTo(context, NewPasswordScreen());
            },
          ),
          SizedBox(
            height: 32.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Text(
                'Didn\'t Receive? ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.secondaryFontColor,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              AppTextButton(
                onTap: () {},
                label: "Click Here",
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          )
        ],
      ),
    );
  }
}
