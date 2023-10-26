import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/config/routes/router.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/app_button.dart';

class SelfDiscoverScreen extends StatelessWidget {
  const SelfDiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.backGroundImage.path),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  46.w.spaceH(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.close),
                  ).paddingSymmetric(horizontal: 20.w),
                  ProfileBoxCard(
                    margin: 40.w,
                    widget: Assets.icons.selfDisc.svg(),
                    child: Column(
                      children: [
                        20.w.spaceH(),
                        'Self Discovery'.appSwitzerTextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.sp),
                        12.w.spaceH(),
                        Container(
                          height: 23.w,
                          width: 48.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              color: background_F5F5F5),
                          child: Center(
                            child: '5 min'.appSwitzerTextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        24.w.spaceH(),
                        'Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing scelerisque. Molestie sed egestas nulla pulvinar aliquam duis.'
                            .appSwitzerTextStyle(
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w400,
                                fontColor: doteColor,
                                fontSize: 14.sp),
                      ],
                    ).paddingSymmetric(horizontal: 24.w, vertical: 24.w),
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: white_FFFFFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'What you will get'.appSwitzerTextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17.sp),
                        10.w.spaceH(),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return SelfDiscoveryCard(
                                title: 'Benefit drinking water for your body',
                                onTap: () {},
                              );
                            },
                            separatorBuilder: (context, index) {
                              return 14.w.spaceH();
                            },
                            itemCount: 4)
                      ],
                    ).paddingAll(20.w),
                  ).paddingSymmetric(horizontal: 20.w, vertical: 16.w),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: white_FFFFFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Why am doing this?'.appTextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17.sp),
                        20.w.spaceH(),
                        'Lorem ipsum dolor sit amet consectetur. Quam arcu a pellentesque adipiscing scelerisque. Molestie sed egestas nulla pulvinar aliquam duis.'
                            .appTextStyle(
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w400,
                                fontColor: doteColor,
                                fontSize: 14.sp),
                      ],
                    ).paddingAll(20.w),
                  ).paddingSymmetric(horizontal: 20.w, vertical: 16.w),
                  50.w.spaceH(),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RoundAppButton(
                title: getStartedText,
                onTap: () {
                  Get.toNamed(Routes.firstQuestionScreen);
                }).paddingOnly(left: 32.w, right: 32.w, bottom: 16.w),
          ),
        ],
      ),
    );
  }
}
