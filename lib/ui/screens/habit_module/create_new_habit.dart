import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/habit_module/habbit_controller.dart';
import 'package:self_growth/ui/widgets/app_chip.dart';
import 'package:self_growth/ui/widgets/app_loader.dart';
import 'package:self_growth/ui/widgets/app_snack_bar.dart';
import 'package:self_growth/ui/widgets/app_switch.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_dialogs.dart';

class CreateNewHabitScreen extends StatelessWidget {
  CreateNewHabitScreen({Key? key}) : super(key: key);
  final HabitController habitController = Get.put(HabitController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.backGroundImage.path),
                    fit: BoxFit.fill)),
            child: GetBuilder<HabitController>(builder: (ctrl) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      10.w.spaceH(),
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
                            8.w.spaceH(),
                            AppTextField(
                              labelText: 'Habit name',
                              textEditingController: ctrl.habitNameCon,
                              hintText: "Enter Habit Name",
                              validator: (value) {},
                            ),
                            16.w.spaceH(),
                            "Icon".appSwitzerTextStyle(
                              fontWeight: FontWeight.w500,
                              fontColor: black_000000.withOpacity(0.7),
                              fontSize: 14.sp,
                              // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                            ),
                            12.w.spaceH(),
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 10.w,
                              children: List.generate(
                                  ctrl.iconList.length + 1,
                                  (index) => ctrl.iconList.length == index
                                      ? IconCard(
                                          onTap: () {
                                            openColorPickerDialog(
                                              isShowButton: false,
                                              content: SizedBox(
                                                height: 300.w,
                                                width: Get.width,
                                                child: emojiPickerCard(
                                                    onTap: (category, emoji) {
                                                  if (ctrl.iconList
                                                      .contains(emoji.emoji)) {
                                                    showAppSnackBar(
                                                        'Already selected.');
                                                  } else {
                                                    Get.back();
                                                    ctrl.iconList
                                                        .add(emoji.emoji);
                                                  }

                                                  ctrl.update();
                                                }),
                                              ),
                                              title: 'Select Icon',
                                              context: context,
                                            );
                                          },
                                          icon: Icon(Icons.add,
                                              size: 17.sp,
                                              color: borderPurpleColor),
                                          selected: false,
                                          title: '',
                                        )
                                      : IconCard(
                                          onTap: () {
                                            if (ctrl.iconSelectedList
                                                .contains(index)) {
                                              ctrl.iconSelectedList
                                                  .remove(index);
                                            } else {
                                              ctrl.iconSelectedList.add(index);
                                            }
                                            ctrl.update();
                                          },
                                          title: ctrl.iconList[index],
                                          selected: ctrl.iconSelectedList
                                              .contains(index),
                                        )),
                            ),
                            12.h.spaceH(),
                            "Icon Color".appSwitzerTextStyle(
                              fontWeight: FontWeight.w500,
                              fontColor: black_000000.withOpacity(0.7),
                              fontSize: 14.sp,
                              // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                            ),
                            12.w.spaceH(),
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 10.w,
                              children: List.generate(
                                  ctrl.colorList.length + 1,
                                  (index) => ctrl.colorList.length == index
                                      ? IconCard(
                                          onTap: () {
                                            openColorPickerDialog(
                                              content: MaterialColorPicker(
                                                colors: fullMaterialColors,
                                                circleSize: 40.r,
                                                selectedColor:
                                                    ctrl.tempMainColor,
                                                onColorChange: (value) {
                                                  ctrl.tempMainColor = value;
                                                  ctrl.update();
                                                },
                                              ),
                                              title: 'Select Color',
                                              context: context,
                                              onSubmit: () {
                                                Get.back();
                                                if (ctrl.colorList.contains(
                                                    ctrl.tempMainColor)) {
                                                  showAppSnackBar(
                                                      'Already selected.');
                                                } else {
                                                  ctrl.colorList
                                                      .add(ctrl.tempMainColor);
                                                }

                                                ctrl.update();
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.add,
                                              size: 17.sp,
                                              color: borderPurpleColor),
                                          selected: false,
                                          title: '',
                                        )
                                      : IconColorCard(
                                          color: ctrl.colorList[index] ??
                                              borderPurpleColor,
                                        )),
                            ),
                          ],
                        ).paddingAll(20.w),
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
                            "Goals".appSwitzerTextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            16.h.spaceH(),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Assets.images.card.path),
                                    fit: BoxFit.fill),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      "1 times".appSwitzerTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Switzer'),
                                      "per day".appSwitzerTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontColor: doteColor),
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
                                "Reminder".appSwitzerTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp),
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
                              readOnly: true,
                              labelText: 'Time',
                              hintText: 'Select Time',
                              textEditingController:
                                  TextEditingController(text: ctrl.startTime),
                              onTap: () {
                                pickedTime(context).then((value) {
                                  ctrl.startTime =
                                      value.format(context).toString();
                                  ctrl.update();
                                });
                              },
                            ),
                            16.h.spaceH(),
                            const AppTextField(
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
                                "Advance Settings".appSwitzerTextStyle(
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
                                /*  16.h.spaceH(),
                                "Add to Group".appSwitzerTextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                8.h.spaceH(),
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(Assets.images.card.path),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          "No Group".appSwitzerTextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          "Habit group".appSwitzerTextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontColor: doteColor),
                                        ],
                                      ),
                                      const AppChip(title: 'Add Group'),
                                    ],
                                  ).paddingAll(12),
                                ),*/
                                // 16.h.spaceH(),
                                "Habit Type".appSwitzerTextStyle(
                                  fontWeight: FontWeight.w500,

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
                                "Log Activity Using".appSwitzerTextStyle(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconCard(
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 18,
                                        ),
                                        onTap: () {
                                          ctrl.removeFunction();
                                        },
                                        title: '-'),
                                    Row(
                                      children: [
                                        "+${ctrl.valuePerTap}"
                                            .appSwitzerTextStyle(
                                                fontColor: borderPurpleColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                        " per tap".appSwitzerTextStyle(
                                            fontColor: doteColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    IconCard(
                                        icon: const Icon(
                                          Icons.add,
                                          size: 18,
                                        ),
                                        onTap: () {
                                          ctrl.addFunction();
                                        },
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
                                "Apple health integration".appSwitzerTextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                8.h.spaceH(),
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(Assets.images.card.path),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: "Sleep hours"
                                            .appSwitzerTextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700)
                                            .paddingSymmetric(vertical: 12.w),
                                      ),
                                    ],
                                  ),
                                ),
                                16.h.spaceH(),
                                const AppTextField(
                                  labelText: "Add Note",
                                  hintText: "Add note",
                                )
                              ],
                            )
                          ],
                        ).paddingAll(20),
                      ),
                      20.h.spaceH(),
                      RoundAppButton(
                          title: 'Add Habit',
                          onTap: () {
                            ctrl.addHabit();
                          }).paddingSymmetric(horizontal: 20.w, vertical: 20.w),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                ),
              );
            }),
          ),
          Obx(() => habitController.isLoading.value
              ? const AppProgress()
              : const SizedBox())
        ],
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
                  image: DecorationImage(
                      image: AssetImage(Assets.images.card.path),
                      fit: BoxFit.fill),
                ),
          child: Center(
              child: title.appSwitzerTextStyle(
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
    this.selected,
    this.onTap,
    this.isHome,
  });
  final String title;
  final Widget? icon;
  final bool? isHome;
  final bool? selected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: isHome ?? false
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderPurpleColor))
            : BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(selected ?? false
                        ? Assets.images.cirFill.path
                        : Assets.images.cirBorder.path))),
        child: Center(
            child: icon ??
                title
                    .appSwitzerTextStyle(
                        textAlign: TextAlign.center,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500)
                    .paddingOnly(left: 1.w)),
      ),
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
        image: DecorationImage(image: AssetImage(Assets.images.cirBorder.path)),
      ),
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
          child: title.appSwitzerTextStyle(
              fontSize: 14,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
              fontColor: borderPurpleColor.withOpacity(0.7)),
        ),
        AppSwitch(value: value, onChange: onChange)
      ],
    );
  }
}

EmojiPicker emojiPickerCard({void Function(Category?, Emoji)? onTap}) {
  return EmojiPicker(
    onEmojiSelected: onTap,
    textEditingController:
        TextEditingController(), // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
    config: Config(
      columns: 7,

      emojiSizeMax:
          20.w, // Issue: https://github.com/flutter/flutter/issues/28894
      verticalSpacing: 0,
      horizontalSpacing: 0,
      gridPadding: EdgeInsets.zero,

      initCategory: Category.RECENT,
      bgColor: Colors.transparent,

      indicatorColor: borderPurpleColor,
      iconColor: borderPurpleColor,
      iconColorSelected: borderPinkColor,
      backspaceColor: borderPurpleColor,
      skinToneDialogBgColor: Colors.white,
      skinToneIndicatorColor: Colors.grey,
      enableSkinTones: true,

      recentTabBehavior: RecentTabBehavior.NONE,
      loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL,
    ),
  );
}
