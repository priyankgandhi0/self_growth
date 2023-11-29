import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_growth/api/repositories/auth_repo.dart';

import '../../../../api/response_item.dart';
import '../../../../core/constants/app_constant.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/app_helper.dart';
import '../../../../core/utils/preferences.dart';
import '../../../../models/user_model.dart';
import '../../../widgets/app_snack_bar.dart';
import '../../bottom_navigation/bottom_bar_controller.dart';
import '../profile_screen.dart';

class EditProfileController extends GetxController {
  TextEditingController nameCon = TextEditingController(
      text: preferences.getString(SharedPreference.USER_NAME));
  TextEditingController emailCon = TextEditingController(
      text: preferences.getString(SharedPreference.USER_EMAIL));
  TextEditingController phoneNoCon = TextEditingController(
      text: preferences.getString(SharedPreference.PHONE_NUMBER));
  Gender? gender = (preferences.getString(SharedPreference.GENDER) == 'Male'
      ? Gender.Male
      : preferences.getString(SharedPreference.GENDER) == 'Female'
          ? Gender.Female
          : Gender.Other);
  File? imageFile;
  void addImage(File newImage) {
    imageFile = newImage;
    update();
  }

  String profileImage =
      preferences.getString(SharedPreference.USER_PROFILE) ?? "";
  RxBool isLoading = false.obs;
  Future<void> updateUserProfile() async {
    try {
      if (nameCon.text.isEmpty) {
        showAppSnackBar('Please enter name');
      } else if (phoneNoCon.text.isEmpty) {
        showAppSnackBar('Please enter phone number.');
      } else {
        ResponseItem result =
            ResponseItem(data: null, message: errorText.tr, status: false);
        isLoading.value = true;
        if (imageFile == null) {
          result = await AuthRepo.updateUserProfile(
              phoneNumber: phoneNoCon.text, fullName: nameCon.text);
        } else {
          result = await AuthRepo.updateUserProfile(
              phoneNumber: phoneNoCon.text,
              profileImage: imageFile,
              fullName: nameCon.text);
        }
        if (result.status) {
          if (result.data != null) {
            UserModel response = UserModel.fromJson(result.toJson());
            preferences.putString(
                SharedPreference.PHONE_NUMBER, response.data.phoneNumber);
            preferences.putString(
                SharedPreference.USER_NAME, response.data.userName);
            preferences.putString(
                SharedPreference.USER_PROFILE, response.data.userProfilePhoto);
            preferences.putString(
                SharedPreference.GENDER, response.data.gender);
            log('response.data.gender--${response.data.gender}');
            Get.find<BottomBarController>().changeTab(BottomNavEnum.profile);
            Get.find<BottomBarController>().isSelectedTab = 5;
            Get.find<BottomBarController>().tab = ProfileScreen();
            showAppSnackBar(response.msg, status: true);
            isLoading.value = false;
          } else {
            isLoading.value = false;
            showAppSnackBar(result.message);
          }
        }
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(errorText);
    }
    update();
  }
}
