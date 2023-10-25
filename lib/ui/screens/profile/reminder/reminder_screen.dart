import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/profile/reminder/reminder_con.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/app_switch.dart';
import '../../../widgets/common_widget.dart';

class ReminderScreen extends StatelessWidget {
  ReminderScreen({Key? key}) : super(key: key);
  final ReminderController reminderController = Get.put(ReminderController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReminderController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.images.backGroundImage.path),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              45.w.spaceH(),
              CommonAppBar(
                title: reminder,
                onTap: () {
                  Get.back();
                },
              ),
              24.w.spaceH(),
              Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: white_FFFFFF),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reminderCard(ctrl, value: ctrl.switchValue,
                              onChange: (val) {
                            ctrl.switchValue = val;
                            ctrl.update();
                          }),
                          12.w.spaceH(),
                          '8:25 PM'.appSwitzerTextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600)
                        ],
                      ).paddingSymmetric(horizontal: 16.w, vertical: 12.w))
                  .paddingSymmetric(horizontal: 20.w),
              16.w.spaceH(),
              Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: white_FFFFFF),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reminderCard(ctrl, onChange: (val) {
                            ctrl.switchValue1 = val;
                            ctrl.update();
                          }, value: ctrl.switchValue1),
                          12.w.spaceH(),
                          '8:00 AM - 5:00 PM'.appSwitzerTextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600),
                          20.w.spaceH(),
                          Row(
                            children: [
                              Assets.icons.reduce.svg(),
                              const Spacer(),
                              '5x '.appSwitzerTextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w500),
                              reminder.appSwitzerTextStyle(
                                  fontSize: 14.sp,
                                  fontColor: grey_D9D9D9,
                                  fontWeight: FontWeight.w500),
                              const Spacer(),
                              Assets.icons.add.svg(),
                            ],
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16.w, vertical: 12.w))
                  .paddingSymmetric(horizontal: 20.w),
            ],
          ),
        ),
      );
    });
  }

  Row reminderCard(ReminderController ctrl,
      {required dynamic Function(bool) onChange, required bool value}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            checkInReminder.appSwitzerTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              fontFamily: 'Switzer',
            ),
            enabled.appSwitzerTextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
                fontFamily: 'Switzer',
                fontColor: doteColor)
          ],
        ),
        const Spacer(),
        AppSwitch(value: value, onChange: onChange),
      ],
    );
  }
}
