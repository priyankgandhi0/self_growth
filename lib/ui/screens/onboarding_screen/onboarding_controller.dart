import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  int _initialPage = 0;

  int get initialPage => _initialPage;

  set initialPage(int value) {
    _initialPage = value;
    update();
  }
}
