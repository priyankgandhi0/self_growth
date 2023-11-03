import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/profile/subscription/subscription_con.dart';
import 'package:self_growth/ui/widgets/app_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/common_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({Key? key}) : super(key: key);
  final SubscriptionCon subscriptionCon = Get.put(SubscriptionCon());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionCon>(builder: (ctrl) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: Get.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.images.backGroundImage.path),
                      fit: BoxFit.fill)),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        Get.back();
                      },
                      child: Assets.icons.backArrow
                          .svg()
                          .paddingSymmetric(horizontal: 16.w, vertical: 10.w),
                    ),
                    15.w.spaceH(),
                    startYourMembershipNowText
                        .appSwitzerTextStyle(
                            fontSize: 32.w,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start)
                        .paddingSymmetric(horizontal: 20.w),
                    25.w.spaceH(),
                    SizedBox(
                      height: 280.w,
                      child: PageView(
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          ctrl.initialPage = value;
                        },
                        controller: ctrl.pageController,
                        children: <Widget>[
                          premiumWidget(ctrl),
                          premiumWidget(ctrl),
                          premiumWidget(ctrl),
                        ],
                      ),
                    ),
                    15.w.spaceH(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => CircleAvatar(
                                  radius: 3.r,
                                  backgroundColor: ctrl.initialPage == index
                                      ? borderPurpleColor
                                      : doteColor,
                                ).paddingSymmetric(horizontal: 2.w)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundAppButton(title: 'Start 7 days free trial', onTap: () {})
                      .paddingSymmetric(horizontal: 46.w),
                  10.w.spaceH(),
                  noCommitText.appSwitzerTextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14.sp),
                  20.w.spaceH(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget premiumWidget(SubscriptionCon ctrl) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w), color: white_FFFFFF),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.w.spaceH(),
                  'Premium'
                      .appSwitzerTextStyle(
                          fontWeight: FontWeight.w600, fontSize: 32.sp)
                      .paddingSymmetric(horizontal: 20.w),
                  '49 SAR/month'
                      .appSwitzerTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                          fontColor: borderPurpleColor.withOpacity(.8),
                          fontFamily: 'Switzer')
                      .paddingSymmetric(horizontal: 20.w),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.w),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 48.w,
                          child: ProfileDataCard(
                              image: ctrl.subscriptionImageList[index],
                              height: 32.w,
                              onTap: () {},
                              title: ctrl.subscriptionList[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const CommonDivider()
                            .paddingSymmetric(vertical: 2.w);
                      },
                      itemCount: ctrl.subscriptionList.length),
                ],
              ),
            )).paddingSymmetric(horizontal: 20.w),
        Positioned(
          right: 20.w,
          top: 20.w,
          child: Container(
              height: 34.w,
              width: 87.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.images.buttonImg.path),
                      fit: BoxFit.fill),
                  border: const GradientBoxBorder(
                      gradient: LinearGradient(colors: [
                        borderPinkColor,
                        borderPurpleColor,
                        borderPurpleColor,
                        borderPurpleColor,
                        borderPinkColor
                      ]),
                      width: 2),
                  borderRadius: BorderRadius.circular(8.w),
                  color: skyColor),
              child: Center(
                child: 'Best Value'.appSwitzerTextStyle(
                    fontWeight: FontWeight.w500, fontSize: 13.sp),
              )).paddingOnly(right: 20.w),
        ),
      ],
    );
  }
}
