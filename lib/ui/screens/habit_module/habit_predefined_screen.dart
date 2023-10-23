import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_chip.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';

import '../../../gen/assets.gen.dart';

class HabitPredefinedScreen extends StatelessWidget {
  const HabitPredefinedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.backGroundImage.path),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.w.spaceH(),
              WithOutTitleAppBar(
                suffixWidget: 'Customize'.appTextStyle(
                    fontColor: borderPurpleColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
                widget: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    splashFactory: NoSplash.splashFactory,
                    child: const Icon(Icons.close, color: borderPurpleColor)),
                showBackButton: true,
                padding: 20.w,
              ),
              ProfileBoxCard(
                  widget: Assets.icons.selfDiscoveryImg.svg(),
                  child: Column(
                    children: [
                      const AppChip(title: 'Build Habit').paddingOnly(
                        top: 40.w,
                      ),
                      "Drinking Water"
                          .appTextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600)
                          .paddingSymmetric(vertical: 8.h),
                      "Daily"
                          .appTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontColor: black_000000.withOpacity(0.5))
                          .paddingSymmetric(vertical: 8.h),
                      ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  const SelfDiscoveryCard(
                                      title:
                                          'Benefit drinking water for your body'),
                              separatorBuilder: (context, index) =>
                                  12.h.spaceH(),
                              itemCount: 4)
                          .paddingSymmetric(horizontal: 20.w),
                      20.w.spaceH(),
                    ],
                  )),
              16.w.spaceH(),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: white_FFFFFF,
                    borderRadius: BorderRadius.circular(16.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "What you will do".appTextStyle(
                        fontSize: 17.sp, fontWeight: FontWeight.w600),
                    20.h.spaceH(),
                    "Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing scelerisque. Molestie sed egestas nulla pulvinar aliquam duis."
                        .appTextStyle(
                            fontSize: 14.sp,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            fontColor: black_000000.withOpacity(0.7)),
                  ],
                ).paddingAll(20.w),
              ).paddingSymmetric(horizontal: 20.w),
              20.w.spaceH(),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: white_FFFFFF,
                    borderRadius: BorderRadius.circular(16.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Why am doing this?".appTextStyle(
                        fontSize: 17.sp, fontWeight: FontWeight.w600),
                    20.h.spaceH(),
                    "Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing scelerisque. Molestie sed egestas nulla pulvinar aliquam duis."
                        .appTextStyle(
                            fontSize: 14.sp,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            fontColor: black_000000.withOpacity(0.7)),
                  ],
                ).paddingAll(20.w),
              ).paddingSymmetric(horizontal: 20.w),
              20.w.spaceH(),
            ],
          ),
        ),
      ),
    );
  }
}

class HabitPredefinedSubCard extends StatelessWidget {
  const HabitPredefinedSubCard({Key? key, required this.title})
      : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
              color: grey_D9D9D9, borderRadius: BorderRadius.circular(4.r)),
        ),
        8.w.spaceW(),
        Expanded(
          child: title
              .appTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start)
              .paddingSymmetric(),
        )
      ],
    );
  }
}
