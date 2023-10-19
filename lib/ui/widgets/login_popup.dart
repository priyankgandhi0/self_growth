import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

import '../../core/constants/app_strings.dart';
import 'app_button.dart';

class LoginPopup extends StatelessWidget {
  LoginPopup({Key? key, required this.onLogin, required this.onForgotPassword})
      : super(key: key);
  final Function(LoginReturnType) onLogin;
  final Function onForgotPassword;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          12.0.spaceH(),
          loginText.appTextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          20.0.spaceH(),
          AppTextField(
            textEditingController: emailController,
            labelText: emailText,
            hintText: enterEmailText,
            validator: (value) {
              if (!value.isEmail) {
                return pleaseEnterEmailText;
              }
            },
            suffixIcon: '',
            prefixIcon: '',
          ),
          20.0.spaceH(),
          AppTextField(
            textEditingController: phoneNumberController,
            labelText: phoneNumberText,
            hintText: enterPhoneNumberText,
            validator: (value) {
              if (!value.isPhoneNumber) {
                return pleaseEnterPhoneText;
              }
            },
            inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            suffixIcon: '',
            prefixIcon: '',
          ),
          20.0.spaceH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: passwordText.appTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              InkWell(
                onTap: () {
                  onForgotPassword();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: forgotPasswordText.appTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          (8).spaceH(),
          AppTextField(
            textEditingController: passwordController,
            hintText: enterPasswordText,
            validator: (value) {
              if (value.isEmpty) {
                return pleaseEnterPasswordText;
              } else if (value.length < 6) {
                return passwordMustBeSixDigit;
              }
            },
            suffixIcon: '',
            prefixIcon: '',
          ),
          (20).spaceH(),
          AppButton(
              title: loginText,
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  onLogin(LoginReturnType(
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text,
                    password: passwordController.text,
                  ));
                }
              }),
          (12).spaceH(),
        ],
      ).paddingAll(20),
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
