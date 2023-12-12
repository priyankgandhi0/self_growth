import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';

import '../../../config/routes/router.dart';
import '../../../core/utils/preferences.dart';
import '../../../gen/assets.gen.dart';
import '../../../languages/all_strings.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/common_widget.dart';

class ProfileController extends GetxController {
  List<String> profileList = [
   LanguageGlobalVar.mySubscription.tr,
   LanguageGlobalVar.reminder.tr,
   LanguageGlobalVar.privacyAndPolicy.tr,
   LanguageGlobalVar.importantNumbers.tr,
   LanguageGlobalVar.language.tr,
  ];
onTap(int index){
  if (index == 0) {
    Get.toNamed(Routes.subscriptionScreen);
  }
  if (index == 1) {
    Get.toNamed(Routes.reminderScreen);
  }
  if (index == 4) {
    appDialog(
        contentWidget: Column(
          children: [
            30.w.spaceH(),
            ProfileDataCard(
              image: Assets.icons.lang.path,
              height: 20.w,
              title: 'Arabic',
              onTap: () {
                Get.back();
                Get.updateLocale(
                    const Locale("ar", "AE"));

              },
            ),
            5.w.spaceH(),
            const CommonDivider()
                .paddingSymmetric(vertical: 8.w),
            5.w.spaceH(),
            ProfileDataCard(
              image: Assets.icons.lang.path,
              height: 20.w,
              title: 'English',
              onTap: () {
                Get.back();
                Get.updateLocale(
                    const Locale("en", "US"));

              },
            ),
          ],
        ).paddingSymmetric(
            horizontal: 12.w, vertical: 20.w));
  }
}
  List<String> imagePath = [
    Assets.icons.mySubscription.path,
    Assets.icons.bell.path,
    Assets.icons.privacy.path,
    Assets.icons.impNumber.path,
    Assets.icons.lang.path,
  ];

  logOut() {
    preferences.clearUserItem();
    preferences.putBool(SharedPreference.IS_LOG_IN, false);
    Get.offAllNamed(Routes.onboarding);
    showAppSnackBar('Logout Successfully.', status: true);
  }
}
