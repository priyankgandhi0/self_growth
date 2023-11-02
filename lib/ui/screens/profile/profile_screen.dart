import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/config/routes/router.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/app_helper.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/core/utils/preferences.dart';
import 'package:self_growth/gen/assets.gen.dart';
import 'package:self_growth/ui/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:self_growth/ui/widgets/app_button.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/request_const.dart';
import '../../widgets/app_dialogs.dart';
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
            widget: preferences.getString(SharedPreference.USER_NAME) != null
                ? commonCachedNetworkImage(
                    imageUrl:
                        '${ImageBaseUrl.PROFILEIMAGEURL}${preferences.getString(SharedPreference.USER_PROFILE)}' ??
                            "",
                    height: 100.w,
                    width: 100.w,
                  )
                : (Assets.icons.profile)
                    .svg(height: 100.w, width: 100.w, fit: BoxFit.contain),
            child: Column(
              children: [
                40.w.spaceH(),
                '${preferences.getString(SharedPreference.USER_NAME)}'
                    .appSwitzerTextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.w600),
                '${preferences.getString(SharedPreference.USER_EMAIL)}'
                    .appSwitzerTextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w400),
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
                          horizontal: 20.w, vertical: 11.w),
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
                          title: ctrl.profileList[index],
                          image: ctrl.imagePath[index],
                        ).paddingSymmetric(vertical: 11.w);
                      },
                      separatorBuilder: (context, index) {
                        return const CommonDivider();
                      },
                      itemCount: ctrl.profileList.length))
              .paddingSymmetric(horizontal: 20.w, vertical: 16.w),
          Container(
            height: 40.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w), color: white_FFFFFF),
            child: ProfileDataCard(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                      description: logOutDialogText,
                      title: logOutText,
                      onConfirm: () {
                        Get.offAllNamed(Routes.onboarding);
                      },
                      textCancel: 'No',
                      textConfirm: 'Yes',
                      onCancel: () {
                        Get.back();
                      },
                    );
                  },
                );
              },
              image: Assets.icons.logOut.path,
              title: 'Logout',
            ).paddingSymmetric(vertical: 8.w, horizontal: 20.w),
          ).paddingSymmetric(
            horizontal: 20.w,
          ),
          89.w.spaceH(),
        ],
      );
    });
  }
}
