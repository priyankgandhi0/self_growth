import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api/repositories/habit_repo.dart';
import '../../../api/response_item.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/request_const.dart';
import '../../../languages/all_strings.dart';
import '../../../loader_controller.dart';
import '../../../models/get_hebit_model.dart';
import '../../../models/get_user_mood_model.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/current_week_utils.dart';

class HomeController extends GetxController {
  List<String> dayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  // List<int> dateList = [
  //   DateTime.,
  //   DateTime.thursday,
  //   DateTime.wednesday,
  //   DateTime.thursday,
  //   DateTime.friday,
  //   DateTime.saturday,
  //   DateTime.sunday,
  // ];
  List<String> noteList = ['Work', 'Family', 'Blessed'];

  int isSelectedDay = 0;
  int isSelectedHabit = 0;
  List<int> isSelectedDayTick = [];
  List<int> isSelectedDayTick1 = [];

  RxBool stopPagination = false.obs;
  int page = 1;
  int pageHabit = 1;
  List<MoodData> _moodData = [];

  List<MoodData> get moodData => _moodData;

  set moodData(List<MoodData> value) {
    _moodData = value;
    update();
  }

  List<int> logActivityUsing = [];
  List<HabitData> _habitData = [];

  List<HabitData> get habitData => _habitData;

  set habitData(List<HabitData> value) {
    _habitData = value;
    update();
  }

  List<HabitData> _quitData = [];

  List<HabitData> get quitData => _quitData;

  set quitData(List<HabitData> value) {
    _quitData = value;
    update();
  }

  List<HabitData> _buildData = [];

  List<HabitData> get buildData => _buildData;

  set buildData(List<HabitData> value) {
    _buildData = value;
    update();
  }

  // RxBool isLoading = false.obs;
  getUserHabit(String selectedDate,
      {bool isLoad = true, bool isClear = true}) async {
    if (selectedDate.isEmpty) {
      showAppSnackBar('Please Select date.');
    } else {
      /*if (isClear) {
        Loader().showLoading();
        habitData.clear();
        quitData.clear();
        buildData.clear();
        pageHabit = 1;
      } else {
        Loader().hideLoading();
      }*/
      habitData.clear();
      quitData.clear();
      buildData.clear();
      Loader().showLoading();

      ResponseItem result =
          ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
      result = await HabitRepo.getUserHabit();
      try {
        if (result.status) {
          GetHabitModel response = GetHabitModel.fromJson(result.toJson());
          if (response.data != null) {
            habitData.addAll(response.data!);
            logActivityUsing.clear();
            habitData.forEach((element) {
              logActivityUsing.add(element.logActivityTap ?? 0);
            });
            // if (response.data!.length <= LIMIT) {
            //   stopPagination.value = true;
            // }
            // stopPagination.value = false;
            for (var element in habitData) {
              if (element.habitType == 'Quit') {
                quitData.add(element);
              } else {
                buildData.add(element);
              }
            }
          }
          Loader().hideLoading();
        } else {
          Loader().hideLoading();
          showAppSnackBar(result.message);
        }
      } catch (error) {
        Loader().hideLoading();
        showAppSnackBar( LanguageGlobalVar.errorText.tr);
      }
      Loader().hideLoading();
      update();
    }
  }

  getUserMood(String selectedDate,
      {bool isLoad = true, bool isClear = true}) async {
    if (isClear) {
      Loader().showLoading();
      moodData.clear();
      page = 1;
    } else {
      Loader().hideLoading();
    }

    isLoad ? Loader().showLoading() : Loader().hideLoading();
    ResponseItem result =
        ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
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
        Loader().hideLoading();
      } else {
        Loader().hideLoading();
        showAppSnackBar(result.message);
      }
    } catch (error) {
      Loader().hideLoading();
      showAppSnackBar( LanguageGlobalVar.errorText.tr);
    }
    Loader().hideLoading();
    update();
  }

  deleteUserHabit(String habitId, String selectedDate) async {
    moodData.clear();
    Loader().showLoading();
    ResponseItem result =
        ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
    result = await HabitRepo.deleteUserHabit(
      habitId: habitId,
    );
    try {
      if (result.status) {
        getUserHabit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        getUserMood(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        showAppSnackBar(result.message, status: true);
      } else {
        Loader().hideLoading();
        showAppSnackBar(result.message);
      }
    } catch (error) {
      Loader().hideLoading();
      showAppSnackBar( LanguageGlobalVar.errorText.tr);
    }

    update();
  }

  resetHabit(String habitId, String selectedDate) async {
    moodData.clear();
    Loader().showLoading();
    ResponseItem result =
        ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
    result = await HabitRepo.resetHabit(
      habitId: habitId,
    );
    try {
      if (result.status) {
        getUserHabit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        getUserMood(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        showAppSnackBar(result.message, status: true);
      } else {
        Loader().hideLoading();
        showAppSnackBar(result.message);
      }
    } catch (error) {
      Loader().hideLoading();
      showAppSnackBar( LanguageGlobalVar.errorText.tr);
    }

    update();
  }

  deleteMoodCheckin(String moodCheckInId, String selectedDate) async {
    moodData.clear();
    Loader().showLoading();
    ResponseItem result =
        ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
    result = await HabitRepo.deleteMoodCheckin(
      moodCheckInId: moodCheckInId,
    );
    try {
      if (result.status) {
        showAppSnackBar(result.message, status: true);
        page = 1;
        getUserMood(selectedDate, isLoad: true);
        getUserHabit(selectedDate, isLoad: true);
      } else {
        Loader().hideLoading();
        showAppSnackBar(result.message);
      }
    } catch (error) {
      Loader().hideLoading();
      showAppSnackBar( LanguageGlobalVar.errorText.tr);
    }

    update();
  }

  checkInUserHabit(String habitId) async {
    ResponseItem result =
        ResponseItem(data: null, message:  LanguageGlobalVar.errorText.tr, status: false);
    result = await HabitRepo.checkInUserHabit(habitId: habitId);
    try {
      if (result.status) {
        // getUserHabit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        showAppSnackBar(result.message, status: true);
        Loader().hideLoading();
      } else {
        Loader().hideLoading();
        showAppSnackBar(result.message);
      }
    } catch (error) {
      Loader().hideLoading();
      showAppSnackBar( LanguageGlobalVar.errorText.tr);
    }
    Loader().hideLoading();
    update();
  }
}
