// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/layout/app_layout.dart';
import 'package:food_delivery/shared/cubit/bloc_observer.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:food_delivery/shared/network/local/cache_helper.dart';
import 'package:food_delivery/shared/network/remote/dio_helper.dart';
import 'package:food_delivery/shared/theme.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await DioHelper.init();
      await CacheHelper.init();
      runApp(MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AppCubit()
            ..getPopularProductModel()
            ..getRecommendedFood(),
          child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                home: AppLayout(),
              );
            },
            listener: (context, state) {},
          ),
        );
      },
    );
  }
}
