// ignore_for_file: must_be_immutable, prefer_const_constructors

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
      width: 30.w,
      height: 30.h,
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

  final Color? backgroundColor;
  const AppIconTextButton({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onPressed,
    this.backgroundColor = AppColors.mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315.w,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: backgroundColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${text}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Icon(
              iconData,
              size: 24.sm,
              color: Colors.white,
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

//Navigation
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToWithReplacement(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

//buttons

class AppButton extends StatelessWidget {
  final bool? filled;
  final String? label;
  final void Function()? onTap;
  const AppButton(
      {Key? key, this.filled = true, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 307.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: filled! ? AppColors.mainColor : Colors.white,
          borderRadius: BorderRadius.circular(50.r),
          border:
              filled! ? null : Border.all(color: AppColors.mainColor, width: 1),
        ),
        child: Center(
          child: Text(
            label!,
            style: TextStyle(
              color: filled! ? Colors.white : AppColors.mainColor,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final void Function()? onTap;
  final String? label;
  final Color? color;
  final FontWeight fontWeight;
  const AppTextButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.color = AppColors.secondaryFontColor,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label!,
        style: TextStyle(
          color: color,
          fontSize: 14.sp,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

//Text Form Field
class AppTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? label;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const AppTextFormField({
    Key? key,
    required this.onChanged,
    required this.label,
    this.isPassword = false,
    required this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 34.w,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorColor: AppColors.secondaryFontColor,
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textFieldBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              50.r,
            ),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          hintText: label,
          hintStyle: TextStyle(
            color: AppColors.placeHodlderColor,
          ),
          errorStyle: TextStyle(
            color: AppColors.mainColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        cursorHeight: 16.h,
        onChanged: onChanged,
      ),
    );
  }
}
