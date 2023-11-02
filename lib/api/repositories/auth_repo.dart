import 'dart:io';

import 'package:http/http.dart' as http;

import '../../core/constants/app_constant.dart';
import '../../core/constants/request_const.dart';
import '../api_helper.dart';
import '../response_item.dart';

class AuthRepo {
  /// USER REGISTRATION
  static Future<ResponseItem> userRegistration(
      {required String userName,
      required String email,
      required String phoneNumber,
      required String age,
      required String gender,
      required String password}) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {
      "user_name": userName,
      "email": email,
      "phone_number": phoneNumber,
      "age": age,
      "gender": gender.replaceAll("Gender.", ""),
      "password": password
    };
    var queryParameters = {RequestParam.service: ApiEndPoint.registration};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, false);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> updateUserProfile({
    required String fullName,
    required String phoneNumber,
    File? profileImage,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var params = {"user_name": fullName, "phone_number": phoneNumber};
    http.MultipartFile image;

    var queryParameters = {RequestParam.service: ApiEndPoint.editProfile};

    if (profileImage != null) {
      image = http.MultipartFile(
        "profile_images",
        profileImage.readAsBytes().asStream(),
        profileImage.lengthSync(),
        filename: profileImage.path.split("/").last,
        // contentType: MediaType(mimeType[0], mimeType[1]),
      );
      String queryString = Uri(queryParameters: queryParameters).query;
      String requestUrl = BaseUrl.URL + queryString;
      result = await BaseApiHelper.uploadFile(
          requestUrl, profileImage: image, params);
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

  static Future<ResponseItem> changePassword(
      String oldPassword, String newPassword) async {
    ResponseItem result;
    bool status = true;
    dynamic data;

    String message = "";
    String refreshToken;

    var params = {"old_password": oldPassword, "new_password": newPassword};

    var queryParameters = {
      RequestParam.service: ApiEndPoint.changePassword,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;

    result = await BaseApiHelper.postRequest(requestUrl, params, true);
    status = result.status;
    data = result.data;
    message = result.message;
    refreshToken = result.refreshToken ?? '';

    return ResponseItem(
        data: data,
        message: message,
        status: status,
        refreshToken: refreshToken);
  }
}
