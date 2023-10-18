import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

showAppSnackBar(String tittle, {bool status = false}) {
  if (tittle.isEmpty) return;
  return Get.showSnackbar(GetSnackBar(
    messageText: tittle.appTextStyle(
        fontSize: 18, fontColor: Colors.white, textAlign: TextAlign.start),
    borderRadius: 15,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shouldIconPulse: false,
    icon: Icon(
      status ? Icons.check_circle_outline_rounded : Icons.error_outline,
      color: Colors.white,
    ),
    backgroundColor: background_EBEBEB,
    duration: const Duration(seconds: 3),
  ));
}
