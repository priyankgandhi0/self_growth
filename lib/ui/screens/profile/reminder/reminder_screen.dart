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
import '../../../widgets/common_widget.dart';

class ReminderScreen extends StatelessWidget {
  ReminderScreen({Key? key}) : super(key: key);
  final ReminderController reminderController = Get.put(ReminderController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReminderController>(builder: (ctrl) {
      return Scaffold(
        body: Column(
          children: [
            const AppTitleBar(
              titleText: reminder,
              backGroundColor: background_EBEBEB,
              centerTitle: true,
            ),
            24.w.spaceH(),
            Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.w),
                        color: white_FFFFFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reminderCard(ctrl),
                        12.w.spaceH(),
                        '8:25 PM'.appTextStyle(
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
                        reminderCard(ctrl),
                        12.w.spaceH(),
                        '8:00 AM - 5:00 PM'.appTextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w600),
                        20.w.spaceH(),
                        Row(
                          children: [
                            Assets.icons.reduce.svg(),
                            const Spacer(),
                            '5x '.appTextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                            reminder.appTextStyle(
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
      );
    });
  }

  Row reminderCard(ReminderController ctrl) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            checkInReminder.appTextStyle(
                fontWeight: FontWeight.w600, fontSize: 14.sp),
            enabled.appTextStyle(fontWeight: FontWeight.w400, fontSize: 13.sp)
          ],
        ),
        const Spacer(),
        CommonSwitch(
          mainAxisAlignment: ctrl.switchValue
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          onTap: () {
            ctrl.switchValue = !ctrl.switchValue;
            ctrl.update();
          },
        )
      ],
    );
  }
}
