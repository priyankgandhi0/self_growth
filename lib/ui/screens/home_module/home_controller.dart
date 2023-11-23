import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api/repositories/habit_repo.dart';
import '../../../api/response_item.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/request_const.dart';
import '../../../models/get_hebit_model.dart';
import '../../../models/get_user_mood_model.dart';
import '../../widgets/app_snack_bar.dart';

class HomeController extends GetxController {
  List<String> dayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  List<String> noteList = ['Work', 'Family', 'Blessed'];

  int isSelectedDay = 0;
  int isSelectedHabit = 0;
  List<int> isSelectedDayTick = [];
  List<int> isSelectedDayTick1 = [];

  RxBool stopPagination = false.obs;
  int page = 1;
  int pageHabit = 1;
  List<MoodData> moodData = [];
  List<HabitData> habitData = [];
  List<HabitData> quitData = [];
  List<HabitData> buildData = [];
  RxBool isLoading = false.obs;
  getUserHabit(String selectedDate,
      {bool isLoad = true, bool isClear = true}) async {
    if (selectedDate.isEmpty) {
      showAppSnackBar('Please Select date.');
    } else {
      if (isClear) {
        isLoading.value = true;
        habitData.clear();
        quitData.clear();
        buildData.clear();
        pageHabit = 1;
      } else {
        isLoading.value = isClear ? false : true;
      }

      ResponseItem result =
          ResponseItem(data: null, message: errorText, status: false);
      result =
          await HabitRepo.getUserHabit(date: selectedDate, page: pageHabit);
      try {
        if (result.status) {
          GetHabitModel response = GetHabitModel.fromJson(result.toJson());
          if (response.data != null) {
            habitData.addAll(response.data!);
            if (response.data!.length <= LIMIT) {
              stopPagination.value = true;
            }
            stopPagination.value = false;
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

  getUserMood(String selectedDate,
      {bool isLoad = true, bool isClear = true}) async {
    if (isClear) {
      isLoading.value = true;
      moodData.clear();
      page = 1;
    } else {
      isLoading.value = isClear ? false : true;
    }

    isLoading.value = isLoad ? true : false;
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    result = await HabitRepo.getUserMood(
        date: selectedDate, page: page, limit: LIMIT);
    try {
      if (result.status) {
        GetUserMoodModel response = GetUserMoodModel.fromJson(result.toJson());
        if (response.data != null) {
          moodData.addAll(response.data!);
          if (response.data!.length <= LIMIT) {
            stopPagination.value = true;
          }
          stopPagination.value = false;
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

  deleteUserHabit(String habitId, String selectedDate) async {
    moodData.clear();
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    result = await HabitRepo.deleteUserHabit(
      habitId: habitId,
    );
    try {
      if (result.status) {
        showAppSnackBar(result.message, status: true);
        getUserHabit(selectedDate);
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

  deleteMoodCheckin(String moodCheckInId, String selectedDate) async {
    moodData.clear();
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    result = await HabitRepo.deleteMoodCheckin(
      moodCheckInId: moodCheckInId,
    );
    try {
      if (result.status) {
        showAppSnackBar(result.message, status: true);
        page = 1;
        getUserMood(selectedDate, isLoad: true);
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
        getUserHabit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
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
