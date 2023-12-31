import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/config/routes/router.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/app_helper.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/gen/assets.gen.dart';
import 'package:self_growth/ui/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:self_growth/ui/screens/profile/subscription/subscription_screen.dart';
import 'package:self_growth/ui/widgets/app_button.dart';

import '../../../core/constants/app_strings.dart';
import '../../widgets/common_widget.dart';
import '../bottom_navigation/bottom_bar_controller.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());
  final BottomBarController bottomBarController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (ctrl) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.spaceH(),
          ProfileBoxCard(
            child: Column(
              children: [
                40.w.spaceH(),
                'John Doe'
                    .appTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                'john@email.com · 29y'
                    .appTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                16.w.spaceH(),
                BorderButton(
                  width: 100.w,
                  title: editProfileText,
                  onTap: () {
                    bottomBarController.changeTab(BottomNavEnum.other);
                    bottomBarController.isSelectedTab = 5;
                    bottomBarController.tab = EditProfileScreen();
                  },
                )
              ],
            ).paddingSymmetric(vertical: 20.w),
          ),
          Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                      color: white_FFFFFF),
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.w),
                      itemBuilder: (context, index) {
                        return ProfileDataCard(
                                onTap: () {
                                  if (index == 0) {
                                    Get.toNamed(Routes.subscriptionScreen);
                                  }
                                  if (index == 1) {
                                    Get.toNamed(Routes.reminderScreen);
                                  }
                                },
                                title: ctrl.profileList[index])
                            .paddingSymmetric(vertical: 8.w);
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 0.4.w,
                          color: grey_969696.withOpacity(.5),
                        );
                      },
                      itemCount: ctrl.profileList.length))
              .paddingSymmetric(horizontal: 20.w, vertical: 16.w),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w), color: white_FFFFFF),
            child: const ProfileDataCard(
              title: 'Logout',
            ).paddingSymmetric(vertical: 8.w, horizontal: 20.w),
          ).paddingSymmetric(
            horizontal: 20.w,
          )
        ],
      );
    });
  }
}
