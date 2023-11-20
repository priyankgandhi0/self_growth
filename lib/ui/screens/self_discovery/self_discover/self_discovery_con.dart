import 'package:get/get.dart';
import 'package:self_growth/generated/assets.dart';

class SelfDiscoveryCon extends GetxController {
  List<ThirdQueModel> firstQueList = [
    ThirdQueModel(value: Assets.iconsGreat, title: 'Great'),
    ThirdQueModel(value: Assets.iconsHappy, title: 'Happy'),
    ThirdQueModel(value: Assets.iconsNatural, title: 'Neutral'),
    ThirdQueModel(value: Assets.iconsSad, title: 'Sad'),
    ThirdQueModel(value: Assets.iconsAwfull, title: 'Awfully'),
  ];
  ThirdQueModel selectedAns = ThirdQueModel(title: '', value: '');
  List<int> selectedAnsIndex = [];
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

  int index = 0;
  List<String> questionList = [
    "I have to be the best at everything.",
    "If something bad happens, it's all my fault.",
    "I never do anything right.",
    "My friends don't really like me.",
    "I'm going to fail.",
    "My problems are bigger than anyone else's.",
    "I'm such a loser.",
    "I have to be perfect all the time.",
    "People are talking behind my back.",
    "I'm going to be alone forever.",
    "I'm a failure.",
    "I can't do anything right.",
    "No one cares about me.",
    "I'm going to make a fool of myself.",
    "My life is a mess.",
    "I'm worthless.",
    "I'm so stupid.",
    "People think I'm a loser.",
    "I'm going to be a burden to everyone.",
    "My life is over.",
  ];
}

class ThirdQueModel {
  String title;
  String value;
  ThirdQueModel({required this.value, required this.title});
}
