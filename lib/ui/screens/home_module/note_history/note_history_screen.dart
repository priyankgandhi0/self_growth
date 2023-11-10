import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/home_module/note_history/note_history_con.dart';

import '../../../../core/constants/request_const.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/app_loader.dart';
import '../../../widgets/app_title_bar.dart';
import '../../../widgets/audio_player.dart';
import '../../../widgets/common_widget.dart';

class NoteHistoryScreen extends StatelessWidget {
  NoteHistoryScreen({Key? key}) : super(key: key);
  final NoteHistoryController noteHistoryController =
      Get.put(NoteHistoryController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: GetBuilder<NoteHistoryController>(initState: (state) {
            noteHistoryController
                .getUserMood(DateFormat('yyyy-MM-dd').format(DateTime.now()));
          }, builder: (ctrl) {
            return Container(
              height: Get.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.images.backGroundImage.path),
                      fit: BoxFit.fill)),
              child: SingleChildScrollView(
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
                        title: DateFormat('MMM yyyy').format(DateTime.now()),
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
                                : ctrl.moodData[index].type == "MOOD"
                                    ? Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: white_FFFFFF),
                                        child: NoteCommonCard(
                                          image: Assets.icons.edit.path,
                                          title: (ctrl.moodData[index].feeling!
                                                      .isEmpty
                                                  ? "Title"
                                                  : ctrl
                                                      .moodData[index].feeling)
                                              .toString(),
                                          time: DateFormat('hh:mm a').format(
                                              DateTime.parse(
                                                  '${ctrl.moodData[index].moodDate} ${ctrl.moodData[index].noteTime}'
                                                      .toString())),
                                          chipTitleColor: doteColor,
                                          fellingList: ctrl.moodData[index]
                                                  .unhappyReasonFeeling ??
                                              [],
                                          notes: ctrl.moodData[index].note
                                              .toString(),
                                        ),
                                      )
                                    : ctrl.moodData[index].type == "PHOTO"
                                        ? Container(
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                color: white_FFFFFF),
                                            child: NoteCommonCard(
                                              showIcon: true,
                                              image: Assets
                                                  .icons.imageCapture.path,
                                              title: (ctrl.moodData[index]
                                                          .title!.isEmpty
                                                      ? "Image Title"
                                                      : ctrl.moodData[index]
                                                          .title)
                                                  .toString(),
                                              time: DateFormat('hh:mm a')
                                                  .format(DateTime.parse(
                                                      '${ctrl.moodData[index].moodDate} ${ctrl.moodData[index].noteTime}'
                                                          .toString())),
                                              fellingList: ctrl.moodData[index]
                                                      .unhappyReasonFeeling ??
                                                  [],
                                              isImage: false,
                                              widget: AddImageCard(
                                                widget: commonCachedNetworkImage(
                                                    borderRadius: 8.r,
                                                    imageUrl:
                                                        '${ImageBaseUrl.MOODIMAGEURL}${ctrl.moodData[index].moodPhoto}',
                                                    height: 140.w,
                                                    width: Get.width),
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
                                              fellingList: ctrl.moodData[index]
                                                      .unhappyReasonFeeling ??
                                                  [],
                                              title: (ctrl.moodData[index]
                                                          .title!.isEmpty
                                                      ? 'Voice title'
                                                      : ctrl.moodData[index]
                                                          .title)
                                                  .toString(),
                                              time: DateFormat('hh:mm a')
                                                  .format(DateTime.parse(
                                                      '${ctrl.moodData[index].moodDate} ${ctrl.moodData[index].noteTime}'
                                                          .toString())),
                                              widget: Container(
                                                height: 69.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    color: background_F5F5F5),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.w),
                                                  child: AudioPlayer(
                                                    source:
                                                        'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
                                                    onDelete: () {
                                                      ctrl.showPlayer =
                                                          !ctrl.showPlayer;
                                                      ctrl.update();
                                                    },
                                                  ),
                                                ),
                                              ).paddingAll(16.w),
                                            ),
                                          );
                          },
                          separatorBuilder: (context, index) {
                            return 16.w.spaceH();
                          },
                          itemCount: ctrl.moodData.length)
                      /*Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: white_FFFFFF),
                        child: NoteCommonCard(
                          image: Assets.iconsEdit,
                          showIcon: false,
                          title: 'Note title',
                          time: '7:00 AM ·',
                          notes: 'This is some text',
                        ),
                      ),
                      16.w.spaceH(),
                      'Sun, 13'.appSwitzerTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      16.w.spaceH(),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: white_FFFFFF),
                        child: NoteCommonCard(
                          image: Assets.iconsVoice,
                          showIcon: false,
                          title: 'Voice title',
                          time: '7:00 AM ·',
                          widget: Container(
                            height: 69.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: background_F5F5F5),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: AudioPlayer(
                                source:
                                    'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
                                onDelete: () {
                                  ctrl.showPlayer = !ctrl.showPlayer;
                                  ctrl.update();
                                },
                              ),
                            ),
                          ).paddingAll(16.w),
                        ),
                      ),
                      16.w.spaceH(),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: white_FFFFFF),
                        child: NoteCommonCard(
                          image: Assets.iconsEdit,
                          showIcon: false,
                          title: 'Note title',
                          time: '7:00 AM ·',
                          notes: 'This is some text',
                        ),
                      ),
                      16.w.spaceH(),
                      'Sun, 13'.appSwitzerTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      16.w.spaceH(),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: white_FFFFFF),
                        child: NoteCommonCard(
                          image: Assets.iconsEdit,
                          showIcon: false,
                          title: 'Note title',
                          time: '7:00 AM ·',
                          notes: 'This is some text',
                        ),
                      ),
                      16.w.spaceH(),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: white_FFFFFF),
                        child: NoteCommonCard(
                          showIcon: true,
                          image: Assets.iconsImageCapture,
                          title: 'Image Capture',
                          time: '7:00 AM ·',
                          isImage: true,
                          widget: AddImageCard(
                            onTap: () {
                              PickFile().openImageChooser(
                                  context: context, onImageChose: () {});
                            },
                          ),
                        ),
                      ),*/
                    ],
                  ).paddingSymmetric(horizontal: 18.w, vertical: 24.w),
                ),
              ),
            );
          }),
        ),
        Obx(() => noteHistoryController.isLoading.value
            ? const AppProgress()
            : const SizedBox())
      ],
    );
  }
}
