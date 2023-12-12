import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:self_growth/api/repositories/auth_repo.dart';
import 'package:self_growth/core/utils/preferences.dart';
import 'package:self_growth/ui/screens/profile/edit_profile/edit_profile_screen.dart';

import '../../../../../api/response_item.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/app_helper.dart';
import '../../../../../languages/all_strings.dart';
import '../../../../../models/change_pass_model.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../bottom_navigation/bottom_bar_controller.dart';

class ChangePassController extends GetxController {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  RxBool isLoading = false.obs;
  void changePassResponse(BuildContext context) async {
    if (oldPassController.text == '' || oldPassController.text.isEmpty) {
      showAppSnackBar('Old password must be required!');
    } else if (newPassController.text == '' || newPassController.text.isEmpty) {
      showAppSnackBar('Please enter new Password!');
    } else if (newPassController.text.length < 6) {
      showAppSnackBar('Password must be at least 6 character.');
    } else if (confPassController.text == '' ||
        confPassController.text.isEmpty) {
      showAppSnackBar('Please enter confirm Password!');
    } else if (newPassController.text != confPassController.text) {
      showAppSnackBar('New Password and Confirm Password must be same!');
    } else {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr.tr, status: false);
      result = await AuthRepo.changePassword(
        oldPassController.text.trim().toString(),
        newPassController.text.trim().toString(),
      );
      try {
        if (result.status) {
          log('RESPONSE--${result.refreshToken}');
          ChangePassResModel response =
              ChangePassResModel.fromJson(result.toJson());
          Get.find<BottomBarController>().changeTab(BottomNavEnum.profile);
          Get.find<BottomBarController>().isSelectedTab = 5;
          Get.find<BottomBarController>().tab = EditProfileScreen();
          showAppSnackBar(response.msg, status: true);
          preferences.putString(SharedPreference.AUTH_TOKEN, response.newToken);
          oldPassController.clear();
          newPassController.clear();
          confPassController.clear();
          isOldPass = true;
          isNewPass = true;
          isConPass = true;
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (e) {
        isLoading.value = false;
        showAppSnackBar( LanguageGlobalVar.errorText.tr);
      }
      update();
    }
  }

  bool _isOldPass = true;

  bool get isOldPass => _isOldPass;

  set isOldPass(bool value) {
    _isOldPass = value;
    update();
  }

  bool _isNewPass = true;

  bool get isNewPass => _isNewPass;

  set isNewPass(bool value) {
    _isNewPass = value;
    update();
  }

  bool _isConPass = true;

  bool get isConPass => _isConPass;

  set isConPass(bool value) {
    _isConPass = value;
    update();
  }
}
