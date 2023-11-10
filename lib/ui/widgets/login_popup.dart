import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/auth/auth_controller.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import 'app_button.dart';

// ignore: must_be_immutable
class LoginPopup extends StatelessWidget {
  LoginPopup({Key? key, required this.onLogin, required this.onForgotPassword})
      : super(key: key);
  final VoidCallback onLogin;
  final Function onForgotPassword;

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Stack(
          children: [
            Padding(
              padding: MediaQuery.of(context).viewInsets,
              // padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.0.spaceH(),
                  "Login".appSwitzerTextStyle(
                      fontSize: 32, fontWeight: FontWeight.w500),
                  20.0.spaceH(),
                  AppTextField(
                    textEditingController: authController.emailController,
                    labelText: "E-mail",
                    hintText: "Email",
                    prefixIcon: '',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  20.0.spaceH(),
                  AppTextField(
                    textEditingController: authController.phoneNumberController,
                    labelText: "Phone number",
                    hintText: "Phone number",
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(13),
                    ],
                    prefixIcon: '',
                  ),
                  20.0.spaceH(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: "Password".appSwitzerTextStyle(
                          fontWeight: FontWeight.w500,
                          fontColor: borderPurpleColor.withOpacity(.6),
                          fontSize: 14.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          onForgotPassword();
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: "Forgot password?".appSwitzerTextStyle(
                            fontWeight: FontWeight.w500,
                            fontColor: borderPurpleColor.withOpacity(.6),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  (8).spaceH(),
                  AppTextField(
                    textEditingController: authController.passwordController,
                    hintText: "Password",
                    obscureText: authController.isShowPass,
                    showSuffixIcon: true,
                    obscuringCharacter: '*',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        authController.isShowPass = !authController.isShowPass;
                      },
                      child: Icon(
                          authController.isShowPass
                              ? Icons.visibility_off_rounded
                              : Icons.visibility,
                          color: borderPurpleColor,
                          size: 20.w),
                    ),
                    prefixIcon: '',
                  ),
                  (20).spaceH(),
                  Obx(() {
                    return authController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: borderPinkColor,
                          ))
                        : RoundAppButton(title: "Login", onTap: onLogin);
                  }),
                  (12).spaceH(),
                ],
              ).paddingAll(20),
            ),

            // Obx(() =>
            // authController.isLoading.value
            //     ? const AppProgress()
            //     : const SizedBox.shrink()),
          ],
        );
      },
    );
  }
}

LoginReturnType loginReturnTypeFromJson(String str) =>
    LoginReturnType.fromJson(json.decode(str));

String loginReturnTypeToJson(LoginReturnType data) =>
    json.encode(data.toJson());

class LoginReturnType {
  String? email;
  String? password;
  String? phoneNumber;

  LoginReturnType({
    this.email,
    this.password,
    this.phoneNumber,
  });

  factory LoginReturnType.fromJson(Map<String, dynamic> json) =>
      LoginReturnType(
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
      };
}
