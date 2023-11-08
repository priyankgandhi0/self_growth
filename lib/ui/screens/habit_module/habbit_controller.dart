import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_growth/api/repositories/habit_repo.dart';

import '../../../api/response_item.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/app_snack_bar.dart';

class HabitController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController habitNameCon = TextEditingController();
  TextEditingController noteCon = TextEditingController();
  TextEditingController reminderNoteCon = TextEditingController();
  TextEditingController goalCon = TextEditingController();
  bool isRemind = false;
  String startTime = '';
  String reminderUtcTime = '';
  String goalTime = '0';

  bool isShowBadge = false;
  bool isShowGoal = false;
  String isHabitTypeBuild = "Build";
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

  int iconSelected = -1;
  String iconSelectedString = '';
  List<Color?> colorList = [];
  Color? tempMainColor;
  List<String> iconList = [];
  RxBool isLoading = false.obs;
  addHabit() async {
    // habit_name
    // icon
    // is_reminder_on
    // log_activity_using
    // show_badge
    // show_goal
    // habit_type
    if (habitNameCon.text.isEmpty) {
      showAppSnackBar('Habit name must be required.');
    } else if (iconSelectedString.isEmpty) {
      showAppSnackBar('Please select icon.');
    } else if (isRemind && startTime.isEmpty) {
      showAppSnackBar('Please select reminder time.');
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText, status: false);
      result = await HabitRepo.addHabit(
          habitName: habitNameCon.text,
          icon: iconSelectedString,
          iconColor: tempMainColor.toString(),
          isReminderOn: isRemind ? 1 : 0,
          reminderTime: startTime,
          goals: goalTime,
          groupName: "",
          habitType: isHabitTypeBuild,
          note: noteCon.text,
          reminderNote: reminderNoteCon.text,
          reminderUtcTime: reminderUtcTime,
          logActivityUsing: valuePerTap,
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
