import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      this.backgroundColor,
      this.height,
      this.width,
      required this.title,
      this.fontColor,
      required this.onPress})
      : super(key: key);
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final String title;
  final Color? fontColor;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
                splashFactory: InkRipple.splashFactory,
                backgroundColor: backgroundColor ?? grey_969696,
                minimumSize: Size(width ?? Get.width, height ?? 48)),
            onPressed: () {
              onPress();
            },
            child: title.appTextStyle(
                fontColor: fontColor ?? white_FFFFFF,
                fontWeight: FontWeight.w600))
        .paddingSymmetric(horizontal: 32);
  }
}

class RoundAppButton extends StatelessWidget {
  const RoundAppButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.color,
      this.textColor})
      : super(key: key);
  final String title;
  final Color? color;
  final Color? textColor;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.w,
        width: Get.width,
        decoration: BoxDecoration(
          color: color ?? grey_969696,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
            child: title.appTextStyle(
                fontColor: textColor ?? white_FFFFFF,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  const BorderButton(
      {Key? key,
      this.onTap,
      required this.title,
      required this.width,
      this.height,
      this.buttonColor})
      : super(key: key);
  final void Function()? onTap;
  final String title;
  final double width;
  final Color? buttonColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            height: height ?? 38.w,
            width: width,
            decoration: BoxDecoration(
                color: buttonColor ?? white_FFFFFF,
                borderRadius: BorderRadius.circular(40.r),
                border: Border.all(color: greyBorderColor)),
            child: Center(
              child: title
                  .appTextStyle(
                      fontColor: black_000000,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp)
                  .paddingSymmetric(horizontal: 10.w),
            )));
  }
}
