import 'package:flutter/material.dart';
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
      this.fontColor})
      : super(key: key);
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final String title;
  final Color? fontColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? grey_969696,
                minimumSize: Size(width ?? Get.width, height ?? 48)),
            onPressed: () {},
            child: title.appTextStyle(fontColor: fontColor ?? white_FFFFFF))
        .paddingSymmetric(horizontal: 32);
  }
}
