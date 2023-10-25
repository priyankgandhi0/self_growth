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
  List<Color> colorList = [
    const Color(0xff296BCF),
    const Color(0xff3EBCD8),
    const Color(0xff57A9D7),
    const Color(0xffF67E7E),
    const Color(0xffC36F6F),
    const Color(0xff6AE09A),
  ];
  List<String> iconList = [
    "💼",
    "🔥",
    "⚽️",
    "🪁",
    "🏂",
    "🥇",
  ];
}
