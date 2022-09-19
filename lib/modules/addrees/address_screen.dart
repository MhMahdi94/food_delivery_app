import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:latlong2/latlong.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Change Address',
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
          FlutterMap(
            options: MapOptions(
              center: LatLng(15.508457, 32.522854),
              zoom: 9.2,
            ),
            nonRotatedChildren: [],
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(15.508457, 32.522854),
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
        ],
      ),
    );
  }
}
