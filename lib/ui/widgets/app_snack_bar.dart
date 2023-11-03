import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

showAppSnackBar(String tittle, {bool status = false}) {
  if (tittle.isEmpty) return;
  return Get.showSnackbar(GetSnackBar(
    messageText: tittle.appGradientTextStyle(
        fontSize: 14.sp,
        gradientColors: [
          const Color(0xffD4E0DF),
          const Color(0xffE0CECD),
          const Color(0xffEDE3FF)
        ],
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.start),
    borderRadius: 15.r,
    borderWidth: 2,
    borderColor: borderPurpleColor,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shouldIconPulse: false,
    icon: Icon(
      status ? Icons.check_circle_outline_rounded : Icons.error_outline,
      color: white_FFFFFF,
    ),
    backgroundColor: borderPurpleColor,
    duration: const Duration(seconds: 3),
  ));
}
