import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/generated/assets.dart';
import 'package:self_growth/ui/widgets/app_button.dart';
import '../../../config/routes/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/app_title_bar.dart';
import '../../widgets/common_widget.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  final OnBoardingController onBoardingController =
      Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (ctrl) {
      return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: ctrl.initialPage == 0,
              child: RoundAppButton(
                title: getStartedText,
                onTap: () {},
              ).paddingOnly(left: 46.w, right: 46.w, bottom: 16.w),
            ),
            RoundAppButton(
              title: ctrl.initialPage == ctrl.pageController.initialPage
                  ? loginText
                  : nextText,
              color: ctrl.initialPage == 0 ? lightGrayColor : grey_969696,
              textColor: ctrl.initialPage == 0 ? darkGrayColor : white_FFFFFF,
              onTap: () {
                if (ctrl.initialPage == 2) {
                  Get.toNamed(Routes.personalInfoScreen);
                } else {
                  ctrl.pageController.animateToPage(
                    ctrl.initialPage + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                }
              },
            ).paddingSymmetric(horizontal: 46.w),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: [
            PageView(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) {
                FocusManager.instance.primaryFocus?.unfocus();
                ctrl.initialPage = value;
              },
              controller: ctrl.pageController,
              children: const <Widget>[
                PageViewCard(title: firstScreenTextText, subTitle: ''),
                PageViewCard(title: whyUsText, subTitle: secondScreenText),
                PageViewCard(title: andHowIsThatText, subTitle: thirdScreenText)
              ],
            ),
            Column(
              children: [
                WithOutTitleAppBar(
                  onTap: () {
                    ctrl.pageController.animateToPage(
                      ctrl.initialPage - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                    ctrl.update();
                  },
                  showBackButton: ctrl.initialPage != 0,
                  suffixWidget: BorderButton(
                    title: englishText,
                    onTap: () {},
                  ),
                ),
                Container(
                  height: 250.w,
                  width: Get.width,
                  margin: EdgeInsets.only(top: 55.w),
                  decoration: BoxDecoration(
                      color: background_F5F5F5,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: grey_969696.withOpacity(0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.iconsImage),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 47.w),
                (ctrl.initialPage == 0 ? 110.w : 135.w).spaceH(),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => CircleAvatar(
                              radius: 3.r,
                              backgroundColor: ctrl.initialPage == index
                                  ? grey_969696
                                  : doteColor,
                            ).paddingSymmetric(horizontal: 1.w)),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
