import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_loader.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../generated/assets.dart';
import '../../../widgets/app_button.dart';
import '../auth_controller.dart';

class ChangePassVerificationScreen extends StatelessWidget {
  ChangePassVerificationScreen({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (ctrl) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.imagesBackGroundImage),
                      fit: BoxFit.fill)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.w.spaceH(),
                      WithOutTitleAppBar(
                        suffixWidget: const SizedBox(),
                        showBackButton: true,
                        onTap: () {
                          Get.back();
                        },
                      ),
                      24.w.spaceH(),
                      changePassVerification
                          .appSwitzerTextStyle(
                              fontSize: 32.w,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start)
                          .paddingSymmetric(horizontal: 20.w),
                      34.w.spaceH(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                            color: white_FFFFFF),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              labelText: emailText,
                              showPrefixIcon: false,
                              showSuffixIcon: false,
                              textEditingController: ctrl.forgetEmailController,
                              hintText: enterEmailText,
                              labelTextSize: 14.sp,
                              readOnly: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {},
                            ),
                            8.w.spaceH(),
                            AppTextField(
                              labelText: verificationCodeText,
                              showPrefixIcon: false,
                              showSuffixIcon: false,
                              textEditingController: ctrl.verifyCodeController,
                              hintText: verificationCodeText,
                              labelTextSize: 14.sp,
                              validator: (value) {},
                            ),
                            8.w.spaceH(),
                            AppTextField(
                              labelText: newPasswordText,
                              showPrefixIcon: false,
                              showSuffixIcon: true,
                              obscuringCharacter: '*',
                              textEditingController: ctrl.newPasswordController,
                              hintText: passwordText,
                              labelTextSize: 14.sp,
                              obscureText: authController.isShowPass,
                              validator: (value) {},
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  authController.isShowPass =
                                      !authController.isShowPass;
                                },
                                child: Icon(
                                    authController.isShowPass
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility,
                                    color: borderPurpleColor,
                                    size: 20.w),
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 20.w, horizontal: 20),
                      ).paddingSymmetric(horizontal: 20.w),
                      70.w.spaceH(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RoundAppButton(
                title: submit,
                onTap: () {
                  ctrl.changePasswordWithVerifyCode();
                },
              ).paddingOnly(left: 46.w, right: 46.w, bottom: 36.w),
            ),
            Obx(() => ctrl.isLoading.value
                ? const AppProgress()
                : const SizedBox.shrink())
          ],
        ),
      );
    });
  }
}
