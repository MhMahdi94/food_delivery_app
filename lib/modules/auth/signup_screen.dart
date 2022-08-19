import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/layout/app_layout.dart';
import 'package:food_delivery/models/auth/signup_model.dart';
import 'package:food_delivery/modules/auth/cubit/cubit.dart';
import 'package:food_delivery/modules/auth/cubit/states.dart';
import 'package:food_delivery/modules/auth/signin_screen.dart';
import 'package:food_delivery/shared/components.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var addressController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                    //Name
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
                      height: 24.h,
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
                      height: 24.h,
                    ),
                    //mobile no
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
                      height: 32.h,
                    ),
                    //address
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
                    SizedBox(
                      height: 32.h,
                    ),
                    //password
                    AppTextFormField(
                      controller: passwordController,
                      label: 'Password',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password is Required Field';
                        }
                        return null;
                      },
                      isPassword: true,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    //confirm password
                    AppTextFormField(
                      controller: confirmPasswordController,
                      label: 'Confirm Password',
                      isPassword: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password is Required Field';
                        }
                        if (value != passwordController.text) {
                          return 'Password and Confirm Password are not match';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    ConditionalBuilder(
                      condition: state is AuthSignUpLoadingState,
                      builder: (context) => Center(
                        child: LoadingAnimationWidget.stretchedDots(
                          color: AppColors.mainColor,
                          size: 70.sm,
                        ),
                      ),
                      fallback: (context) => AppButton(
                        label: 'Sign Up',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            SignUpModel model = SignUpModel(
                              address: addressController.text,
                              email: emailController.text,
                              mobileNo: mobileNumberController.text,
                              name: nameController.text,
                              password: passwordController.text,
                            );
                            AuthCubit.get(context).registerUser(model);
                          }
                          if (state is AuthSignUpSuccessState) {
                            addressController.text = '';
                            emailController.text = '';
                            mobileNumberController.text = '';
                            nameController.text = '';
                            passwordController.text = '';
                            confirmPasswordController.text = '';
                          }
                        },
                      ),
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
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AuthSignUpFailureState) {
          Fluttertoast.showToast(
            msg: "Error in your Input Date",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 12.sp,
          );
        }

        if (state is AuthSignUpSuccessState) {
          Fluttertoast.showToast(
            msg: "Complete Registeration",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 12.sp,
          );
          navigateToWithReplacement(context, const AppLayout());
        }
      },
    );
  }
}
