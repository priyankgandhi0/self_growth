import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:self_growth/api/repositories/auth_repo.dart';
import 'package:self_growth/core/utils/preferences.dart';

import '../../../api/response_item.dart';
import '../../../config/routes/router.dart';
import '../../../core/constants/app_constant.dart';
import '../../../core/constants/app_strings.dart';
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


  /// LOGIN CONTROLLER
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


  userLogin() async {

  }


  userRegistration() async {
    if (emailCon.text.isEmpty) {
      showAppSnackBar(emailNotEmpty);
    } else if (!emailCon.text.isEmail) {
      showAppSnackBar(emailNotValid);
    }else if(phoneNoCon.text.isEmpty){
      showAppSnackBar(phoneNumberNotEmpty);
    } else if(passwordCon.text.isEmpty){
      showAppSnackBar(passwordNotEmpty);
    }else {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      ResponseItem result =
      ResponseItem(data: null, message: errorText, status: false);
      result = await AuthRepo.userRegistration(
          userName: nameCon.text.trim(),
          email: emailCon.text.trim(),
          phoneNumber: phoneNoCon.text.trim(),
          age: ageCon.text.trim(),
          gender: gender.toString(),
          password: passwordCon.text.trim());

      try {
        if (result.status) {
          if (result.data != null) {
            UserModel userModel = UserModel.fromJson(result.toJson());
            preferences.saveUserItem(userModel.data);
            showAppSnackBar(result.message);
            isLoading.value = false;
            Get.toNamed(Routes.bottomNavigationScreen);
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (error) {
        isLoading.value = false;
        showAppSnackBar(errorText);
      }
      isLoading.value = false;
      update();
    }
  }
}
