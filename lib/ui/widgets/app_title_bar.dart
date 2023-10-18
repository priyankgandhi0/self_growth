import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

class AppTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingWidget;
  final bool isHome;
  final String titleText;

  final List<Widget>? suffixWidget;
  const AppTitleBar(
      {super.key,
      this.isHome = false,
      this.leadingWidget,
      this.suffixWidget,
      required this.titleText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: isHome
          ? leadingWidget
          : const Icon(Icons.arrow_back_ios_new_rounded)
              .paddingSymmetric(vertical: 16.w)
              .onTap(() {
              Get.back();
            }),
      actions: suffixWidget,
      title:
          titleText.appTextStyle(fontWeight: FontWeight.w700, fontSize: 17.sp),
      backgroundColor: white_FFFFFF,
      centerTitle: false,
      elevation: 0.1,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
