import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/auth/auth_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/request_const.dart';
import '../../../../generated/assets.dart';
import '../../../../languages/all_strings.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_loader.dart';
import '../../../widgets/app_title_bar.dart';
import '../../../widgets/common_widget.dart';
import '../../../widgets/file_picker_utils.dart';
import '../../../widgets/start_up_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final AuthController signUpController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return Future.value(false);
      },
      child: GetBuilder<AuthController>(builder: (ctrl) {
        return Scaffold(
          body: Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WithOutTitleAppBar(
                          suffixWidget: const SizedBox(),
                          showBackButton: true,
                          onTap: () {
                            Get.back();
                          },
                        ),
                        24.w.spaceH(),
                        LanguageGlobalVar.setupYourAccountText.tr
                            .appSwitzerTextStyle(
                                fontSize: 32.w,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start)
                            .paddingSymmetric(horizontal: 20.w),
                        30.w.spaceH(),
                        ProfileBoxCard(
                          widget: ctrl.imageFile == null &&
                                  ctrl.profileImage.isEmpty
                              ? SvgPicture.asset(Assets.iconsProfile,
                                  height: 100.w,
                                  width: 100.w,
                                  fit: BoxFit.contain)
                              : ctrl.imageFile != null
                                  ? Container(
                                      height: 100.w,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(
                                              ctrl.imageFile!,
                                            ),
                                            fit: BoxFit.cover),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor),
                                      ),
                                    )
                                  : commonCachedNetworkImage(
                                      imageUrl:
                                          '${ImageBaseUrl.PROFILEIMAGEURL}${ctrl.profileImage}',
                                      height: 100.w,
                                      width: 100.w,
                                    ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              50.w.spaceH(),
                              BorderButton(
                                width: 110.w,
                                title: LanguageGlobalVar.addStickerText.tr,
                                onTap: () {
                                  PickFile().openImageChooser(
                                      context: context,
                                      onImageChose: (File? newFile) {
                                        if (newFile != null) {
                                          ctrl.addImage(newFile);
                                        }
                                      });
                                },
                              ),
                              20.w.spaceH(),
                              AppTextField(
                                labelText: LanguageGlobalVar.emailText.tr,
                                showPrefixIcon: false,
                                showSuffixIcon: false,
                                keyboardType: TextInputType.emailAddress,
                                textEditingController: ctrl.emailCon,
                                hintText: LanguageGlobalVar.enterEmailText.tr,
                                labelTextSize: 14.sp,
                                validator: (value) {},
                              ),
                              10.w.spaceH(),
                              AppTextField(
                                labelText: LanguageGlobalVar.phoneNumberText.tr,
                                showPrefixIcon: false,
                                showSuffixIcon: false,
                                labelTextSize: 14.sp,
                                // maxLength: 10,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true),
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(13),
                                ],
                                textEditingController: ctrl.phoneNoCon,
                                hintText: LanguageGlobalVar.enterPhoneNumberText.tr,
                                validator: (value) {},
                              ),
                              10.w.spaceH(),
                              AppTextField(
                                obscureText: ctrl.isShowPass,
                                obscuringCharacter: "*",
                                labelText: LanguageGlobalVar.passwordText.tr,
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
                                hintText: LanguageGlobalVar.enterPasswordText.tr,
                                validator: (value) {},
                              ),
                            ],
                          ).paddingSymmetric(vertical: 20.w, horizontal: 20.w),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MediaQuery.of(context).viewInsets.bottom != 0
                  ? const SizedBox()
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: RoundAppButton(
                        title: LanguageGlobalVar.completeRegistrationText.tr,
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
      }),
    );
  }
}
