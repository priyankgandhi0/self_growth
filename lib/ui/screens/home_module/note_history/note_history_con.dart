import 'package:get/get.dart';

import '../../../../api/repositories/habit_repo.dart';
import '../../../../api/response_item.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../models/get_user_mood_model.dart';
import '../../../widgets/app_snack_bar.dart';

class NoteHistoryController extends GetxController {
  List _isSelectedDay = [0];

  List get isSelectedDay => _isSelectedDay;

  set isSelectedDay(List value) {
    _isSelectedDay = value;
    update();
  }

  bool _showPlayer = false;

  bool get showPlayer => _showPlayer;

  set showPlayer(bool value) {
    _showPlayer = value;
    update();
  }

  RxBool isLoading = false.obs;
  List<MoodData> moodData = [];
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
}
