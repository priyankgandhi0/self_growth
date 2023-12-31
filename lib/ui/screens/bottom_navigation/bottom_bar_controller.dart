import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_growth/ui/screens/profile/profile_screen.dart';

import '../../../core/utils/app_helper.dart';
import '../self_discovery/discover_screen.dart';

class BottomBarController extends GetxController {
  int _isSelectedTab = 1;

  int get isSelectedTab => _isSelectedTab;

  set isSelectedTab(int value) {
    _isSelectedTab = value;
    update();
  }

  BottomNavEnum bottomNavEnum = BottomNavEnum.home;
  Widget? tab;

  void changeTab(BottomNavEnum bottomNavEnum) {
    this.bottomNavEnum = bottomNavEnum;

    switch (bottomNavEnum) {
      case BottomNavEnum.home:
        tab = const SizedBox();
        break;
      case BottomNavEnum.insight:
        tab = const SizedBox();
        break;
      case BottomNavEnum.add:
        tab = const SizedBox();
        break;
      case BottomNavEnum.discovery:
        tab = DiscoverScreen();
        break;
      case BottomNavEnum.profile:
        tab = ProfileScreen();
        break;
      default:
        tab;
    }
    update();
  }
}
