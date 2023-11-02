import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:self_growth/ui/widgets/app_button.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/app_helper.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../widgets/app_loader.dart';
import '../../../../widgets/start_up_text_field.dart';
import '../../../bottom_navigation/bottom_bar_controller.dart';
import 'change_pass_con.dart';

// ignore: must_be_immutable
class ChangePassScreen extends StatelessWidget {
  ChangePassScreen({Key? key}) : super(key: key);
  ChangePassController changePassController = Get.put(ChangePassController());
  final BottomBarController bottomBarController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<ChangePassController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  bottomBarController.changeTab(BottomNavEnum.profile);
                  bottomBarController.isSelectedTab = 5;
                  bottomBarController.tab = EditProfileScreen();
                },
                child: Assets.icons.backArrow
                    .svg()
                    .paddingSymmetric(horizontal: 16.w, vertical: 10.w),
              ),
              20.w.spaceH(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        obscureText: controller.isOldPass,
                        obscuringCharacter: "*",
                        labelText: oldPassword,
                        showPrefixIcon: false,
                        showSuffixIcon: true,
                        labelTextSize: 14.sp,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.isOldPass = !controller.isOldPass;
                          },
                          child: Icon(
                              controller.isOldPass
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility,
                              color: borderPurpleColor,
                              size: 20.w),
                        ),
                        textEditingController: controller.oldPassController,
                        hintText: 'Enter old password',
                        validator: (value) {},
                      ),
                      20.w.spaceH(),
                      AppTextField(
                        obscureText: controller.isNewPass,
                        obscuringCharacter: "*",
                        labelText: newPassword,
                        showSuffixIcon: true,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              controller.isNewPass = !controller.isNewPass;
                            },
                            child: Icon(
                                controller.isNewPass
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility,
                                color: borderPurpleColor,
                                size: 20.w)),
                        labelTextSize: 14.sp,
                        textEditingController: controller.newPassController,
                        hintText: 'Enter new password',
                        validator: (value) {},
                      ),
                      20.w.spaceH(),
                      AppTextField(
                        obscureText: controller.isConPass,
                        obscuringCharacter: "*",
                        labelText: confirmPassword,
                        showPrefixIcon: false,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.isConPass = !controller.isConPass;
                          },
                          child: Icon(
                              controller.isConPass
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility,
                              color: borderPurpleColor,
                              size: 20.w),
                        ),
                        showSuffixIcon: true,
                        labelTextSize: 14.sp,
                        textEditingController: controller.confPassController,
                        hintText: 'Enter confirm password',
                        validator: (value) {},
                      ),
                      40.w.spaceH(),
                      RoundAppButton(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.changePassResponse(context);
                          },
                          title: change)
                    ],
                  ),
                ),
              )
            ],
          );
        }),
        Obx(() => changePassController.isLoading.value
            ? const AppProgress()
            : Container())
      ],
    );
  }
}
