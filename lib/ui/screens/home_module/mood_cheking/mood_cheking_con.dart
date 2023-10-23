import 'package:get/get.dart';

import '../../../../generated/assets.dart';

class MoodCheckingCon extends GetxController {
  int _isSelect = 0;

  int get isSelect => _isSelect;

  set isSelect(int value) {
    _isSelect = value;
    update();
  }

  int _isSelect1 = 0;

  int get isSelect1 => _isSelect1;

  set isSelect1(int value) {
    _isSelect1 = value;
    update();
  }

  double sliderValue = 0.0;

  List<String> moodList = [
    'Happy',
    'Sad',
    'Unhappy',
    'Blessed',
    'Happy',
    'Sad',
    'Unhappy',
    'Blessed',
    'Happy',
    'Sad',
    'Unhappy',
    'Blessed',
  ];
  List<String> moodImageList = [
    Assets.iconsHappy,
    Assets.iconsSad,
    Assets.iconsNatural,
    Assets.iconsBlessd,
    Assets.iconsHappy,
    Assets.iconsSad,
    Assets.iconsNatural,
    Assets.iconsBlessd,
    Assets.iconsHappy,
    Assets.iconsSad,
    Assets.iconsNatural,
    Assets.iconsBlessd,
  ];
}
