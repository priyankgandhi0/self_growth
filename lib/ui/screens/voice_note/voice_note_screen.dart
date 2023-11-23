import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:self_growth/core/constants/request_const.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/home_module/mood_checking/mood_checking_con.dart';
import 'package:self_growth/ui/screens/voice_note/voice_note_con.dart';
import 'package:self_growth/ui/widgets/app_snack_bar.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_colors.dart';

import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/app_title_bar.dart';
import '../../widgets/common_widget.dart';
import '../home_module/mood_checking/mood_checking_screen.dart';

class VoiceNoteScreen extends StatelessWidget {
  VoiceNoteScreen({Key? key, this.isEdit = false}) : super(key: key);
  final VoiceNoteController voiceNoteController =
      Get.put(VoiceNoteController());
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<VoiceNoteController>(builder: (ctrl) {
        return Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.w.spaceH(),
                    WithOutTitleAppBar(
                        suffixWidget: Visibility(
                          visible: isEdit,
                          child: InkWell(
                            onTap: () {
                              ctrl.isLoading.value = true;
                              urlToFile(
                                      '${ImageBaseUrl.MOODAUDIOURL}${Get.find<MoodCheckingCon>().editMood?.audioFile ?? ""}',
                                      moodVoiceType)
                                  .then((value) {
                                ctrl.isLoading.value = false;
                                Get.to(MoodCheckingScreen(
                                  audioPath: value,
                                  moodType: moodVoiceType,
                                  isEdit: true,
                                ));
                              });
                            },
                            highlightColor: Colors.transparent,
                            child: 'Skip'.appSwitzerTextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.sp),
                          ),
                        ),
                        widget: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            color: borderPurpleColor,
                          ),
                        ),
                        showBackButton: true),
                    20.w.spaceH(),
                    ProfileBoxCard(
                        widget: Assets.icons.record.svg(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            55.w.spaceH(),
                            'Start recording your thought'.appSwitzerTextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                            16.w.spaceH(),
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
                            16.w.spaceH(),
                            SizedBox(
                              height: 20.w,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: ctrl.scrollController,
                                itemCount:
                                    ctrl.textList.toSet().toList().length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return (ctrl.textList
                                          .toSet()
                                          .toList()[index]
                                          .toString())
                                      .appSwitzerTextStyle(
                                          fontColor: doteColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp)
                                      .paddingOnly(right: 30.w);
                                },
                              ),
                            ).paddingSymmetric(horizontal: 28.w),
                            2.w.spaceH(),
                            Assets.icons.recordingPanel.svg(
                                width: Get.width,
                                height: 160.w,
                                fit: BoxFit.contain),
                            10.w.spaceH(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mic,
                                  size: 20.w,
                                  color: borderPurpleColor,
                                ),
                                ctrl.buildText().appSwitzerTextStyle(
                                    fontColor: doteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp)
                              ],
                            ),
                            20.w.spaceH(),
                            GestureDetector(
                              onTap: () {
                                log('ctrl.recordStates  ${ctrl.recordStates}');
                                ctrl.recordStates != RecordState.stop
                                    ? ctrl.stop(
                                        onStop: (path) {
                                          ctrl.audioPath = File(path);
                                          ctrl.update();

                                          log('path---$path');
                                        },
                                      )
                                    : ctrl.startRecord();
                                ctrl.isPlay = !ctrl.isPlay;
                                ctrl.update();
                              },
                              child: (ctrl.isPlay
                                      ? Assets.icons.audioStop
                                      : Assets.icons.audioPlayer)
                                  .svg(),
                            ),
                            16.w.spaceH(),
                            (ctrl.isPlay
                                    ? 'Tap stop to proceed next step'
                                    : "Tap to start recording")
                                .appSwitzerTextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                            20.w.spaceH(),
                          ],
                        )),
                    60.w.spaceH(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RoundAppButton(
                  title: continueText,
                  onTap: () {
                    if (ctrl.audioPath == null) {
                      showAppSnackBar('Please record voice note!');
                    } else {
                      ctrl.textList.clear();
                      Get.to(
                          MoodCheckingScreen(
                              moodType: moodVoiceType,
                              audioPath: ctrl.audioPath,
                              isEdit: isEdit),
                          transition: Transition.downToUp);
                    }
                  }).paddingSymmetric(horizontal: 47.w, vertical: 20.w),
            ),
            Obx(() => voiceNoteController.isLoading.value
                ? const AppProgress()
                : const SizedBox())
          ],
        );
      }),
    );
  }
}
