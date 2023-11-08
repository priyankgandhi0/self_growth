import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../api/repositories/habit_repo.dart';
import '../../../../api/response_item.dart';
import '../../../../core/constants/app_strings.dart';

import '../../../../models/get_activity_model.dart';
import '../../../widgets/app_snack_bar.dart';

class MoodCheckingCon extends GetxController {
  TextEditingController addActivityCon = TextEditingController();
  TextEditingController addFeelingCon = TextEditingController();
  TextEditingController titleCon = TextEditingController();
  TextEditingController noteCon = TextEditingController();
  TextEditingController searchCon = TextEditingController();

  String activityEmoji = '';
  String feelingEmoji = '';

  List<String> howAreYouFeeling = [];
  List<String> unhappyReason = [];

  String getMood() {
    String feeling = 'Unhappy';
    if (sliderValue < 50.0) {
      feeling = 'Unhappy';
    } else if (sliderValue >= 50.0 && sliderValue < 75.0) {
      feeling = 'Normal';
    } else if (sliderValue == 100.00) {
      feeling = 'Happy';
    }

    return feeling;
  }

  double sliderValue = 0.0;

  RxBool isLoading = false.obs;
  moodChecking() async {
    if (unhappyReason.isEmpty) {
      showAppSnackBar('Please Select your Unhappy reason.');
    } else if (howAreYouFeeling.isEmpty) {
      showAppSnackBar('Please Select your feeling.');
    } else {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText, status: false);
      result = await HabitRepo.moodChecking(
          feeling: getMood(),
          howAreYouFeeling: howAreYouFeeling
              .toString()
              .replaceAll('[', "")
              .replaceAll(']', ""),
          unhappyReason:
              unhappyReason.toString().replaceAll('[', "").replaceAll(']', ""));
      try {
        if (result.status) {
          Get.back();
          isLoading.value = false;
          showAppSnackBar(result.message, status: true);
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (error) {
        isLoading.value = false;
        showAppSnackBar(errorText);
      }
      isLoading.value = false;
      update();
    }
  }

  List<ActivityData> _activityList = [];

  List<ActivityData> get activityList => _activityList;

  set activityList(List<ActivityData> value) {
    _activityList = value;
    update();
  }

  List<ActivityData> _feelingList = [];

  List<ActivityData> get feelingList => _feelingList;

  set feelingList(List<ActivityData> value) {
    _feelingList = value;
    update();
  }

  getActivityList() async {
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    result = await HabitRepo.getActivityList();
    activityList.clear();
    try {
      if (result.status) {
        GetActivityModel response = GetActivityModel.fromJson(result.data);
        if (response.data != null) {
          activityList = response.data!;
        }

        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (error) {
      isLoading.value = false;
      showAppSnackBar(errorText);
    }
    isLoading.value = false;
    update();
  }

  getFeelingList() async {
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    result = await HabitRepo.getFeelingList();
    feelingList.clear();
    try {
      if (result.status) {
        GetActivityModel response = GetActivityModel.fromJson(result.data);
        if (response.data != null) {
          feelingList = response.data!;
        }

        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (error) {
      isLoading.value = false;
      showAppSnackBar(errorText);
    }
    isLoading.value = false;
    update();
  }

  addFeeling() async {
    Get.back();
    if (feelingEmoji.isEmpty) {
      showAppSnackBar('Feeling Icon must be required.');
    } else if (addFeelingCon.text.isEmpty) {
      showAppSnackBar('Feeling name must be required.');
    } else {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText, status: false);
      result = await HabitRepo.addFeeling(
          icon: feelingEmoji, name: addFeelingCon.text);
      try {
        if (result.status) {
          showAppSnackBar('Felling add successfully.', status: true);
          getFeelingList();
          feelingEmoji = '';
          addFeelingCon.clear();
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (error) {
        isLoading.value = false;
        showAppSnackBar(errorText);
      }
      isLoading.value = false;
      update();
    }
  }

  addActivity() async {
    Get.back();
    if (activityEmoji.isEmpty) {
      showAppSnackBar('Activity Icon must be required.');
    } else if (addActivityCon.text.isEmpty) {
      showAppSnackBar('Activity name must be required.');
    } else {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText, status: false);
      result = await HabitRepo.addActivity(
          icon: activityEmoji, name: addActivityCon.text);
      try {
        if (result.status) {
          showAppSnackBar('Activity add successfully.', status: true);
          getActivityList();
          activityEmoji = '';
          addActivityCon.clear();
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (error) {
        isLoading.value = false;
        showAppSnackBar(errorText);
      }
      isLoading.value = false;
      update();
    }
  }
}
