import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/home_module/home_screen.dart';
import 'package:self_growth/ui/screens/home_module/note_history/note_history_con.dart';

import '../../../../core/constants/request_const.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../models/get_user_mood_model.dart';
import '../../../widgets/app_dialogs.dart';
import '../../../widgets/app_loader.dart';
import '../../../widgets/app_title_bar.dart';
import '../../../widgets/audio_player.dart';
import '../../../widgets/common_widget.dart';
import '../../bottom_navigation/bottom_bar_controller.dart';
import '../../bottom_navigation/bottom_navigation_screen.dart';
import '../home_controller.dart';
import '../mood_checking/mood_checking_con.dart';

// ignore: must_be_immutable
class NoteHistoryScreen extends StatelessWidget {
  NoteHistoryScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  final BottomBarController bottomBarController =
      Get.put(BottomBarController());
  final MoodCheckingCon moodCheckingCon = Get.put(MoodCheckingCon());
  late ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Stack(
            children: [
              GetBuilder<HomeController>(initState: (state) {
                scrollController = ScrollController();
                scrollController.addListener(() {
                  if (scrollController.position.pixels >=
                      scrollController.position.maxScrollExtent) {
                    if (!homeController.stopPagination.value) {
                      homeController.stopPagination.value = true;
                      homeController.page += 1;
                      homeController.getUserMood(
                          isClear: false,
                          DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          isLoad: false);
                    }
                  }
                });
              }, builder: (ctrl) {
                return Container(
                  height: Get.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.images.backGroundImage.path),
                          fit: BoxFit.fill)),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonAppBar(
                            padding: 0,
                            onTap: () {
                              Get.back();
                            },
                            titleWidget: Row(
                              children: [
                                DateFormat('MMM yyyy')
                                    .format(DateTime.now())
                                    .appSwitzerTextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.w),
                                5.w.spaceW(),
                                SvgPicture.asset(
                                  Assets.icons.dropdownArrow.path,
                                  width: 7.w,
                                  height: 7.w,
                                  fit: BoxFit.cover,
                                  // ignore: deprecated_member_use
                                  color: borderPurpleColor,
                                )
                              ],
                            ),
                            title:
                                DateFormat('MMM yyyy').format(DateTime.now()),
                          ),
                          24.w.spaceH(),
                          DateFormat('MMM, dd')
                              .format(DateTime.now())
                              .appSwitzerTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                          16.w.spaceH(),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ctrl.moodData.isEmpty
                                    ? const SizedBox()
                                    : Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: white_FFFFFF),
                                        child: NoteCommonCard(
                                          iconOnTap: () {
                                            bottomBarController.isOpenDialog =
                                                true;
                                            bottomBarController
                                                .isOpenHomeDialog = 3;
                                            moodCheckingCon.editMood =
                                                ctrl.moodData[index];
                                            bottomBarController.update();
                                            moodCheckingCon.update();
                                          },
                                          image: Assets.icons.edit.path,
                                          title: ctrl.moodData[index].type ==
                                                  moodTextType
                                              ? (ctrl.moodData[index].title)
                                                  .toString()
                                              : ctrl.moodData[index].type ==
                                                      moodVoiceType
                                                  ? 'Voice Note'
                                                  : "Image Capture",
                                          time: DateFormat('hh:mm a').format(
                                              DateTime.parse(
                                                  '${ctrl.moodData[index].moodDate} ${ctrl.moodData[index].noteTime}'
                                                      .toString())),
                                          chipTitleColor: doteColor,
                                          fellingList: (ctrl.moodData[index]
                                                      .unhappyReasonFeeling ??
                                                  []) +
                                              (ctrl.moodData[index]
                                                      .howAreYouFeelingList ??
                                                  []),
                                          notes: ctrl.moodData[index].note
                                              .toString(),
                                          widget: ctrl.moodData[index].type ==
                                                  moodImageType
                                              ? AddImageCard(
                                                  widget: commonCachedNetworkImage(
                                                      borderRadius: 8.r,
                                                      imageUrl:
                                                          '${ImageBaseUrl.MOODIMAGEURL}${ctrl.moodData[index].moodPhoto}',
                                                      height: 140.w,
                                                      width: Get.width),
                                                )
                                              : ctrl.moodData[index].type ==
                                                      moodVoiceType
                                                  ? Container(
                                                      height: 69.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          color:
                                                              background_F5F5F5),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20.w),
                                                        child: AudioPlayer(
                                                          source:
                                                              "${ImageBaseUrl.MOODAUDIOURL}${ctrl.moodData[index].audioFile}",
                                                          onDelete: () {},
                                                        ),
                                                      ),
                                                    ).paddingAll(16.w)
                                                  : const SizedBox(),
                                        ),
                                      );
                              },
                              separatorBuilder: (context, index) {
                                return 16.w.spaceH();
                              },
                              itemCount: ctrl.moodData.length),
                          16.w.spaceH(),
                          Obx(() => ctrl.stopPagination.value
                              ? Center(child: paginationProgressForChat())
                              : const SizedBox()),
                        ],
                      ).paddingSymmetric(horizontal: 18.w, vertical: 24.w),
                    ),
                  ),
                );
              }),
              GetBuilder<BottomBarController>(builder: (ctrl) {
                return ctrl.isOpenDialog
                    ? OpenBottomDialog(
                        height: 20.w,
                        context: context,
                        onTap: () {
                          ctrl.isOpenDialog = false;
                          ctrl.update();
                        },
                        child: ctrl.isOpenHomeDialog == 2
                            ? const AddPhotoDialog()
                            : ctrl.isOpenHomeDialog == 3
                                ? MoodDialog()
                                : const SizedBox(),
                      )
                    : const SizedBox();
              }),
            ],
          ),
        ),
      ],
    );
  }
}
