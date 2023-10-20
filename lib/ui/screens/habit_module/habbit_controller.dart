import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HabitController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isRemind = false;
  bool isHabitTypeBuild = true;
  AnimationController? animationController;
  @override
  void onInit() {
    // TODO: implement onInit
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.onInit();
  }
}
