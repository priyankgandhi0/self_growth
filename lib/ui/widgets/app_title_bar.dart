import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

import '../../generated/assets.dart';

class AppTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingWidget;
  final bool isHome;
  final String titleText;
  Color? backgroundColor;
  Color? fontColor;
  bool? centerTitle;
  bool endTitle;
  double? fontSize = 17.sp;
  FontWeight fontWeight = FontWeight.w700;

  final List<Widget>? suffixWidget;
  AppTitleBar(
      {super.key,
      this.isHome = false,
      this.leadingWidget,
      this.centerTitle,
      this.endTitle = false,
      this.fontSize,
      this.fontWeight = FontWeight.w700,
      this.backgroundColor,
      this.fontColor,
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
      actions: endTitle
          ? [
              (titleText
                  .appTextStyle(
                      fontColor: fontColor ?? black_000000,
                      fontWeight: fontWeight,
                      fontSize: fontSize ?? 17.sp)
                  .paddingOnly(right: 20))
            ]
          : suffixWidget,
      title: endTitle
          ? null
          : (titleText.appTextStyle(
              fontColor: fontColor ?? black_000000,
              fontWeight: fontWeight,
              fontSize: fontSize ?? 17.sp)),
      backgroundColor: backgroundColor ?? white_FFFFFF,
      centerTitle: centerTitle ?? false,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class WithOutTitleAppBar extends StatelessWidget {
  const WithOutTitleAppBar(
      {Key? key,
      required this.suffixWidget,
      required this.showBackButton,
      required this.onTap})
      : super(key: key);
  final Widget suffixWidget;
  final bool showBackButton;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          showBackButton
              ? InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: onTap,
                  child: SvgPicture.asset(Assets.iconsBackArrow))
              : const SizedBox(),
          const Spacer(),
          suffixWidget,
        ],
      ),
    ).paddingSymmetric(horizontal: 16.w);
  }
}
