import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';

class SubscriptionCon extends GetxController {
  List<String> subscriptionList = [
    'Habit tool',
    'Self Discovery',
    '1 reviewing section'
  ];
  List<String> subscriptionImageList = [
    Assets.iconsHabitTool,
    Assets.iconsSelfDis,
    Assets.iconsReview,
  ];
  final PageController pageController = PageController();
  int _initialPage = 0;

  int get initialPage => _initialPage;

  set initialPage(int value) {
    _initialPage = value;
    update();
  }
}
