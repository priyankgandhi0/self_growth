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

class CreateNewHabitScreen extends StatelessWidget {
  CreateNewHabitScreen({Key? key}) : super(key: key);
  HabitController habitController = Get.put(HabitController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
          titleText: 'New Habit',
          fontSize: 20.sp,
          isHome: true,
          leadingWidget: const Icon(Icons.close),
          fontWeight: FontWeight.w700,
          centerTitle: true,
          backgroundColor: Colors.transparent),
      body: GetBuilder<HabitController>(builder: (ctrl) {
        return SingleChildScrollView(
          child: Column(
            children: [
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
                    "Habit Type".appTextStyle(
                      fontWeight: FontWeight.w500,
                      fontColor: black_000000.withOpacity(0.7),
                      fontSize: 14.sp,
                      // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                    ),
                    12.h.spaceH(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: black_000000.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Material(
                              color: ctrl.isHabitTypeBuild
                                  ? background_F0F2F9
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  ctrl.isHabitTypeBuild = true;

                                  ctrl.update();
                                },
                                child: "Build"
                                    .appTextStyle(
                                        fontColor: black_000000.withOpacity(
                                            ctrl.isHabitTypeBuild ? 1 : 0.5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)
                                    .paddingAll(16),
                              ),
                            ),
                          ),
                        ),
                        10.w.spaceW(),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: ctrl.isHabitTypeBuild
                                    ? Colors.transparent
                                    : background_F0F2F9,
                                border: Border.all(
                                  color: black_000000.withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Material(
                              color: ctrl.isHabitTypeBuild
                                  ? Colors.transparent
                                  : background_F0F2F9,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  ctrl.isHabitTypeBuild = false;
                                  ctrl.update();
                                },
                                child: "Quit"
                                    .appTextStyle(
                                        fontColor: black_000000.withOpacity(
                                            ctrl.isHabitTypeBuild ? 0.5 : 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)
                                    .paddingAll(16),
                              ),
                            ),
                          ),
                        )
                      ],
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
                        IconCard(
                          title: "💼",
                        ),
                        IconCard(
                          title: "🔥",
                        ),
                        IconCard(
                          title: "⚽️",
                        ),
                        IconCard(
                          title: "🪁",
                        ),
                        IconCard(
                          title: "🏂",
                        ),
                        IconCard(
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
                        fontSize: 17, fontWeight: FontWeight.w600),
                    16.h.spaceH(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: black_000000.withOpacity(0.1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              "1 times".appTextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
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
                              const Icon(Icons.arrow_forward_ios_outlined)
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
                                      fontColor: black_000000.withOpacity(0.5)),
                                ],
                              ),
                              Row(
                                children: [
                                  const AppChip(title: 'Add Group'),
                                  12.w.spaceW(),
                                  const Icon(Icons.arrow_forward_ios_outlined)
                                ],
                              )
                            ],
                          ).paddingAll(12),
                        ),
                        16.h.spaceH(),
                        "Log Activity Using".appTextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        12.h.spaceH(),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: black_000000.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Material(
                                  color: ctrl.isHabitTypeBuild
                                      ? background_F0F2F9
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      ctrl.isHabitTypeBuild = true;

                                      ctrl.update();
                                    },
                                    child: "Fixed Count"
                                        .appTextStyle(
                                            fontColor: black_000000.withOpacity(
                                                ctrl.isHabitTypeBuild
                                                    ? 1
                                                    : 0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)
                                        .paddingAll(15),
                                  ),
                                ),
                              ),
                            ),
                            10.w.spaceW(),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ctrl.isHabitTypeBuild
                                        ? Colors.transparent
                                        : background_F0F2F9,
                                    border: Border.all(
                                      color: black_000000.withOpacity(0.1),
                                    ),
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Material(
                                  color: ctrl.isHabitTypeBuild
                                      ? Colors.transparent
                                      : background_F0F2F9,
                                  borderRadius: BorderRadius.circular(8),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      ctrl.isHabitTypeBuild = false;
                                      ctrl.update();
                                    },
                                    child: "Custom"
                                        .appTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontColor: black_000000.withOpacity(
                                                ctrl.isHabitTypeBuild
                                                    ? 0.5
                                                    : 1))
                                        .paddingAll(15),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        12.h.spaceH(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconCard(
                                icon: const Icon(
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
                            IconCard(
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
                          value: false,
                          onChange: (value) {},
                        ),
                        16.h.spaceH(),
                        SwitchBoxLisTile(
                          title: 'Show goal in line chart',
                          value: false,
                          onChange: (value) {},
                        ),
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
                            children: [
                              Expanded(
                                child: "Sleep hours"
                                    .appTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)
                                    .paddingSymmetric(vertical: 12),
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
    );
  }
}

class IconCard extends StatelessWidget {
  IconCard({
    super.key,
    required this.title,
    this.icon,
  });
  final String title;
  Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: black_000000.withOpacity(0.1))),
      child: Center(child: icon ?? title.appTextStyle(fontSize: 14)),
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
