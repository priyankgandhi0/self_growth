import 'dart:convert';

import 'package:get/get.dart';
import 'package:self_growth/api/repositories/self_discovery_repo.dart';
import 'package:self_growth/generated/assets.dart';
import 'package:self_growth/models/quetion_model.dart';

import '../../../../api/response_item.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../languages/all_strings.dart';
import '../../../widgets/app_snack_bar.dart';

class SelfDiscoveryCon extends GetxController {
  List<ThirdQueModel> firstQueList = [
    ThirdQueModel(value: "A", title: "I don't hve this thought at all."),
    ThirdQueModel(value: 'B', title: 'I have this thought sometimes.'),
    ThirdQueModel(value: 'C', title: 'I have this thought often.'),
    ThirdQueModel(value: 'D', title: 'I have this thought all the time.'),
    // ThirdQueModel(value: Assets.iconsAwfull, title: 'Awfully'),
  ];
  int selectedAns = 0;
  List<Map<String, dynamic>> selectedQueAnsList = [];
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
  List<QuestionData> questionList = [];
  RxBool isLoading = false.obs;
  getQuestionList() async {
    questionList.clear();
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
    result = await SelfDiscoveryRepo.getQueList();
    try {
      if (result.status) {
        QuestionModel response = QuestionModel.fromJson(result.data);
        if (response.data != null) {
          questionList = response.data!;
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (error) {
      isLoading.value = false;
      showAppSnackBar( LanguageGlobalVar.errorText.tr);
    }
    update();
  }

  submitAnswer() async {
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
    result =
        await SelfDiscoveryRepo.submitAnswer(json.encode(selectedQueAnsList));
    try {
      if (result.status) {
        isQueAns = 2;
        showAppSnackBar(result.message, status: true);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (error) {
      isLoading.value = false;
      showAppSnackBar( LanguageGlobalVar.errorText.tr);
    }

    update();
  }

  questionOptionTap(int indexs) {
    selectedAns = selectedAns + indexs;
    selectedQueAnsList.add({
      "questions_id": questionList[index - 1].questionsId,
      "options": [
        {
          "options_1": "I don't have this thought at all.",
          "score_answer": "0",
          "is_selected": index == 0 ? 1 : 0
        },
        {
          "options_2": "I have this thought sometimes.",
          "score_answer": "1",
          "is_selected": index == 1 ? 1 : 0
        },
        {
          "options_3": "I have this thought often.",
          "score_answer": "2",
          "is_selected": index == 2 ? 1 : 0
        },
        {
          "options_4": "I have this thought all the time.",
          "score_answer": "3",
          "is_selected": index == 3 ? 1 : 0
        }
      ]
    });
    if (index <= 19 && index > 0) {
      index++;
    } else {
      isQueAns = 1;
    }
  }
}

class ThirdQueModel {
  String title;
  String value;
  ThirdQueModel({required this.value, required this.title});
}
/*
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
"My life is over.",*/
