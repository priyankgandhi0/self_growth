import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/app_helper.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/bottom_navigation/bottom_bar_controller.dart';
import 'package:self_growth/ui/screens/self_discovery/discover_con.dart';
import 'package:self_growth/ui/screens/self_discovery/discover_screen.dart';
import 'package:self_growth/ui/screens/self_discovery/self_discover/self_discovery_con.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/common_widget.dart';

class QuestionTwoScreen extends StatelessWidget {
  const QuestionTwoScreen({Key? key, required this.ctrl}) : super(key: key);
  final SelfDiscoveryCon ctrl;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: white_FFFFFF,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Heading'
                    .appTextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
                'Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing scelerisque. Molestie sed egestas nulla pulvinar aliquam duis.'
                    .appTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        textAlign: TextAlign.start)
                    .paddingOnly(top: 20.w),
                'Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing '
                    .appTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        textAlign: TextAlign.start)
                    .paddingOnly(top: 20.w),
                Container(
                  height: 150.w,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: grey_D9D9D9),
                ).paddingOnly(top: 20.w),
                'Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing '
                    .appTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        textAlign: TextAlign.start)
                    .paddingOnly(top: 20.w),
                'Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing scelerisque. Molestie sed egestas nulla pulvinar aliquam duis.'
                    .appTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        textAlign: TextAlign.start)
                    .paddingOnly(top: 20.w),
                'Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing '
                    .appTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        textAlign: TextAlign.start)
                    .paddingOnly(top: 20.w),
              ],
            ).paddingAll(20.w),
          ).paddingOnly(
            left: 20.w,
            right: 20.w,
            top: 85.w,
          ),
          RoundAppButton(
              title: continueText,
              onTap: () {
                ctrl.isQueAns = 2;
              }).paddingSymmetric(horizontal: 32.w, vertical: 20.w)
        ],
      ),
    );
  }
}

class QuestionThirdScreen extends StatelessWidget {
  QuestionThirdScreen({Key? key, required this.ctrl}) : super(key: key);
  final SelfDiscoveryCon ctrl;
  final BottomBarController bottomBarController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: white_FFFFFF,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Congratulations you have completed this test'
                    .appTextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
                Container(
                  height: 150.w,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: grey_D9D9D9),
                  child: Center(
                    child: CircleAvatar(
                      radius: 45.r,
                      backgroundColor: Colors.white,
                      child: CircularPercentIndicator(
                        radius: 44.r,
                        lineWidth: 8.w,
                        animation: true,
                        percent: 0.7,
                        backgroundColor: background_EBEBEB,
                        center: "78".appTextStyle(
                            fontSize: 28.sp, fontWeight: FontWeight.w500),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: grey_969696,
                      ),
                    ),
                  ),
                ).paddingOnly(top: 20.w),
                'Your score is quite good, and your answers indicate that you might be suffering from:'
                    .appTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        textAlign: TextAlign.start)
                    .paddingSymmetric(vertical: 20.w),
                Container(
                  decoration: BoxDecoration(
                      color: background_EBEBEB,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SelfDiscoveryCard(
                              title: ctrl.thirdQueList[index],
                              onTap: () {},
                            );
                          },
                          separatorBuilder: (context, index) {
                            return 14.w.spaceH();
                          },
                          itemCount: ctrl.thirdQueList.length)
                      .paddingSymmetric(horizontal: 12.w, vertical: 14.w),
                ),
                "But it's okay we all can lean towards bad habits, we will work together to overcome these challneges together"
                    .appTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        textAlign: TextAlign.start)
                    .paddingSymmetric(vertical: 20.w),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ThirdQueCard(
                        title: ctrl.thirdQueModelList[index].title,
                        value: ctrl.thirdQueModelList[index].value,
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (context, index) {
                      return 14.w.spaceH();
                    },
                    itemCount: ctrl.thirdQueModelList.length)
              ],
            ).paddingAll(20.w),
          ).paddingOnly(
            left: 20.w,
            right: 20.w,
            top: 85.w,
          ),
          RoundAppButton(title: reviewSuggestedPlan, onTap: () {})
              .paddingSymmetric(horizontal: 32.w, vertical: 20.w),
          BorderButton(
            title: backHomepage,
            onTap: () {
              log('ON TAP');
              ctrl.isQueAns = 0;
              Get.back();
              Get.back();
              // bottomBarController.changeTab(BottomNavEnum.other);
              // bottomBarController.isSelectedTab = 4;
              // bottomBarController.tab = DiscoverScreen();
              // bottomBarController.update();
            },
            width: Get.width,
            height: 48.w,
            buttonColor: background_EBEBEB,
          ).paddingOnly(bottom: 20.w, right: 32.w, left: 32.w)
        ],
      ),
    );
  }
}

class QuestionOneScreen extends StatelessWidget {
  const QuestionOneScreen({Key? key, required this.ctrl}) : super(key: key);
  final SelfDiscoveryCon ctrl;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          140.w.spaceH(),
          Align(
            alignment: Alignment.center,
            child: 'How have you been lately?'.appTextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center),
          ),
          48.w.spaceH(),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return FirstQueCard(
                  title: ctrl.firstQueList[index],
                ).paddingSymmetric(horizontal: 20.w);
              },
              separatorBuilder: (context, index) {
                return 12.w.spaceH();
              },
              itemCount: ctrl.firstQueList.length)
        ],
      ),
    );
  }
}
