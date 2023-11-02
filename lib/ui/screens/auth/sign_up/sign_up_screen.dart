import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/auth/auth_controller.dart';

import '../../../../config/routes/router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../generated/assets.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_loader.dart';
import '../../../widgets/app_title_bar.dart';
import '../../../widgets/common_widget.dart';
import '../../../widgets/start_up_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final AuthController signUpController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (ctrl) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.imagesBackGroundImage),
                      fit: BoxFit.fill)),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    50.w.spaceH(),
                    WithOutTitleAppBar(
                      suffixWidget: const SizedBox(),
                      showBackButton: true,
                      onTap: () {
                        Get.back();
                      },
                    ),
                    24.w.spaceH(),
                    setupYourAccountText
                        .appSwitzerTextStyle(
                            fontSize: 32.w,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start)
                        .paddingSymmetric(horizontal: 20.w),
                    30.w.spaceH(),
                    ProfileBoxCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          50.w.spaceH(),
                          BorderButton(
                            width: 110.w,
                            title: addStickerText,
                            onTap: () {},
                          ),
                          20.w.spaceH(),
                          AppTextField(
                            labelText: emailText,
                            showPrefixIcon: false,
                            showSuffixIcon: false,
                            textEditingController: ctrl.emailCon,
                            hintText: enterEmailText,
                            labelTextSize: 14.sp,
                            validator: (value) {},
                          ),
                          10.w.spaceH(),
                          AppTextField(
                            labelText: phoneNumberText,
                            showPrefixIcon: false,
                            showSuffixIcon: false,
                            labelTextSize: 14.sp,
                            // maxLength: 10,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true),
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            textEditingController: ctrl.phoneNoCon,
                            hintText: enterPhoneNumberText,
                            validator: (value) {},
                          ),
                          10.w.spaceH(),
                          AppTextField(
                            obscureText: ctrl.isShowPass,
                            obscuringCharacter: "*",
                            labelText: passwordText,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                ctrl.isShowPass = !ctrl.isShowPass;
                              },
                              child: Icon(
                                  ctrl.isShowPass
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility,
                                  color: borderPurpleColor,
                                  size: 20.w),
                            ),
                            showPrefixIcon: false,
                            showSuffixIcon: true,
                            labelTextSize: 14.sp,
                            textEditingController: ctrl.passwordCon,
                            hintText: enterPasswordText,
                            validator: (value) {},
                          ),
                        ],
                      ).paddingSymmetric(vertical: 20.w, horizontal: 20.w),
                    ),
                    80.w.spaceH(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: RoundAppButton(
                title: completeRegistrationText,
                onTap: () {
                  ctrl.userRegistration();
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
