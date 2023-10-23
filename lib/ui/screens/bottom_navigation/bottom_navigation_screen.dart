import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/bottom_navigation/bottom_bar_controller.dart';
import 'package:self_growth/ui/screens/profile/profile_screen.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';

import '../../../config/routes/router.dart';
import '../../../core/utils/app_helper.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/app_dialogs.dart';
import '../home_module/home_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({Key? key}) : super(key: key);
  final BottomBarController bottomBarController =
      Get.put(BottomBarController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(builder: (ctrl) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: background_EBEBEB,
        bottomNavigationBar: bottomBarWidget(ctrl, context),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              ctrl.tab ?? HomeScreen(),
              20.w.spaceH(),
            ],
          ),
        ),
      );
    });
  }

  Container bottomBarWidget(BottomBarController ctrl, BuildContext context) {
    return Container(
      height: 86.w,
      color: white_FFFFFF,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomBarWidget(
            title: 'Home',
            color: ctrl.isSelectedTab == 1 ? black_000000 : grey_969696,
            onTap: () {
              ctrl.isSelectedTab = 1;
              ctrl.changeTab(BottomNavEnum.home);
              ctrl.update();
            },
          ),
          BottomBarWidget(
            title: 'Insight',
            color: ctrl.isSelectedTab == 2 ? black_000000 : grey_969696,
            onTap: () {
              ctrl.isSelectedTab = 2;
              ctrl.changeTab(BottomNavEnum.insight);
              ctrl.update();
            },
          ),
          InkWell(
              onTap: () {
                ctrl.isSelectedTab = 1;
                ctrl.changeTab(BottomNavEnum.home);
                openBottomDialogBox(
                    padding: 400.w,
                    child: Column(
                      children: [
                        ProfileDataCard(
                          height: 24.w,
                          title: 'Mood Checking',
                          onTap: () {
                            Get.back();
                            Get.toNamed(Routes.moodCheckingScreen);
                          },
                        ),
                        const Divider().paddingSymmetric(vertical: 6.w),
                        ProfileDataCard(height: 24.w, title: 'Voice Note'),
                        const Divider().paddingSymmetric(vertical: 6.w),
                        ProfileDataCard(height: 24.w, title: 'Add Photo')
                      ],
                    ),
                    context: context);
                ctrl.update();
              },
              splashFactory: NoSplash.splashFactory,
              child: Assets.icons.menu.svg()),
          BottomBarWidget(
            title: 'Discovery',
            color: ctrl.isSelectedTab == 4 ? black_000000 : grey_969696,
            onTap: () {
              ctrl.isSelectedTab = 4;
              ctrl.changeTab(BottomNavEnum.discovery);
              ctrl.update();
            },
          ),
          BottomBarWidget(
            title: 'Profile',
            color: ctrl.isSelectedTab == 5 ? black_000000 : grey_969696,
            onTap: () {
              ctrl.isSelectedTab = 5;
              ctrl.changeTab(BottomNavEnum.profile);
              ctrl.update();
            },
          ),
        ],
      ),
    );
  }
}
