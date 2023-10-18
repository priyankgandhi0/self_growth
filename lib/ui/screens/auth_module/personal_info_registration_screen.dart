import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

import '../../../core/constants/app_constant.dart';
import '../../widgets/start_up_text_field.dart';
import 'auth_controller.dart';

class PersonalInfoRegistrationScreen extends StatelessWidget {
  PersonalInfoRegistrationScreen({Key? key}) : super(key: key);
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (ctrl) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  16.spaceW(),
                  const Icon(Icons.arrow_back_ios_new_rounded)
                ],
              ),
              "Personal \nInformation"
                  .appTextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start)
                  .paddingSymmetric(horizontal: 20, vertical: 24),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                width: Get.width,
                child: Column(
                  children: [
                    AppTextField(
                      labelText: "Name",
                      textEditingController: TextEditingController(),
                      hintText: "Name",
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
                    AppTextField(
                      labelText: "Age",
                      textEditingController: TextEditingController(),
                      hintText: "Age",
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                    AppTextField(
                      labelText: "Gender",
                      textEditingController: TextEditingController(),
                      hintText: "Password",
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
                    20.spaceH(),
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
                ).paddingAll(20),
              ).paddingAll(16)
            ],
          );
        }),
      ),
    );
  }
}
