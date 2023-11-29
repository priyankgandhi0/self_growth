import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/self_discovery/all_discover_screen.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_helper.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/common_widget.dart';
import '../bottom_navigation/bottom_bar_controller.dart';
import 'discover_con.dart';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({Key? key}) : super(key: key);
  final DiscoverController discoverController = Get.put(DiscoverController());
  final BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscoverController>(builder: (ctrl) {
      return Column(
        children: [
          16.w.spaceH(),
          'Discover'.appSwitzerTextStyle(
              fontWeight: FontWeight.w700, fontSize: 28.sp),
          Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                      color: white_FFFFFF),
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return DiscoverCard(
                          image: index == 0
                              ? Assets.icons.selfDiscovery.path
                              : Assets.icons.newHabbit.path,
                          onTap: () {
                            if (index == 0) {
                              Get.toNamed(Routes.selfDiscoverScreen);
                            } else {
                              Get.toNamed(Routes.newHabitScreen);
                            }
                          },
                          title: index == 0 ? 'Self Discovery' : "New Habit",
                          subTitle: 'This is description',
                        ).paddingSymmetric(horizontal: 20.w, vertical: 12.w);
                      },
                      separatorBuilder: (context, index) {
                        return const CommonDivider()
                            .paddingSymmetric(horizontal: 20.w);
                      },
                      itemCount: 2))
              .paddingSymmetric(horizontal: 20.w, vertical: 16.w),
          Row(
            children: [
              todayArticle.appSwitzerTextStyle(
                  fontWeight: FontWeight.w600, fontSize: 18.sp),
              const Spacer(),
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  bottomBarController.isOpen = true;
                  bottomBarController.changeTab(BottomNavEnum.other);
                  bottomBarController.isSelectedTab = 4;

                  bottomBarController.tab = AllDisCoverDataScreen();
                  bottomBarController.update();
                },
                child: seeMore.appSwitzerTextStyle(
                    fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w),
          16.w.spaceH(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(
                  ctrl.discoverTabList.length,
                  (index) => CommonTabBar(
                        title: ctrl.discoverTabList[index],
                        index: index,
                      ).paddingOnly(right: 8.w)),
            ).paddingOnly(left: 20.w),
          ),
          20.w.spaceH(),
          ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DiscoverCommonCard(
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 16.w.spaceH();
                  },
                  itemCount: 7)
              .paddingSymmetric(horizontal: 20.w),
          86.w.spaceH(),
        ],
      );
    });
  }
}

class DiscoverCommonCard extends StatelessWidget {
  const DiscoverCommonCard({Key? key, this.onTap, this.color, this.buttonColor})
      : super(key: key);
  final void Function()? onTap;
  final Color? color;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color ?? white_FFFFFF,
            borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Heading'.appSwitzerTextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14.sp),
                'This is description'.appSwitzerTextStyle(
                    fontWeight: FontWeight.w400,
                    fontColor: doteColor,
                    fontSize: 13.sp),
                14.w.spaceH(),
                Container(
                  decoration: BoxDecoration(
                      color: buttonColor ?? textFiledColor,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: '8 min'
                        .appSwitzerTextStyle(
                            fontWeight: FontWeight.w400,
                            fontColor: doteColor,
                            fontSize: 13.sp)
                        .paddingSymmetric(horizontal: 6.w, vertical: 2.w),
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              height: 64.w,
              width: 64.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r), color: doteColor),
            )
          ],
        ).paddingSymmetric(horizontal: 16.w, vertical: 11.w),
      ),
    );
  }
}
