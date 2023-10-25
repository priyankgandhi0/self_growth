import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/habit_module/habbit_controller.dart';
import 'package:self_growth/ui/widgets/app_chip.dart';
import 'package:self_growth/ui/widgets/app_switch.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';

class CreateNewHabitScreen extends StatelessWidget {
  CreateNewHabitScreen({Key? key}) : super(key: key);
  HabitController habitController = Get.put(HabitController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.backGroundImage.path),
                fit: BoxFit.fill)),
        child: GetBuilder<HabitController>(builder: (ctrl) {
          return SingleChildScrollView(
            child: Column(
              children: [
                50.w.spaceH(),
                CommonAppBar(
                  icon: const Icon(Icons.close, color: borderPurpleColor),
                  title: newHabbit,
                  padding: 0,
                  onTap: () {
                    Get.back();
                  },
                ),
                20.w.spaceH(),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: white_FFFFFF,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.h.spaceH(),
                      AppTextField(
                        labelText: 'Habit name',
                        hintText: "Enter Habit Name",
                        validator: (value) {},
                      ),
                      16.h.spaceH(),
                      "Icon".appTextStyle(
                        fontWeight: FontWeight.w500,
                        fontColor: black_000000.withOpacity(0.7),
                        fontSize: 14.sp,
                        // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                      ),
                      12.h.spaceH(),
                      Wrap(
                        spacing: 10,
                        children: [
                          const IconCard(
                            title: "💼",
                          ),
                          const IconCard(
                            title: "🔥",
                          ),
                          const IconCard(
                            title: "⚽️",
                          ),
                          const IconCard(
                            title: "🪁",
                          ),
                          const IconCard(
                            title: "🏂",
                          ),
                          const IconCard(
                            title: "🥇",
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: black_000000.withOpacity(0.1))),
                            child: const Center(
                                child: Icon(
                              Icons.add,
                              size: 17,
                            )),
                          ),
                        ],
                      ),
                      12.h.spaceH(),
                      "Icon".appTextStyle(
                        fontWeight: FontWeight.w500,
                        fontColor: black_000000.withOpacity(0.7),
                        fontSize: 16.sp,
                        // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                      ),
                      12.h.spaceH(),
                      Wrap(
                        spacing: 10,
                        children: [
                          const IconColorCard(color: Color(0xff296BCF)),
                          const IconColorCard(color: Color(0xff3EBCD8)),
                          const IconColorCard(color: Color(0xff57A9D7)),
                          const IconColorCard(color: Color(0xffF67E7E)),
                          const IconColorCard(color: Color(0xffC36F6F)),
                          const IconColorCard(color: Color(0xff6AE09A)),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: black_000000.withOpacity(0.1))),
                            child: const Center(
                                child: Icon(
                              Icons.add,
                              size: 17,
                            )),
                          ),
                        ],
                      ),
                    ],
                  ).paddingAll(20),
                ),
                20.h.spaceH(),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: white_FFFFFF,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Goals".appTextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      16.h.spaceH(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: black_000000.withOpacity(0.1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                "1 times".appTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: Assets.fonts.switzerRegular),
                                "per day".appTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontColor: black_000000.withOpacity(0.5)),
                              ],
                            ),
                            Row(
                              children: [
                                const AppChip(title: 'Daily'),
                                12.w.spaceW(),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: borderPurpleColor,
                                  size: 17.sp,
                                )
                              ],
                            )
                          ],
                        ).paddingAll(12),
                      )
                    ],
                  ).paddingAll(20),
                ),
                20.h.spaceH(),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: white_FFFFFF,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Reminder".appTextStyle(),
                          AppSwitch(
                            value: ctrl.isRemind,
                            onChange: (value) {
                              ctrl.isRemind = value;
                              ctrl.update();
                            },
                          ).paddingOnly(top: 2.5)
                        ],
                      ).paddingOnly(bottom: 12),
                      16.h.spaceH(),
                      AppTextField(
                        labelText: 'Time',
                        hintText: 'Select Time',
                      ),
                      16.h.spaceH(),
                      AppTextField(
                        labelText: 'Note',
                        hintText: 'Add note',
                      ),
                    ],
                  ).paddingAll(20),
                ),
                20.h.spaceH(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: white_FFFFFF,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Advance Settings".appTextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                          // Transform.rotate(
                          // angle: math.pi / 0,
                          /*child:*/ const Icon(
                            Icons.keyboard_arrow_up,
                            size: 30,
                            // ),
                          )
                        ],
                      ).paddingOnly(bottom: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.h.spaceH(),
                          "Add to Group".appTextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          8.h.spaceH(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: black_000000.withOpacity(0.1))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "No Group".appTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    "Habit group".appTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontColor:
                                            black_000000.withOpacity(0.5)),
                                  ],
                                ),
                                const AppChip(title: 'Add Group'),
                              ],
                            ).paddingAll(12),
                          ),
                          16.h.spaceH(),
                          "Habit Type".appTextStyle(
                            fontWeight: FontWeight.w500,
                            fontColor: black_000000.withOpacity(0.7),
                            fontSize: 14.sp,
                            // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                          ),
                          12.h.spaceH(),
                          Row(
                            children: [
                              ButtonCommon(
                                isSelected: ctrl.isHabitTypeBuild == 0,
                                title: 'Build',
                                onTap: () {
                                  ctrl.isHabitTypeBuild = 0;
                                  ctrl.update();
                                },
                              ),
                              10.w.spaceW(),
                              ButtonCommon(
                                isSelected: ctrl.isHabitTypeBuild == 1,
                                title: 'Quit',
                                onTap: () {
                                  ctrl.isHabitTypeBuild = 1;
                                  ctrl.update();
                                },
                              ),
                            ],
                          ),
                          16.h.spaceH(),
                          "Log Activity Using".appTextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          12.h.spaceH(),
                          Row(
                            children: [
                              ButtonCommon(
                                isSelected: ctrl.isLogActivity == 0,
                                title: 'Fixed Count',
                                onTap: () {
                                  ctrl.isLogActivity = 0;
                                  ctrl.update();
                                },
                              ),
                              10.w.spaceW(),
                              ButtonCommon(
                                isSelected: ctrl.isLogActivity == 1,
                                title: 'Custom',
                                onTap: () {
                                  ctrl.isLogActivity = 1;
                                  ctrl.update();
                                },
                              ),
                            ],
                          ),
                          12.h.spaceH(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const IconCard(
                                  icon: Icon(
                                    Icons.remove,
                                    size: 18,
                                  ),
                                  title: '-'),
                              Row(
                                children: [
                                  "+1".appTextStyle(
                                      fontColor: black_000000,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  " per tap".appTextStyle(
                                      fontColor: black_000000.withOpacity(0.5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              const IconCard(
                                  icon: Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                  title: '+')
                            ],
                          ).paddingSymmetric(vertical: 8),
                          16.h.spaceH(),
                          SwitchBoxLisTile(
                            title: 'Show badge if no activity today',
                            value: ctrl.isShowBadge,
                            onChange: (value) {
                              ctrl.isShowBadge = value;
                              ctrl.update();
                            },
                          ),
                          16.h.spaceH(),
                          SwitchBoxLisTile(
                            title: 'Show goal in line chart',
                            value: ctrl.isShowGoal,
                            onChange: (value) {
                              ctrl.isShowGoal = value;
                              ctrl.update();
                            },
                          ),
                          16.h.spaceH(),
                          "Apple health integration".appTextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          8.h.spaceH(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: doteColor.withOpacity(0.3))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: "Sleep hours"
                                      .appTextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700)
                                      .paddingSymmetric(vertical: 12.w),
                                ),
                              ],
                            ),
                          ),
                          16.h.spaceH(),
                          AppTextField(
                            labelText: "Add Note",
                            hintText: "Add note",
                          )
                        ],
                      )
                    ],
                  ).paddingAll(20),
                ),
                20.h.spaceH(),
              ],
            ).paddingSymmetric(horizontal: 16),
          );
        }),
      ),
    );
  }
}

class ButtonCommon extends StatelessWidget {
  const ButtonCommon(
      {Key? key, required this.title, this.onTap, required this.isSelected})
      : super(key: key);
  final String title;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48.w,
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(color: grey_C4C4C4.withOpacity(.5)),
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                      image: AssetImage(Assets.images.con.path),
                      fit: BoxFit.fill))
              : BoxDecoration(
                  border: Border.all(color: grey_C4C4C4.withOpacity(.5)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
          child: Center(
              child: title.appTextStyle(
                  fontColor: isSelected ? borderPurpleColor : doteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    required this.title,
    this.icon,
  });
  final String title;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderPurpleColor.withOpacity(0.1))),
      child: Center(
          child: icon ??
              title.appTextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }
}

class IconColorCard extends StatelessWidget {
  const IconColorCard({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.1))),
    );
  }
}

class SwitchBoxLisTile extends StatelessWidget {
  const SwitchBoxLisTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChange,
  });
  final String title;
  final bool value;
  final Function(bool) onChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: title.appTextStyle(
              fontSize: 14,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
              fontColor: black_000000.withOpacity(0.7)),
        ),
        AppSwitch(value: value, onChange: onChange)
      ],
    );
  }
}
