import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/config/routes/router.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/auth/personal_info/personal_info_con.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../../../core/constants/app_constant.dart';
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
                      hintText: enterAgeText,
                      validator: (value) {},
                    ),
                    10.w.spaceH(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: genderText.appTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                      ),
                    ),
                    8.w.spaceH(),
                    Container(
                      decoration: BoxDecoration(
                          color: background_F5F5F5,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<Gender>(
                              style: getTextStyle(),
                              value: ctrl.gender,
                              underline: Container(),
                              hint: 'Gender'
                                  .appTextStyle(
                                    fontColor: grey_969696,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )
                                  .paddingOnly(left: 8),
                              borderRadius: BorderRadius.circular(16),
                              icon: Container(),
                              dropdownColor: Colors.white,
                              items: Gender.values
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name).paddingAll(8),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                ctrl.gender = value;
                                ctrl.update();
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingSymmetric(vertical: 20.w, horizontal: 20),
              ).paddingSymmetric(horizontal: 20.w)
            ],
          ),
        ),
      );
    });
  }
}
