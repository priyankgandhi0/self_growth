import 'dart:io';

import '../../core/constants/app_constant.dart';
import '../../core/constants/request_const.dart';
import '../api_helper.dart';
import '../response_item.dart';
import 'package:http/http.dart' as http;

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
    String reminderUtcTime = '',
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
      "goal_times": goals,
      "is_reminder_on": isReminderOn,
      "reminder_time": reminderTime,
      "reminder_utc_time": reminderUtcTime,
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
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> moodChecking({
    File? moodImages,
    required String feeling,
    required String unhappyReason,
    required String howAreYouFeeling,
    required String type,
    required String title,
    required String note,
    File? audioPath,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    http.MultipartFile image;
    Map<String, String> params = {
      "feeling": feeling, // Unhappy, Normal, Happy
      "unhappy_reason": unhappyReason,
      "how_are_you_feeling": howAreYouFeeling,
      'type': type,
      "note": note,
      "title": title
    };
    var queryParameters = {RequestParam.service: ApiEndPoint.moodChecking};
    if (moodImages != null) {
      image = http.MultipartFile(
        "mood_images",
        moodImages.readAsBytes().asStream(),
        moodImages.lengthSync(),
        filename: moodImages.path.split("/").last,
        // contentType: MediaType(mimeType[0], mimeType[1]),
      );
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = BaseUrl.URL + queryString;
      result = await BaseApiHelper.uploadFile(
          requestUrl, profileImage: image, params, passAuth: true);
    } else if (audioPath != null) {
      image = http.MultipartFile(
        "audio_file",
        audioPath.readAsBytes().asStream(),
        audioPath.lengthSync(),
        filename: audioPath.path.split("/").last,
        // contentType: MediaType(mimeType[0], mimeType[1]),
      );
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = BaseUrl.URL + queryString;
      result = await BaseApiHelper.uploadFile(
          requestUrl, profileImage: image, params, passAuth: true);
    } else {
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = BaseUrl.URL + queryString;
      result = await BaseApiHelper.uploadFile(requestUrl, params);
    }

    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> editMoodChecking({
    File? moodImages,
    required String feeling,
    required String moodId,
    required String unhappyReason,
    required String howAreYouFeeling,
    required String type,
    required String title,
    required String note,
    File? audioPath,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    http.MultipartFile image;
    Map<String, String> params = {
      "user_mood_id": moodId,
      "feeling": feeling, // Unhappy, Normal, Happy
      "unhappy_reason": unhappyReason,
      "how_are_you_feeling": howAreYouFeeling,
      'type': type,
      "note": note,
      "title": title
    };
    var queryParameters = {RequestParam.service: ApiEndPoint.editMoodChecking};
    if (moodImages != null) {
      image = http.MultipartFile(
        "mood_images",
        moodImages.readAsBytes().asStream(),
        moodImages.lengthSync(),
        filename: moodImages.path.split("/").last,
        // contentType: MediaType(mimeType[0], mimeType[1]),
      );
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = BaseUrl.URL + queryString;
      result = await BaseApiHelper.uploadFile(
          requestUrl, profileImage: image, params, passAuth: true);
    } else if (audioPath != null) {
      image = http.MultipartFile(
        "audio_file",
        audioPath.readAsBytes().asStream(),
        audioPath.lengthSync(),
        filename: audioPath.path.split("/").last,
        // contentType: MediaType(mimeType[0], mimeType[1]),
      );
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = BaseUrl.URL + queryString;
      result = await BaseApiHelper.uploadFile(
          requestUrl, profileImage: image, params, passAuth: true);
    } else {
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = BaseUrl.URL + queryString;
      result = await BaseApiHelper.uploadFile(requestUrl, params);
    }

    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> getUserHabit({
    required String date,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {"date": date, "page": 1, "limit": 10};
    var queryParameters = {RequestParam.service: ApiEndPoint.getUserHabit};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> deleteUserHabit({
    required String habitId,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {"habit_id": habitId};
    var queryParameters = {RequestParam.service: ApiEndPoint.deleteUserHabit};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> deleteMoodCheckin({
    required String moodCheckInId,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {"user_mood_id": moodCheckInId};
    var queryParameters = {RequestParam.service: ApiEndPoint.deleteMoodCheckin};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> getUserMood({
    required String date,
    int? page,
    int? limit,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {
      "date": date,
      "page": page ?? 1,
      "limit": LIMIT
    };
    var queryParameters = {RequestParam.service: ApiEndPoint.getUserMood};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> checkInUserHabit({
    required String habitId,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {"habit_id": habitId};
    var queryParameters = {RequestParam.service: ApiEndPoint.checkInUserHabit};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> getFeelingList() async {
    bool status = false;
    ResponseItem result;
    dynamic data;

    var queryParameters = {RequestParam.service: ApiEndPoint.getFeelingList};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.getRequest(
        requestUrl, requestHeader(passAuth: true));

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> getActivityList() async {
    bool status = false;
    ResponseItem result;
    dynamic data;

    var queryParameters = {RequestParam.service: ApiEndPoint.getActivityList};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.getRequest(
        requestUrl, requestHeader(passAuth: true));

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> addActivity(
      {required String name, required String icon}) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {"name": name, "icon": icon};
    var queryParameters = {RequestParam.service: ApiEndPoint.addActivity};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> addFeeling(
      {required String name, required String icon}) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {"name": name, "icon": icon};
    var queryParameters = {RequestParam.service: ApiEndPoint.addFeeling};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> addMoodPhoto({
    required File moodImages,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    http.MultipartFile image;

    var queryParameters = {RequestParam.service: ApiEndPoint.addMoodPhoto};

    image = http.MultipartFile(
      "mood_images",
      moodImages.readAsBytes().asStream(),
      moodImages.lengthSync(),
      filename: moodImages.path.split("/").last,
      // contentType: MediaType(mimeType[0], mimeType[1]),
    );
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.uploadFile(
        requestUrl, profileImage: image, {}, passAuth: true);

    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
