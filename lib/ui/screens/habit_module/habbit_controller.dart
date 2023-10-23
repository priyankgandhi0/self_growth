import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HabitController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isRemind = false;
  int isHabitTypeBuild = 0;
  int isLogActivity = 0;
  AnimationController? animationController;
  @override
  void onInit() {
    // TODO: implement onInit
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.onInit();
  }
}
