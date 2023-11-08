import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api/repositories/habit_repo.dart';
import '../../../api/response_item.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/get_hebit_model.dart';
import '../../../models/get_user_mood_model.dart';
import '../../widgets/app_snack_bar.dart';

class HomeController extends GetxController {
  List<String> dayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  List<String> noteList = ['Work', 'Family', 'Blessed'];

  int isSelectedDay = 0;
  int isSelectedHabit = 0;
  int isSelectedDayTick = 0;
  int isSelectedDayTick1 = 0;

  List<MoodData> moodData = [];
  List<HabitData> habitData = [];
  List<HabitData> quitData = [];
  List<HabitData> buildData = [];
  RxBool isLoading = false.obs;
  getUserHabit(String selectedDate) async {
    if (selectedDate.isEmpty) {
      showAppSnackBar('Please Select date.');
    } else {
      habitData.clear();
      quitData.clear();
      buildData.clear();
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText, status: false);
      result = await HabitRepo.getUserHabit(date: selectedDate);
      try {
        if (result.status) {
          GetHabitModel response = GetHabitModel.fromJson(result.toJson());
          if (response.data != null) {
            habitData.addAll(response.data!);
            for (var element in habitData) {
              if (element.habitType == 'Quit') {
                quitData.add(element);
              } else {
                buildData.add(element);
              }
            }
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
  }

  bool _showPlayer = false;

  bool get showPlayer => _showPlayer;

  set showPlayer(bool value) {
    _showPlayer = value;
    update();
  }

  getUserMood(String selectedDate) async {
    moodData.clear();
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    result = await HabitRepo.getUserMood(date: selectedDate);
    try {
      if (result.status) {
        GetUserMoodModel response = GetUserMoodModel.fromJson(result.toJson());
        if (response.data != null) {
          moodData.addAll(response.data!);
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

  checkInUserHabit(String habitId) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    result = await HabitRepo.checkInUserHabit(habitId: habitId);
    try {
      if (result.status) {
        showAppSnackBar(result.message, status: true);
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
