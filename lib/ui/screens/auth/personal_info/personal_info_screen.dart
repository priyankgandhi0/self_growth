import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/config/routes/router.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../generated/assets.dart';
import '../../../../languages/all_strings.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_snack_bar.dart';
import '../../../widgets/common_widget.dart';
import '../auth_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({Key? key}) : super(key: key);
  final AuthController signUpCon = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return Future.value(false);
      },
      child: GetBuilder<AuthController>(builder: (ctrl) {
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
                        WithOutTitleAppBar(
                          suffixWidget: const SizedBox(),
                          showBackButton: true,
                          onTap: () {
                            Get.back();
                          },
                        ),
                        24.w.spaceH(),
                        LanguageGlobalVar.personalInformationText.tr
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
                                labelText: LanguageGlobalVar.nameText.tr,
                                showPrefixIcon: false,
                                showSuffixIcon: false,
                                textEditingController: ctrl.nameCon,
                                hintText: LanguageGlobalVar.enterNameText.tr,
                                labelTextSize: 14.sp,
                                validator: (value) {},
                              ),
                              10.w.spaceH(),
                              AppTextField(
                                labelText: LanguageGlobalVar.ageText.tr,
                                showPrefixIcon: false,
                                showSuffixIcon: false,
                                labelTextSize: 14.sp,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true),
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textEditingController: ctrl.ageCon,
                                hintText: LanguageGlobalVar.enterAgeText.tr,
                                validator: (value) {},
                              ),
                              10.w.spaceH(),
                             LanguageGlobalVar.genderText.tr.appSwitzerTextStyle(
                                fontWeight: FontWeight.w500,
                                fontColor: borderPurpleColor.withOpacity(.6),
                                fontSize: 14.sp,
                                // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                              ),
                              8.w.spaceH(),
                              AppDropDown(
                                value: ctrl.gender,
                                onChanged: (value) {
                                  ctrl.gender = value;

                                  ctrl.update();
                                },
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
                  title: LanguageGlobalVar.nextText.tr,
                  onTap: () {
                    if (ctrl.nameCon.text.isEmpty) {
                      showAppSnackBar(LanguageGlobalVar.nameNotEmpty.tr);
                    } else if (ctrl.ageCon.text.isEmpty) {
                      showAppSnackBar(LanguageGlobalVar.ageNotEmpty.tr);
                    } else if (ctrl.ageCon.text.length > 3) {
                      showAppSnackBar(LanguageGlobalVar.pleaseEnterValidAge.tr);
                    } else if (ctrl.gender == null) {
                      showAppSnackBar(LanguageGlobalVar.pleaseSelectGender.tr);
                    } else {
                      Get.toNamed(Routes.signUpScreen);
                    }
                    log("ctrl.gender ----> ${ctrl.gender}");
                  },
                ).paddingOnly(left: 46.w, right: 46.w, bottom: 36.w),
              ),
            ],
          ),
        );
      }),
    );
  }
}
