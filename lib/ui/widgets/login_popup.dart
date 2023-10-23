import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

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
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.0.spaceH(),
            "Login".appTextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            20.0.spaceH(),
            AppTextField(
              textEditingController: emailController,
              labelText: "E-mail",
              hintText: "Email",
              validator: (value) {
                if (!value.isEmail) {
                  return "please enter valid email";
                }
              },
              suffixIcon: '',
              prefixIcon: '',
            ),
            20.0.spaceH(),
            AppTextField(
              textEditingController: phoneNumberController,
              labelText: "Phone number",
              hintText: "Phone number",
              validator: (value) {
                if (!value.isPhoneNumber) {
                  return "please enter valid phone number";
                }
              },
              keyboardType: const TextInputType.numberWithOptions(signed: true),
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
                  child: "Password".appTextStyle(
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
                    child: "Forgot password?".appTextStyle(
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
              hintText: "Password",
              obscureText: true,
              obscuringCharacter: '*',
              validator: (value) {
                if (value.isEmpty) {
                  return "please enter valid password";
                } else if (value.length < 6) {
                  return "The password must be 6 (six) character long";
                }
              },
              suffixIcon: '',
              prefixIcon: '',
            ),
            (20).spaceH(),
            RoundAppButton(
                title: "Login",
                onTap: () {
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
      ),
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
