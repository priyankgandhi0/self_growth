import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/voice_note/voice_note_con.dart';

import '../../../core/constants/app_colors.dart';

import '../../../gen/assets.gen.dart';

import '../../widgets/app_title_bar.dart';
import '../../widgets/common_widget.dart';
import '../home_module/mood_cheking/mood_checking_screen.dart';

class VoiceNoteScreen extends StatelessWidget {
  VoiceNoteScreen({Key? key}) : super(key: key);
  final VoiceNoteController voiceNoteController =
      Get.put(VoiceNoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<VoiceNoteController>(builder: (ctrl) {
            return Stack(
              children: [
                Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage(Assets.images.backGroundImage.path),
                            fit: BoxFit.fill)),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.w.spaceH(),
                          WithOutTitleAppBar(
                              suffixWidget: const SizedBox(),
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
                                  'Start recording your thought'
                                      .appSwitzerTextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600),
                                  16.w.spaceH(),
                                  ButtonCard(
                                    onTap: () {},
                                    title: 'Today, 8:00 AM',
                                    icon: Assets.icons.dateRange.svg(),
                                  ),
                                  48.w.spaceH(),
                                  "00:02".appSwitzerTextStyle(
                                      fontWeight: FontWeight.w400),
                                  2.w.spaceH(),
                                  Assets.icons.recordingPanel.svg(
                                      width: Get.width,
                                      height: 160.w,
                                      fit: BoxFit.cover),
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
                        ],
                      ),
                    )),
                /* Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: RoundAppButton(title: continueText, onTap: () {})
                      .paddingSymmetric(horizontal: 47.w, vertical: 20.w),
                )*/
              ],
            );
          }),
          // Obx(() => .isLoading.value
          //     ? const AppProgress()
          //     : const SizedBox())
        ],
      ),
    );
  }
}
