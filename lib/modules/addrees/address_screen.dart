// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:food_delivery/shared/cubit/cubit.dart';
import 'package:food_delivery/shared/cubit/states.dart';
import 'package:latlong2/latlong.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});

  TextEditingController addressController = TextEditingController();
  TextEditingController contactPersonNameController = TextEditingController();
  TextEditingController contactPersonNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(
              'Address Page',
              style: TextStyle(
                color: AppColors.mainFontColor,
              ),
            ),
            iconTheme: IconThemeData(
              color: AppColors.mainBlackColor,
            ),
          ),
          body: Stack(
            children: [
              ConditionalBuilder(
                condition: AppCubit.get(context).maploading,
                builder: (context) => CircularProgressIndicator(),
                fallback: (context) => FlutterMap(
                  options: MapOptions(
                    center: AppCubit.get(context).latLngPosition,
                    zoom: 17,
                  ),
                  nonRotatedChildren: [],
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: AppCubit.get(context).latLngPosition,
                          width: 80.w,
                          height: 80.h,
                          builder: (context) => Icon(
                            Icons.location_on,
                            color: AppColors.mainColor,
                            size: 32.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 200.h,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
