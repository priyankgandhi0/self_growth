import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_growth/config/routes/router.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/auth/personal_info/personal_info_con.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../widgets/app_button.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({Key? key}) : super(key: key);
  final PersonalInfoCon personalInfoCon = Get.put(PersonalInfoCon());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInfoCon>(builder: (ctrl) {
      return Scaffold(
        bottomNavigationBar: RoundAppButton(
          title: nextText,
          onTap: () {
            Get.toNamed(Routes.signUpScreen);
          },
        ).paddingOnly(left: 46.w, right: 46.w, bottom: 16.w),
        backgroundColor: background_EBEBEB,
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
              personalInformationText
                  .appTextStyle(
                      fontSize: 32.w,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start)
                  .paddingSymmetric(horizontal: 20.w),
              24.w.spaceH(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.w),
                    color: white_FFFFFF),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      labelText: nameText,
                      showPrefixIcon: false,
                      showSuffixIcon: false,
                      textEditingController: ctrl.nameCon,
                      hintText: enterNameText,
                      labelTextSize: 14.sp,
                      validator: (value) {},
                    ),
                    10.w.spaceH(),
                    AppTextField(
                      labelText: ageText,
                      showPrefixIcon: false,
                      showSuffixIcon: false,
                      labelTextSize: 14.sp,
                      textEditingController: ctrl.ageCon,
                      hintText: enterGenderText,
                      validator: (value) {},
                    ),
                    10.w.spaceH(),
                    AppTextField(
                      labelText: genderText,
                      showPrefixIcon: false,
                      showSuffixIcon: false,
                      labelTextSize: 14.sp,
                      textEditingController: ctrl.genderCon,
                      hintText: enterGenderText,
                      validator: (value) {},
                    ),
                  ],
                ).paddingSymmetric(vertical: 20.w),
              ).paddingSymmetric(horizontal: 20.w)
            ],
          ),
        ),
      );
    });
  }
}
