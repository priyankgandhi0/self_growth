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

  int index = 1;
  List<String> questionList = [
    "I have to be the best at everything. | All-or-nothing thinking",
    "If something bad happens, it's all my fault. | Overgeneralization",
    "I never do anything right. | Mental filtering",
    "My friends don't really like me. | Disqualifying the positive",
    "I'm going to fail. | Jumping to conclusions",
    "My problems are bigger than anyone else's. | Magnification and minimization",
    "I'm such a loser. | Emotional reasoning",
    "I have to be perfect all the time. | 'Should' statements",
    "People are talking behind my back. | Personalization",
    "I'm going to be alone forever. | All-or-nothing thinking",
    "I'm a failure. | Over-generalization",
    "I can't do anything right. | Mental filtering",
    "No one cares about me. | Disqualifying the positive",
    "I'm going to make a fool of myself. | Jumping to conclusions",
    "My life is a mess. | Magnification and minimization",
    "I'm worthless. | Emotional reasoning",
    "I'm so stupid. | 'Should' statements",
    "People think I'm a loser. | Personalization",
    "I'm going to be a burden to everyone. | All-or-nothing thinking",
    "My life is over. | Over-generalization",
  ];
}

class ThirdQueModel {
  String title;
  String value;
  ThirdQueModel({required this.value, required this.title});
}
