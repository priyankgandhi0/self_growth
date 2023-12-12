import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ReminderController extends GetxController {
  String startTime = '';
  String reminderUtcTime = '';
  TextEditingController noteCon = TextEditingController();

  bool _switchValue = true;

  bool get switchValue => _switchValue;

  set switchValue(bool value) {
    _switchValue = value;
    update();
  }

  bool _switchValue1 = true;

  bool get switchValue1 => _switchValue1;

  set switchValue1(bool value) {
    _switchValue1 = value;
    update();
  }
  int valuePerTap = 1;
  addFunction() {

      valuePerTap++;


    update();
  }

  removeFunction() {
    if (valuePerTap == 1) {
    } else {
      valuePerTap--;
    }

    update();
  }

  addReminder() {
    Get.back();
    noteCon.clear();
    reminderUtcTime = '';
    startTime = '';
  }
}
