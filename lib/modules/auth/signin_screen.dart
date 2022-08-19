import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/layout/app_layout.dart';
import 'package:food_delivery/models/auth/signin_model.dart';
import 'package:food_delivery/modules/auth/cubit/cubit.dart';
import 'package:food_delivery/modules/auth/cubit/states.dart';
import 'package:food_delivery/modules/auth/reset_password.dart';
import 'package:food_delivery/modules/auth/signup_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      builder: (context, state) {
        return Scaffold(
          body: LoadingOverlay(
            isLoading: AuthCubit.get(context).saving,
            color: AppColors.placeHodlderColor,
            progressIndicator: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.stretchedDots(
                  color: AppColors.mainColor,
                  size: 70.sm,
                ),
                SizedBox(
                  height: 16.h,
                ),
                BigText(
                  text: 'Please Wait ...',
                  fontSize: 24.sp,
                  color: AppColors.mainFontColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formKey,
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
                      //email
                      AppTextFormField(
                        controller: emailController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email is Required Field';
                          }
                          return null;
                        },
                        label: 'Your Email',
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      //password
                      AppTextFormField(
                        controller: passwordController,
                        isPassword: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password is Required Field';
                          }
                          return null;
                        },
                        label: 'Password',
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      AppButton(
                        label: 'Login',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            SignInModel model = SignInModel(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            AuthCubit.get(context).loginUser(model);
                            //AuthCubit.get(context).loadingOverlay(false);
                            //navigateToWithReplacement(context, AppLayout());
                          }
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
                        iconData: FontAwesomeIcons.facebook,
                        text: 'Login with Facebook',
                        backgroundColor: Color(0xff367FC0),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppIconTextButton(
                        onPressed: () {},
                        iconData: FontAwesomeIcons.googlePlusG,
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
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AuthSignInLoadingState) {
          AuthCubit.get(context).loadingOverlay(true);
        }
        if (state is AuthSignInFailureState) {
          Fluttertoast.showToast(
            msg: state.error!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 12.sp,
          );
          AuthCubit.get(context).loadingOverlay(false);
        }

        if (state is AuthSignInSuccessState) {
          Fluttertoast.showToast(
            msg: "Successfully Login",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 12.sp,
          );
          AuthCubit.get(context).loadingOverlay(false);
          emailController.text = '';
          passwordController.text = '';
          navigateToWithReplacement(context, const AppLayout());
        }
      },
    );
  }
}
