import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/auth/sign_up/signUp_controller.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../generated/assets.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_title_bar.dart';
import '../../../widgets/start_up_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (ctrl) {
      return Scaffold(
        backgroundColor: background_EBEBEB,
        bottomNavigationBar: RoundAppButton(
          title: completeRegistrationText,
          onTap: () {},
        ).paddingOnly(left: 46.w, right: 46.w, bottom: 16.w),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.w.spaceH(),
              WithOutTitleAppBar(
                suffixWidget: const SizedBox(),
                showBackButton: true,
                onTap: () {
                  Get.back();
                },
              ),
              24.w.spaceH(),
              setupYourAccountText
                  .appTextStyle(
                      fontSize: 32.w,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start)
                  .paddingSymmetric(horizontal: 20.w),
              70.w.spaceH(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.w),
                        color: white_FFFFFF),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        100.w.spaceH(),
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
                          textEditingController: ctrl.phoneNoCon,
                          hintText: enterPhoneNumberText,
                          validator: (value) {},
                        ),
                        10.w.spaceH(),
                        AppTextField(
                          obscureText: true,
                          obscuringCharacter: "*",
                          labelText: passwordText,
                          showPrefixIcon: false,
                          showSuffixIcon: false,
                          labelTextSize: 14.sp,
                          textEditingController: ctrl.genderCon,
                          hintText: enterPasswordText,
                          validator: (value) {},
                        ),
                      ],
                    ).paddingSymmetric(vertical: 20.w),
                  ).paddingSymmetric(horizontal: 20.w),
                  Positioned(
                      top: -50.w,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.iconsProfile,
                              height: 100.w, width: 100.w, fit: BoxFit.contain),
                          15.w.spaceH(),
                          BorderButton(
                            width: 100.w,
                            title: addStickerText,
                            onTap: () {},
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
