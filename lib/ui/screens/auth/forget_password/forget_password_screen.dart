import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_loader.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../generated/assets.dart';
import '../../../../languages/all_strings.dart';
import '../../../widgets/app_button.dart';
import '../auth_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

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
                      LanguageGlobalVar.forgetPassword.tr
                          .appSwitzerTextStyle(
                              fontSize: 32.w,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start)
                          .paddingSymmetric(horizontal: 20.w),
                      34.w.spaceH(),
                      AppTextField(
                        labelText: LanguageGlobalVar.emailText.tr,
                        showPrefixIcon: false,
                        showSuffixIcon: false,
                        keyboardType: TextInputType.emailAddress,
                        textEditingController: ctrl.forgetEmailController,
                        hintText: LanguageGlobalVar.enterEmailText.tr,
                        labelTextSize: 14.sp,
                        validator: (value) {},
                      ).paddingSymmetric(horizontal: 20.w),
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
                title: LanguageGlobalVar.submitEmail.tr,
                onTap: () {
                  ctrl.forgetPassword();
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
