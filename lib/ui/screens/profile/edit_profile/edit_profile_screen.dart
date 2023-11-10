import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/profile/edit_profile/change_pass/change_pass_screen.dart';
import 'package:self_growth/ui/screens/profile/profile_screen.dart';
import 'package:self_growth/ui/widgets/app_loader.dart';

import '../../../../core/constants/app_colors.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/request_const.dart';
import '../../../../core/utils/app_helper.dart';

import '../../../../gen/assets.gen.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/common_widget.dart';
import '../../../widgets/file_picker_utils.dart';
import '../../../widgets/start_up_text_field.dart';
import '../../bottom_navigation/bottom_bar_controller.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  final BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<EditProfileController>(builder: (ctrl) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  bottomBarController.changeTab(BottomNavEnum.profile);
                  bottomBarController.isSelectedTab = 5;
                  bottomBarController.tab = ProfileScreen();
                },
                child: Assets.icons.backArrow
                    .svg()
                    .paddingSymmetric(horizontal: 16.w, vertical: 10.w),
              ),
              20.spaceH(),
              ProfileBoxCard(
                widget: ctrl.imageFile == null && ctrl.profileImage.isEmpty
                    ? (Assets.icons.profile)
                        .svg(height: 100.w, width: 100.w, fit: BoxFit.contain)
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
                                  fit: BoxFit.fill),
                              border: Border.all(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                          )
                        : commonCachedNetworkImage(
                            imageUrl:
                                '${ImageBaseUrl.PROFILEIMAGEURL}${ctrl.profileImage}',
                            height: 100.w,
                            width: 100.w,
                          ),
                child: Column(
                  children: [
                    50.w.spaceH(),
                    BorderButton(
                      width: 128.w,
                      title: changeAvatarText,
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
                      readOnly: true,
                      labelText: 'Email',
                      showPrefixIcon: false,
                      showSuffixIcon: false,
                      labelTextSize: 14.sp,
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: ctrl.emailCon,
                      hintText: enterEmailText,
                      validator: (value) {},
                    ),
                    10.w.spaceH(),
                    AppTextField(
                      labelText: phoneNumberText,
                      showPrefixIcon: false,
                      showSuffixIcon: false,
                      labelTextSize: 14.sp,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(13),
                      ],
                      textEditingController: ctrl.phoneNoCon,
                      hintText: enterPhoneNumberText,
                      validator: (value) {},
                    ),
                    10.w.spaceH(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: genderText.appSwitzerTextStyle(
                        fontWeight: FontWeight.w400,
                        fontColor: borderPurpleColor.withOpacity(.6),
                        fontSize: 14.sp,
                        // fontColor: _focusNode.hasFocus ? grey_969696 : black_000000,
                      ),
                    ),
                    8.w.spaceH(),
                    AppDropDown(
                      value: ctrl.gender,
                      // onChanged: (value) {
                      //   ctrl.gender = value;
                      //   ctrl.update();
                      // },
                    ),
                    20.w.spaceH(),
                    RoundAppButton(
                        title: 'Change Profile',
                        onTap: () {
                          ctrl.updateUserProfile();
                        })
                  ],
                ).paddingSymmetric(vertical: 20.w, horizontal: 20.w),
              ),
              16.w.spaceH(),
              GestureDetector(
                onTap: () {
                  bottomBarController.changeTab(BottomNavEnum.profile);
                  bottomBarController.isSelectedTab = 5;
                  bottomBarController.tab = ChangePassScreen();
                },
                child: Container(
                  height: 56.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.w),
                      color: white_FFFFFF),
                  child: ProfileDataCard(
                    image: Assets.icons.resetPass.path,
                    height: 32.w,
                    title: 'Reset password',
                  ).paddingSymmetric(vertical: 8.w, horizontal: 20.w),
                ).paddingSymmetric(
                  horizontal: 20.w,
                ),
              ),
              Obx(() =>
                  (editProfileController.isLoading.value ? 0 : 89.w).spaceH()),
            ],
          );
        }),
        Obx(() => editProfileController.isLoading.value
            ? const AppProgress()
            : const SizedBox())
      ],
    );
  }
}
