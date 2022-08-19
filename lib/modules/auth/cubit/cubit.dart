// ignore_for_file: iterable_contains_unrelated_type

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/models/auth/signup_model.dart';
import 'package:food_delivery/models/auth/signup_resp_model.dart';
import 'package:food_delivery/models/error_model.dart';
import 'package:food_delivery/modules/auth/cubit/states.dart';
import 'package:food_delivery/shared/constants/constants.dart';
import 'package:food_delivery/shared/network/end_points.dart';
import 'package:food_delivery/shared/network/local/cache_helper.dart';
import 'package:food_delivery/shared/network/remote/dio_helper.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  ErrorModel? errorModel;
  SignUpRespModel? signUpResModel;

  void registerUser(SignUpModel? model) {
    emit(AuthSignUpLoadingState());
    //print(model!.toJson());
    DioHelper.postData(
      url: AUTH_REGISTER,
      data: model!.toJson(),
    ).then((value) {
      CacheHelper.removeData('token');
      signUpResModel = SignUpRespModel.fromJson(value.data);
      CacheHelper.setData(key: 'token', value: signUpResModel!.token);
      emit(AuthSignUpSuccessState());
    }).catchError((error) {
      //print(error.response.data);
      errorModel = ErrorModel.fromJson(error.response.data);
      //print(errorModel!.errors![0].message);
      emit(AuthSignUpFailureState(errorModel!.errors![0].message));
    });
  }
}
