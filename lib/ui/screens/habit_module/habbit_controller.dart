import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_growth/api/repositories/habit_repo.dart';

import '../../../api/response_item.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/app_snack_bar.dart';

class HabitController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController habitNameCon = TextEditingController();
  bool isRemind = false;
  String startTime = '';

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

  int valuePerTap = 1;
  addFunction() {
    valuePerTap++;
    update();
  }

  removeFunction() {
    if (valuePerTap == 1) {
    } else {
      valuePerTap--;
    }

    update();
  }

  List<int> iconSelectedList = [0];
  List<Color?> colorList = [];
  Color? tempMainColor;
  List<String> iconList = [];
  RxBool isLoading = false.obs;
  addHabit() async {
    if (habitNameCon.text.isEmpty) {
      showAppSnackBar('Habit name must be required.');
    } else if (iconList.isEmpty) {
      showAppSnackBar('Icon must be required.');
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText, status: false);
      result = await HabitRepo.addHabit(
          habitName: habitNameCon.text,
          icon: iconList[0],
          iconColor: colorList.isNotEmpty ? colorList[0].toString() : "",
          isReminderOn: isRemind ? 1 : 0,
          logActivityUsing: isLogActivity,
          showBudge: isShowBadge ? 1 : 0,
          showGoal: isShowGoal ? 1 : 0);
      try {
        if (result.status) {
          isLoading.value = false;
          Get.back();
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
}
