import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/profile/reminder/reminder_con.dart';
import 'package:self_growth/ui/widgets/app_button.dart';
import 'package:self_growth/ui/widgets/app_dialogs.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../languages/all_strings.dart';
import '../../../widgets/app_switch.dart';
import '../../../widgets/start_up_text_field.dart';

class ReminderScreen extends StatelessWidget {
  ReminderScreen({Key? key}) : super(key: key);
  final ReminderController reminderController = Get.put(ReminderController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReminderController>(builder: (ctrl) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: InkWell(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            addReminderDialog(ctrl);
          },
          child: CircleAvatar(
            radius: 25.r,
            backgroundColor: borderPurpleColor,
            child: const Icon(Icons.add, color: white_FFFFFF),
          ),
        ),
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.images.backGroundImage.path),
                  fit: BoxFit.fill)),
          child: SafeArea(
            child: Column(
              children: [
                10.w.spaceH(),
                CommonAppBar(
                  title: LanguageGlobalVar.reminder.tr,
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
                                InkWell(
                                    onTap: () {
                                      ctrl.removeFunction();
                                    },
                                    highlightColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    child: Assets.icons.reduce.svg()),
                                const Spacer(),
                                '${ctrl.valuePerTap}x '.appSwitzerTextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                                LanguageGlobalVar.reminder.tr.appSwitzerTextStyle(
                                    fontSize: 14.sp,
                                    fontColor: grey_D9D9D9,
                                    fontWeight: FontWeight.w500),
                                const Spacer(),
                                InkWell(
                                    onTap: () {
                                      ctrl.addFunction();
                                    },
                                    highlightColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    child: Assets.icons.add.svg()),
                              ],
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 16.w, vertical: 12.w))
                    .paddingSymmetric(horizontal: 20.w),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<Object?> addReminderDialog(ReminderController ctrl) {
    return appDialog(
      contentWidget: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: white_FFFFFF,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              "Reminder"
                  .appSwitzerTextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17.sp)
                  .paddingOnly(bottom: 12),
              16.h.spaceH(),
              AppTextField(
                readOnly: true,
                labelText: 'Time',
                hintText: 'Select Time',
                textEditingController:
                    TextEditingController(text: ctrl.startTime),
                onTap: () {
                  pickedTime(context).then((value) {
                    final now = DateTime.now();
                    ctrl.reminderUtcTime =
                        '${DateTime(now.year, now.month, now.day, value.hour, value.minute).toUtc().hour}:${DateTime(now.year, now.month, now.day, value.hour, value.minute).toUtc().minute}';
                    ctrl.startTime = value.format(context).toString();
                    ctrl.update();
                    setState(() {});
                  });
                },
              ),
              16.h.spaceH(),
              AppTextField(
                labelText: 'Note',
                textEditingController: ctrl.noteCon,
                hintText: 'Add note',
              ).paddingOnly(bottom: 20),
              RoundAppButton(
                title: 'Add Reminder',
                onTap: () {
                  ctrl.addReminder();
                },
              )
            ],
          ).paddingAll(20),
        );
      }),
    );
  }

  Row reminderCard(ReminderController ctrl,
      {required dynamic Function(bool) onChange, required bool value}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LanguageGlobalVar.checkInReminder.tr.appSwitzerTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              fontFamily: 'Switzer',
            ),
            LanguageGlobalVar.enabled.tr.appSwitzerTextStyle(
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
