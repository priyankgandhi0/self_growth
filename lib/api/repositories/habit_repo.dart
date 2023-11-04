import '../../core/constants/app_constant.dart';
import '../../core/constants/request_const.dart';
import '../api_helper.dart';
import '../response_item.dart';

class HabitRepo {
  static Future<ResponseItem> addHabit({
    required String habitName,
    required String icon,
    required int isReminderOn,
    required int logActivityUsing,
    required int showBudge,
    required int showGoal,
    String iconColor = '',
    String goals = '',
    String reminderTime = '',
    String reminderNote = '',
    String groupName = '',
    String habitType = '',
    String note = '',
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {
      "habit_name": habitName,
      "icon": icon,
      "icon_color": iconColor,
      "goals": goals,
      "is_reminder_on": isReminderOn,
      "reminder_time": reminderTime,
      "reminder_note": reminderNote,
      "group_name": groupName,
      "habit_type": habitType,
      "log_activity_using": logActivityUsing,
      "show_badge": showBudge,
      "show_goal": showGoal,
      "note": note
    };
    var queryParameters = {RequestParam.service: ApiEndPoint.addHabit};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, false);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
