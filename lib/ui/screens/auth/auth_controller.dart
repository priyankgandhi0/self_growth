import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:self_growth/api/repositories/auth_repo.dart';
import 'package:self_growth/core/utils/preferences.dart';

import '../../../api/response_item.dart';
import '../../../config/routes/router.dart';
import '../../../core/constants/app_constant.dart';
import '../../../core/constants/app_strings.dart';
import '../../../languages/all_strings.dart';
import '../../../models/user_model.dart';
import '../../widgets/app_snack_bar.dart';

class AuthController extends GetxController {
  TextEditingController nameCon = TextEditingController();
  TextEditingController ageCon = TextEditingController();
  Gender? gender;
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController phoneNoCon = TextEditingController();
  RxBool isLoading = false.obs;
  bool _isShowPass = true;

  bool get isShowPass => _isShowPass;

  set isShowPass(bool value) {
    _isShowPass = value;
    update();
  }

  /// LOGIN CONTROLLER
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  /// FORGET PASSWORD
  TextEditingController forgetEmailController = TextEditingController();

  TextEditingController verifyCodeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  changePasswordWithVerifyCode() async {
    if (forgetEmailController.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.emailNotEmpty.tr);
    } else if (!forgetEmailController.text.isEmail) {
      showAppSnackBar(LanguageGlobalVar.emailNotValid.tr);
    } else if (verifyCodeController.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.verificationCodeNotEmpty.tr);
    } else if (newPasswordController.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.newPasswordNotEmpty.tr);
    } else if (newPasswordController.text.length < 6) {
      showAppSnackBar('Password must be at least 6 character.');
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
      result = await AuthRepo.changePasswordWithVerifyCode(
          email: forgetEmailController.text.trim(),
          newPassword: newPasswordController.text.trim(),
          verifyCode: verifyCodeController.text.trim());

      try {
        if (result.status) {
          Get.offAllNamed(Routes.onboarding);
          showAppSnackBar(result.message, status: true);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (error) {
        isLoading.value = false;
        showAppSnackBar( LanguageGlobalVar.errorText.tr);
      }
      isLoading.value = false;
      update();
    }
  }

  forgetPassword() async {
    if (forgetEmailController.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.emailNotEmpty.tr);
    } else if (!forgetEmailController.text.isEmail) {
      showAppSnackBar(LanguageGlobalVar.emailNotValid.tr);
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
      result = await AuthRepo.forgotPassword(
          email: forgetEmailController.text.trim());
      try {
        if (result.status) {
          showAppSnackBar(result.message, status: true);
          Get.toNamed(Routes.changePassVerificationScreen);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (error) {
        isLoading.value = false;
        showAppSnackBar( LanguageGlobalVar.errorText.tr);
      }
      isLoading.value = false;
      update();
    }
  }

  userLogin() async {
    if (emailController.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.emailNotEmpty.tr);
    } else if (!emailController.text.isEmail) {
      showAppSnackBar(LanguageGlobalVar.emailNotValid.tr);
    } else if (phoneNumberController.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.phoneNumberNotEmpty.tr);
    } else if (passwordController.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.passwordNotEmpty.tr);
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: LanguageGlobalVar.errorText.tr, status: false);
      result = await AuthRepo.userLogin(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      try {
        if (result.status) {
          if (result.data != null) {
            UserModel userModel = UserModel.fromJson(result.toJson());
            preferences.saveUserItem(userModel.data);
            isLoading.value = false;
            Get.offAllNamed(Routes.bottomNavigationScreen);
            preferences.putBool(SharedPreference.IS_FILL_QUE, true);
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (error) {
        isLoading.value = false;
        showAppSnackBar( LanguageGlobalVar.errorText.tr);
      }
      isLoading.value = false;
      update();
    }
  }

  File? imageFile;
  void addImage(File newImage) {
    imageFile = newImage;
    update();
  }

  String profileImage =
      preferences.getString(SharedPreference.USER_PROFILE) ?? "";
  userRegistration() async {
    if (emailCon.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.emailNotEmpty.tr);
    } else if (!emailCon.text.isEmail) {
      showAppSnackBar(LanguageGlobalVar.emailNotValid.tr);
    } else if (phoneNoCon.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.phoneNumberNotEmpty.tr);
    } else if (passwordCon.text.isEmpty) {
      showAppSnackBar(LanguageGlobalVar.passwordNotEmpty.tr);
    } else if (passwordCon.text.length < 6) {
      showAppSnackBar('Password must be at least 6 character.');
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message:  errorText, status: false);
      if (imageFile == null) {
        log('imageFile null');
        result = await AuthRepo.registrationRepo(
            userName: nameCon.text.trim(),
            email: emailCon.text.trim(),
            phoneNumber: phoneNoCon.text.trim(),
            age: ageCon.text.trim(),
            gender: gender.toString(),
            password: passwordCon.text.trim());
      } else {
        result = await AuthRepo.registrationRepo(
            userName: nameCon.text.trim(),
            email: emailCon.text.trim(),
            phoneNumber: phoneNoCon.text.trim(),
            age: ageCon.text.trim(),
            gender: gender.toString(),
            password: passwordCon.text.trim(),
            profileImage: imageFile);
      }
      try {
        if (result.status) {
          if (result.data != null) {
            UserModel userModel = UserModel.fromJson(result.toJson());
            preferences.saveUserItem(userModel.data);

            isLoading.value = false;
            Get.toNamed(Routes.selfDiscoverScreen);
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (error) {
        isLoading.value = false;
        showAppSnackBar( LanguageGlobalVar.errorText.tr);
      }
      isLoading.value = false;
      update();
    }
  }
}
