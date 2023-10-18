import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';

import '../../core/constants/app_colors.dart';

class PageViewCard extends StatelessWidget {
  const PageViewCard({Key? key, required this.title, required this.subTitle})
      : super(key: key);
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 400.w.spaceH(),
        title
            .appTextStyle(
                fontColor: black_000000,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp)
            .paddingSymmetric(horizontal: 46.w)
            .paddingOnly(bottom: 5.w),
        subTitle
            .appTextStyle(
                fontColor: black_000000,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp)
            .paddingSymmetric(horizontal: 46.w),
      ],
    );
  }
}
