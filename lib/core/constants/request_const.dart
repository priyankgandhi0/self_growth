// ignore_for_file: constant_identifier_names

import '../utils/preferences.dart';
import 'app_constant.dart';

class BaseUrl {
  static const String _DEV_BASE_URL =
      "http://codonnier.tech/dipak/nAPI/seral_app/dev/Service.php?";
  static const String _LIVE_BASE_URL =
      "http://codonnier.tech/dipak/nAPI/seral_app/dev/Service.php?";

  static const String URL = isLiveMode ? _LIVE_BASE_URL : _DEV_BASE_URL;
}

class ImageBaseUrl {
  static const String _IMAGE_DEV_BASE_URL =
      "http://codonnier.tech/dipak/nAPI/seral_app/";
  static const String _IMAGE_LIVE_BASE_URL =
      "http://codonnier.tech/dipak/nAPI/seral_app/";

  static const String URL =
      isLiveMode ? _IMAGE_LIVE_BASE_URL : _IMAGE_DEV_BASE_URL;

  static const String PROFILEIMAGEURL =
      "${ImageBaseUrl.URL}app_images/profile_images/";
  static const String IMAGEURL = "${ImageBaseUrl.URL}app_images/feed_items/";
}

Map<String, String> requestHeader({bool passAuth = false}) {
  return {
    RequestHeaderKey.contentType: "application/json",
    RequestHeaderKey.appSecret: "SERALAPP@GK2709#",
    RequestHeaderKey.appTrackVersion: "v1",
    RequestHeaderKey.appDeviceType:
        preferences.getString(SharedPreference.APP_DEVICE_TYPE) ?? '',
    RequestHeaderKey.appStoreVersion:
        preferences.getString(SharedPreference.APP_STORE_VERSION) ?? '',
    RequestHeaderKey.appDeviceModel:
        preferences.getString(SharedPreference.APP_DEVICE_MODEL) ?? '',
    RequestHeaderKey.appOsVersion:
        preferences.getString(SharedPreference.APP_OS_VERSION) ?? '',
    RequestHeaderKey.appStoreBuildNumber:
        preferences.getString(SharedPreference.APP_STORE_BUILD_NUMBER) ?? '',
    if (passAuth)
      RequestHeaderKey.authToken:
          preferences.getString(SharedPreference.AUTH_TOKEN) ?? '',
  };
}

class ApiEndPoint {
  static const login = "login";
  static const registration = "registration";
  static const forgotPassword = "forgotPassword";
  static const changePasswordWithVerifyCode = "changePasswordWithVerifyCode";
  static const getMentorList = "getMentorList";
  static const getHiredMentorHistoryList = "getHiredMentorHistoryList";
  static const getMentorReviewList = "getMentorReviewList";
  static const editProfile = "editProfile";
  static const logout = "logout";
  static const changePassword = "resetPassword";
}
