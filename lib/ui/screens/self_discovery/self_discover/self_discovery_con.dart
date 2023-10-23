import 'package:get/get.dart';
import 'package:self_growth/generated/assets.dart';

class SelfDiscoveryCon extends GetxController {
  List<String> firstQueList = ['Great', 'Happy', 'Neutral', 'Sad', 'Awfully'];
  List<String> firstQueIconList = [
    Assets.iconsGreat,
    Assets.iconsHappy,
    Assets.iconsNatural,
    Assets.iconsSad,
    Assets.iconsAwfull,
  ];
  List<String> thirdQueList = [
    'You do have tendencies to repeat some destructive behaviors',
    'You may also have sleeping problems',
    'You tend to procrastinate daily tasks',
  ];
  List<ThirdQueModel> thirdQueModelList = [
    ThirdQueModel(
        title:
            'of our members managed to overcome their challenges completely in 4 weeks',
        value: '2%'),
    ThirdQueModel(
        title:
            'of our members have started with similar levels of stress and anxiety',
        value: '75%'),
    ThirdQueModel(
        title: 'of our members suffer from the same procrastination triggers',
        value: '40%'),
  ];
  int _isQueAns = 0;

  int get isQueAns => _isQueAns;

  set isQueAns(int value) {
    _isQueAns = value;
    update();
  }
}

class ThirdQueModel {
  String title;
  String value;
  ThirdQueModel({required this.value, required this.title});
}
