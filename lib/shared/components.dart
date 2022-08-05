// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double fontSize;
  TextOverflow overflow;
  BigText({
    Key? key,
    required this.text,
    this.color = const Color(0xff332d2b),
    this.overflow = TextOverflow.ellipsis,
    this.fontSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        overflow: overflow,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double fontSize;
  double height;
  TextOverflow overflow;
  SmallText({
    Key? key,
    required this.text,
    this.color = const Color(0xff332d2b),
    this.overflow = TextOverflow.ellipsis,
    this.fontSize = 12,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        overflow: overflow,
        fontWeight: FontWeight.w500,
        height: height,
      ),
    );
  }
}

class ParaText extends StatelessWidget {
  final String text;
  Color? color;
  double fontSize;
  double height;
  TextOverflow overflow;
  ParaText({
    Key? key,
    required this.text,
    this.color = const Color(0xff332d2b),
    this.fontSize = 12,
    this.height = 1.2,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      maxLines: 20,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          height: height,
          overflow: overflow),
    );
  }
}

class IconTextWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;
  final Color textColor;
  const IconTextWidget({
    Key? key,
    required this.iconData,
    required this.text,
    required this.iconColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: iconColor,
        ),
        SizedBox(
          width: 5.w,
        ),
        SmallText(
          text: text,
          color: textColor,
        ),
      ],
    );
  }
}

class AppIcon extends StatelessWidget {
  final IconData? iconData;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? iconSize;
  AppIcon({
    Key? key,
    required this.iconData,
    this.iconColor = const Color(0xff756d54),
    this.backgroundColor = const Color(0xfffcf4e4),
    this.iconSize = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 25.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

class AppIconTextButton extends StatelessWidget {
  final String? text;

  final IconData? iconData;

  final void Function()? onPressed;

  const AppIconTextButton(
      {Key? key,
      required this.text,
      required this.iconData,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${text}',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.mainColor,
              ),
            ),
            Icon(
              iconData,
              size: 16.sp,
              color: AppColors.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final void Function()? onPressed;

  final IconData iconData;

  const AppIconButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          iconData,
          size: 14.sp,
          color: AppColors.signColor,
        ),
      ),
    );
  }
}

//Expandable Text Widget
class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = 200.h;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? ParaText(text: firstHalf)
          : Column(
              children: [
                ParaText(
                    height: 1.4,
                    fontSize: 16.sp,
                    color: AppColors.paraColor,
                    text: hiddenText
                        ? (firstHalf + '...')
                        : (firstHalf + secondHalf)),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? 'Show more' : ' Show less',
                        color: AppColors.mainColor,
                        fontSize: 14.sp,
                      ),
                      Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

//Shimmer Loading
class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: Text(
          'Shimmer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//Circular Loading
class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Loading ...",
            style: TextStyle(
              color: AppColors.mainBlackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
