import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/add_photo/add_photo_controller.dart';
import 'package:self_growth/ui/widgets/app_loader.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';

import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/app_button.dart';

import '../home_module/mood_cheking/mood_checking_screen.dart';

class AddPhotoScreen extends StatelessWidget {
  AddPhotoScreen({Key? key}) : super(key: key);
  final File image = Get.arguments["data"];
  final AddPhotoController addPhotoController = Get.put(AddPhotoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<AddPhotoController>(builder: (ctrl) {
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
                              widget: Assets.icons.addPhotoImg.svg(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  55.w.spaceH(),
                                  captureYourActivity.appSwitzerTextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                  16.w.spaceH(),
                                  ButtonCard(
                                    onTap: () {},
                                    title: 'Today, 8:00 AM',
                                    icon: Assets.icons.dateRange.svg(),
                                  ),
                                  AddImageCard(
                                    height: 271.w,
                                    padding: 20.w,
                                    widget:
                                        Image.file(image, fit: BoxFit.cover),
                                    onTap: () {},
                                  ),
                                  10.w.spaceH(),
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
                        ctrl.addMoodPhoto(image);
                      }).paddingSymmetric(horizontal: 47.w, vertical: 20.w),
                )
              ],
            );
          }),
          Obx(() => addPhotoController.isLoading.value
              ? const AppProgress()
              : const SizedBox())
        ],
      ),
    );
  }
}
