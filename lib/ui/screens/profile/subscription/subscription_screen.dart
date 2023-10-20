import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/profile/subscription/subscription_con.dart';
import 'package:self_growth/ui/widgets/app_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/app_helper.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/common_widget.dart';
import '../../bottom_navigation/bottom_bar_controller.dart';
import '../profile_screen.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({Key? key}) : super(key: key);
  final BottomBarController bottomBarController = Get.find();
  final SubscriptionCon subscriptionCon = Get.put(SubscriptionCon());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionCon>(builder: (ctrl) {
      return Scaffold(
        bottomNavigationBar: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(title: 'Start 7 days free trial', onPress: () {})
                  .paddingSymmetric(horizontal: 16.w),
              16.w.spaceH(),
              noCommitText.appTextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14.sp),
              20.w.spaceH(),
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  10.w.spaceH(),
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      Get.back();
                    },
                    child: Assets.icons.backArrow
                        .svg()
                        .paddingSymmetric(horizontal: 16.w, vertical: 10.w),
                  ),
                  24.w.spaceH(),
                  startYourMembershipNowText
                      .appTextStyle(
                          fontSize: 32.w,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start)
                      .paddingSymmetric(horizontal: 20.w),
                  30.w.spaceH(),
                  SizedBox(
                    height: 278.w,
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
                ],
              ),
              Positioned(
                left: 0,
                bottom: -40.w,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => CircleAvatar(
                              radius: 3.r,
                              backgroundColor: ctrl.initialPage == index
                                  ? grey_969696
                                  : doteColor,
                            ).paddingSymmetric(horizontal: 2.w)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget premiumWidget(SubscriptionCon ctrl) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w), color: white_FFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.w.spaceH(),
                'Premium'
                    .appTextStyle(fontWeight: FontWeight.w600, fontSize: 32.sp)
                    .paddingSymmetric(horizontal: 20.w),
                '49 SAR/month'
                    .appTextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp)
                    .paddingSymmetric(horizontal: 20.w),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                    itemBuilder: (context, index) {
                      return ProfileDataCard(
                              onTap: () {}, title: ctrl.subscriptionList[index])
                          .paddingSymmetric(vertical: 8.w);
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 0.4.w,
                        color: grey_969696.withOpacity(.5),
                      );
                    },
                    itemCount: ctrl.subscriptionList.length),
                5.w.spaceH(),
              ],
            )).paddingSymmetric(horizontal: 20.w),
        Positioned(
          right: 20.w,
          top: 20.w,
          child: Container(
              height: 34.w,
              width: 87.w,
              decoration: BoxDecoration(
                  border: Border.all(color: grey_969696.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(8.w),
                  color: skyColor),
              child: Center(
                child: 'Best Value'
                    .appTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              )).paddingOnly(right: 20.w),
        ),
      ],
    );
  }
}
