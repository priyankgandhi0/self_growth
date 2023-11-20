import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/models/get_user_mood_model.dart';
import 'package:self_growth/ui/screens/add_photo/add_photo_controller.dart';
import 'package:self_growth/ui/screens/voice_note/voice_note_con.dart';

import 'package:self_growth/ui/widgets/app_button.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../../../config/routes/router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/request_const.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../models/add_photo_model.dart';
import '../../../widgets/app_dialogs.dart';
import '../../../widgets/app_loader.dart';
import '../../../widgets/audio_player.dart';
import '../../../widgets/common_widget.dart';
import '../../habit_module/create_new_habit.dart';
import 'mood_checking_con.dart';

class MoodCheckingScreen extends StatelessWidget {
  MoodCheckingScreen({Key? key}) : super(key: key);
  final MoodCheckingCon moodCheckingCon = Get.put(MoodCheckingCon());
  final VoiceNoteController voiceNoteController =
      Get.put(VoiceNoteController());
  final AddPhotoController addPhotoController = Get.put(AddPhotoController());

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
            child: SingleChildScrollView(
              child: GetBuilder<MoodCheckingCon>(initState: (state) {
                moodCheckingCon.getFeelingList();
                moodCheckingCon.getActivityList();
              }, builder: (ctrl) {
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                              onTap: () {
                                Get.back();
                              },
                              splashFactory: NoSplash.splashFactory,
                              child: const Icon(Icons.close))
                          .paddingSymmetric(horizontal: 20.w),
                      ProfileBoxCard(
                        widget: (ctrl.sliderValue < 50.0
                                ? Assets.icons.unHappy
                                : (ctrl.sliderValue >= 50.0 &&
                                        ctrl.sliderValue < 75.0)
                                    ? Assets.icons.normal
                                    : Assets.icons.happyIcon)
                            .svg(),
                        child: Column(
                          children: [
                            40.w.spaceH(),
                            'How do you feel?'.appSwitzerTextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20.sp),
                            12.w.spaceH(),
                            ButtonCard(
                              onTap: () {
                                pickDateDialog(context: context).then((value) {
                                  log('value--$value');
                                  ctrl.selectedDate = value;
                                  ctrl.update();
                                });
                              },
                              title: ctrl.selectedDate
                                  .timeDifferenceForChatListGroup(),
                              icon: Assets.icons.dateRange.svg(),
                            ),
                            24.w.spaceH(),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    5,
                                    (index) => CircleAvatar(
                                      backgroundColor: (ctrl.sliderValue >= 0 &&
                                                  index == 0) ||
                                              (ctrl.sliderValue >= 25 &&
                                                  (index == 1 || index == 0)) ||
                                              (ctrl.sliderValue >= 50 &&
                                                  (index == 1 ||
                                                      index == 0 ||
                                                      index == 2)) ||
                                              (ctrl.sliderValue >= 75 &&
                                                  (index == 1 ||
                                                      index == 0 ||
                                                      index == 2 ||
                                                      index == 3))
                                          ? borderPurpleColor
                                          : grey_D9D9D9,
                                      radius: 6.r,
                                    ),
                                  ),
                                ).paddingSymmetric(horizontal: 20.w),
                                SizedBox(
                                  height: 20,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 9.r,
                                          elevation: 0.0),
                                    ),
                                    child: Slider(
                                      min: 0.0,
                                      max: 100.0,
                                      inactiveColor: grey_D9D9D9,
                                      activeColor: borderPurpleColor,
                                      onChanged: (value) {
                                        ctrl.sliderValue = value;
                                        ctrl.update();
                                      },
                                      value: ctrl.sliderValue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'Unhappy'.appSwitzerTextStyle(
                                  fontColor: doteColor,
                                  fontSize: 13.sp,
                                ),
                                'Normal'.appSwitzerTextStyle(
                                  fontColor: doteColor,
                                  fontSize: 13.sp,
                                ),
                                'Happy'.appSwitzerTextStyle(
                                  fontColor: doteColor,
                                  fontSize: 13.sp,
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 20.w)
                          ],
                        ).paddingSymmetric(horizontal: 24.w, vertical: 24.w),
                      ),
                      Get.find<VoiceNoteController>().audioPath == null &&
                              Get.find<AddPhotoController>().imagePath == null
                          ? Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.w),
                                      color: white_FFFFFF),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      'How was your day?'.appSwitzerTextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600),
                                      16.w.spaceH(),
                                      AppTextField(
                                        labelText: 'Title',
                                        textEditingController: ctrl.titleCon,
                                        hintText: 'Enter title',
                                      ),
                                      16.w.spaceH(),
                                      AppTextField(
                                        height: 100.w,
                                        textEditingController: ctrl.noteCon,
                                        labelText: 'Notes',
                                        maxLines: 4,
                                        hintText: 'Add note',
                                      )
                                    ],
                                  ).paddingSymmetric(
                                      horizontal: 16.w, vertical: 30.w))
                              .paddingSymmetric(
                                  horizontal: 20.w, vertical: 16.w)
                          : Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: white_FFFFFF),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Get.find<AddPhotoController>().imagePath !=
                                          null
                                      ? Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              color: white_FFFFFF),
                                          child: NoteCommonCard(
                                            showIcon: true,
                                            image:
                                                Assets.icons.imageCapture.path,
                                            title: ('Image Capture').toString(),
                                            time: DateFormat('hh:mm a')
                                                .format(DateTime.now()),
                                            fellingList: [],
                                            isImage: false,
                                            widget: AddImageCard(
                                              widget: Image.file(
                                                  Get.find<AddPhotoController>()
                                                      .imagePath!,
                                                  width: Get.width,
                                                  height: 140.w,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              color: white_FFFFFF),
                                          child: NoteCommonCard(
                                            image: Assets.icons.voice.path,
                                            showIcon: false,
                                            fellingList: [],
                                            title: ('Voice title').toString(),
                                            time: DateFormat('hh:mm a')
                                                .format(DateTime.now()),
                                            widget: Container(
                                              height: 69.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color: background_F5F5F5),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.w),
                                                child: AudioPlayer(
                                                  source: Get.find<
                                                          VoiceNoteController>()
                                                      .audioPath!
                                                      .path,
                                                  onDelete: () {
                                                    // ctrl.showPlayer =
                                                    // !ctrl.showPlayer;
                                                    ctrl.update();
                                                  },
                                                ),
                                              ),
                                            ).paddingAll(16.w),
                                          ),
                                        ),
                                ],
                              ),
                            ).paddingSymmetric(
                              horizontal: 20.w, vertical: 16.w),
                      FeelingCard(
                        buttonOnTap: () {
                          return appDialog(
                              contentWidget: addNewActivityCard(ctrl),
                              isAnimated: false);
                        },
                        buttonText: 'Add other activity',
                        title: 'What’s making your day unhappy?',
                        widget: List.generate(
                          ctrl.activityList.length,
                          (index) => FamilyCard(
                            title: ctrl.activityList[index].name.toString(),
                            widget: Container(
                              height: 24.w,
                              width: 24.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage(Assets.images.circle.path),
                                      fit: BoxFit.cover)),
                              child: Center(
                                child: Text('${ctrl.activityList[index].icon}',
                                        textAlign: TextAlign.center)
                                    .paddingOnly(left: 1.w),
                              ),
                            ),
                            isSelected: ctrl.unhappyReason.contains(
                                ctrl.activityList[index].id.toString()),
                            onTap: () {
                              if (ctrl.unhappyReason.contains(
                                  ctrl.activityList[index].id.toString())) {
                                ctrl.unhappyReason.remove(
                                    ctrl.activityList[index].id.toString());
                              } else {
                                ctrl.unhappyReason.add(
                                    ctrl.activityList[index].id.toString());
                              }
                              ctrl.update();
                            },
                          ),
                        ),
                      ),
                      16.w.spaceH(),
                      FeelingCard(
                        buttonOnTap: () {
                          return appDialog(
                              contentWidget: addNewFeelingCard(ctrl),
                              isAnimated: false);
                        },
                        buttonText: 'Add other feeling',
                        title: 'How are you feeling about this?',
                        widget: List.generate(
                          ctrl.feelingList.length,
                          (index) => FamilyCard(
                            title: ctrl.feelingList[index].name.toString(),
                            widget: Container(
                              height: 24.w,
                              width: 24.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage(Assets.images.circle.path),
                                      fit: BoxFit.cover)),
                              child: Center(
                                child: Text('${ctrl.feelingList[index].icon}',
                                        textAlign: TextAlign.center)
                                    .paddingOnly(left: 1.w),
                              ),
                            ),
                            isSelected: ctrl.howAreYouFeeling.contains(
                                ctrl.feelingList[index].id.toString()),
                            onTap: () {
                              if (ctrl.howAreYouFeeling.contains(
                                  ctrl.feelingList[index].id.toString())) {
                                ctrl.howAreYouFeeling.remove(
                                    ctrl.feelingList[index].id.toString());
                              } else {
                                ctrl.howAreYouFeeling
                                    .add(ctrl.feelingList[index].id.toString());
                              }

                              ctrl.update();
                            },
                          ),
                        ),
                      ),
                      40.w.spaceH(),
                      RoundAppButton(
                        onTap: () {
                          ctrl.moodChecking(
                              audioPath: voiceNoteController.audioPath,
                              moodImage: addPhotoController.imagePath);
                        },
                        title: 'Continue',
                      ).paddingSymmetric(horizontal: 40.w),
                      24.w.spaceH(),
                    ],
                  ).paddingSymmetric(vertical: 16.w),
                );
              }),
            ),
          ),
          Obx(() => moodCheckingCon.isLoading.value
              ? const AppProgress()
              : const SizedBox())
        ],
      ),
    );
  }

  StatefulBuilder addNewActivityCard(MoodCheckingCon ctrl) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          30.w.spaceH(),
          AppTextField(
            hintText: 'Selecte Emoji',
            readOnly: true,
            textEditingController:
                TextEditingController(text: ctrl.activityEmoji),
            onTap: () {
              openColorPickerDialog(
                isShowButton: false,
                content: SizedBox(
                  height: 300.w,
                  width: Get.width,
                  child: emojiPickerCard(
                    onTap: (category, emoji) {
                      setState(() {
                        ctrl.activityEmoji = emoji.emoji;
                      });
                      ctrl.update();
                      Get.back();
                    },
                  ),
                ),
                title: 'Select Icon',
                context: context,
              );
            },
          ),
          20.w.spaceH(),
          AppTextField(
            textEditingController: ctrl.addActivityCon,
            hintText: 'Activity name',
          ),
          20.w.spaceH(),
          RoundAppButton(
            title: 'Add Activity',
            onTap: () {
              ctrl.addActivity();
            },
          )
        ],
      ).paddingAll(20.w);
    });
  }

  StatefulBuilder addNewFeelingCard(MoodCheckingCon ctrl) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          30.w.spaceH(),
          AppTextField(
            hintText: 'Selecte Emoji',
            readOnly: true,
            textEditingController:
                TextEditingController(text: ctrl.feelingEmoji),
            onTap: () {
              openColorPickerDialog(
                isShowButton: false,
                content: SizedBox(
                  height: 300.w,
                  width: Get.width,
                  child: emojiPickerCard(
                    onTap: (category, emoji) {
                      setState(() {
                        ctrl.feelingEmoji = emoji.emoji;
                      });
                      ctrl.update();
                      Get.back();
                    },
                  ),
                ),
                title: 'Select Icon',
                context: context,
              );
            },
          ),
          20.w.spaceH(),
          AppTextField(
            textEditingController: ctrl.addFeelingCon,
            hintText: 'Feeling name',
          ),
          20.w.spaceH(),
          RoundAppButton(
            title: 'Add Feeling',
            onTap: () {
              ctrl.addFeeling();
            },
          )
        ],
      ).paddingAll(20.w);
    });
  }
}

class FamilyCard extends StatelessWidget {
  const FamilyCard(
      {Key? key,
      required this.isSelected,
      this.onTap,
      required this.widget,
      required this.title})
      : super(key: key);
  final bool isSelected;
  final String title;
  final Widget widget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64.w,
        width: 64.w,
        decoration: !isSelected
            ? const BoxDecoration()
            : BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.boxBorder.path))),
        child: InkWell(
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget,
              title.appSwitzerTextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.w,
                  fontColor: doteColor),
            ],
          ),
        ));
  }
}

class ButtonCard extends StatelessWidget {
  const ButtonCard(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  final String title;
  final Widget icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: background_F5F5F5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            '  $title'.appSwitzerTextStyle(
                fontColor: borderPurpleColor.withOpacity(.7),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          ],
        ).paddingSymmetric(horizontal: 10.w),
      ),
    );
  }
}

class FeelingCard extends StatelessWidget {
  const FeelingCard({
    Key? key,
    required this.widget,
    required this.title,
    required this.buttonText,
    required this.buttonOnTap,
  }) : super(key: key);
  final List<Widget> widget;
  final String title;
  final String buttonText;
  final Function() buttonOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w), color: white_FFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.appSwitzerTextStyle(
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp),
                16.w.spaceH(),
                Wrap(
                    spacing: 2.w,
                    runSpacing: 2.w,
                    alignment: WrapAlignment.start,
                    children: widget),
                16.w.spaceH(),
                Align(
                  alignment: Alignment.center,
                  child: ButtonCard(
                    onTap: buttonOnTap,
                    title: buttonText,
                    icon: Icon(Icons.add, size: 14.sp),
                  ),
                ),
              ],
            ).paddingAll(32.w))
        .paddingSymmetric(horizontal: 20.w);
  }
}
