import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HabitController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isRemind = false;
  bool isShowBadge = false;
  bool isShowGoal = false;
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

  List<int> iconSelectedList = [0];
  List<ColorSwatch?> colorList = [];
  ColorSwatch? mainColor = Colors.blue;
  ColorSwatch? tempMainColor;
  List<String> iconList = [];
}
