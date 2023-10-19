import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: background_F5F5F5,
      visualDensity: VisualDensity.compact,
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      label: title.appTextStyle(fontSize: 12.h, fontWeight: FontWeight.w400),
      // color: MaterialStatePropertyAll<Color>(background_F5F5F5),
    );
  }
}
