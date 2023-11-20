import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/models/add_photo_model.dart';
import 'package:self_growth/ui/screens/voice_note/voice_note_con.dart';
import 'package:self_growth/ui/widgets/app_snack_bar.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_colors.dart';

import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/app_title_bar.dart';
import '../../widgets/common_widget.dart';
import '../home_module/mood_checking/mood_checking_screen.dart';

class VoiceNoteScreen extends StatelessWidget {
  VoiceNoteScreen({Key? key}) : super(key: key);
  final VoiceNoteController voiceNoteController =
      Get.put(VoiceNoteController());
  final CarouselController buttonCarouselController = CarouselController();
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
                                    onTap: () {
                                      pickDateDialog(context: context)
                                          .then((value) {
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
                                  /*  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                      ((ctrl.buildText1().contains('-') ||
                                                  ctrl.buildText1() == "00:00")
                                              ? ""
                                              : ctrl.buildText1())
                                          .appSwitzerTextStyle(
                                              fontWeight: FontWeight.w400),
                                      ((ctrl.buildText2().contains('-') ||
                                                  ctrl.buildText2() == "00:00")
                                              ? ""
                                              : ctrl.buildText2())
                                          .appSwitzerTextStyle(
                                              fontWeight: FontWeight.w400),
                                      (ctrl.buildText3()).appSwitzerTextStyle(
                                          fontWeight: FontWeight.w400),
                                      (ctrl.buildText4() == "00:00"
                                              ? ""
                                              : ctrl.buildText4())
                                          .appSwitzerTextStyle(
                                              fontWeight: FontWeight.w400),
                                      (ctrl.buildText5() == "00:00"
                                              ? ""
                                              : ctrl.buildText5())
                                          .appSwitzerTextStyle(
                                              fontWeight: FontWeight.w400),
                                    ],
                                  ).paddingSymmetric(horizontal: 26.w),*/
                                  SizedBox(
                                    height: 20.w,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                      if (!ctrl.isPlay) {
                                        ctrl.textList.clear();
                                      }
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
                          Get.toNamed(Routes.moodCheckingScreen);
                        }
                      }).paddingSymmetric(horizontal: 47.w, vertical: 20.w),
                )
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
