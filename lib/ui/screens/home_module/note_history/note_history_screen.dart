import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/home_module/note_history/note_history_con.dart';

import '../../../../generated/assets.dart';
import '../../../widgets/app_title_bar.dart';
import '../../../widgets/audio_player.dart';
import '../../../widgets/common_widget.dart';
import '../../../widgets/file_picker_utils.dart';

class NoteHistoryScreen extends StatelessWidget {
  NoteHistoryScreen({Key? key}) : super(key: key);
  final NoteHistoryController noteHistoryController =
      Get.put(NoteHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NoteHistoryController>(builder: (ctrl) {
        return Container(
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesBackGroundImage),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.w.spaceH(),
                CommonAppBar(
                  padding: 0,
                  onTap: () {
                    Get.back();
                  },
                  title: 'Feb 2023',
                ),
                24.w.spaceH(),
                'Mon, 14'.appTextStyle(
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
                'Sun, 13'.appTextStyle(
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
                        padding: const EdgeInsets.symmetric(horizontal: 25),
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
                'Sun, 13'.appTextStyle(
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
                    widget: GestureDetector(
                      onTap: () {
                        PickFile().openImageChooser(
                            context: context, onImageChose: () {});
                      },
                      child: Container(
                        height: 140.w,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: background_F5F5F5,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.iconsImage),
                          ],
                        ),
                      ),
                    ).paddingAll(16.w),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 18.w, vertical: 24.w),
          ),
        );
      }),
    );
  }
}
