import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:self_growth/api/response_item.dart';
import 'package:self_growth/core/constants/app_constant.dart';
import 'package:self_growth/core/constants/request_const.dart';
import 'package:self_growth/core/utils/preferences.dart';

import 'api_exceptions.dart';

class BaseApiHelper {
  static Future<ResponseItem> postRequest(
      String endPoint, Map<String, dynamic>? requestData,
      {bool passAuth = false}) async {
    var queryParameters = {RequestParam.service: endPoint};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;

    return await http
        .post(Uri.parse(requestUrl),
            body: json.encode(requestData),
            headers: requestHeader(passAuth: passAuth))
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  static Future<ResponseItem> getRequest(String requestUrl) async {
    debugPrint("request:$requestUrl");

    return await http
        .get(Uri.parse(requestUrl))
        .then((response) => baseOnValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  static Future<ResponseItem> uploadFile(String endPoint,
      http.MultipartFile? profileImage, Map<String, String> requestData,
      {bool passAuth = false}) async {
    var queryParameters = {RequestParam.service: endPoint};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    var request = http.MultipartRequest("POST", Uri.parse(requestUrl));

    if (profileImage != null) request.files.add(profileImage);
    request.headers.addAll(requestHeader(passAuth: passAuth));
    request.fields.addAll(requestData);

    // log(request.toString(), name: "REQUEST");
    debugPrint(profileImage?.field);

    debugPrint("body:${json.encode(requestData)}");
    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse)
          .then((value) => onValue(value));
    }).onError((error, stackTrace) => onError(error));
  }

  static Future onValue(http.Response response) async {
    ResponseItem? result;

    final ResponseItem responseData =
        ResponseItem.fromJson(json.decode(response.body));
    bool status = false;
    String message;
    dynamic data = responseData;

    // log("responseCode: ${response.statusCode}", name: "response");
    if (response.statusCode == 200) {
      message = responseData.message;
      if (responseData.status) {
        status = true;
        data = responseData.data;
      } else {
        // log("logout: ${responseData.forceLogout}", name: 'logout');
        if (responseData.forceLogout!) {
          preferences.clearUserInfo();
          // Get.offAllNamed(Routes.signIn);
          message =
              "Admin Delete your account please contact admin for more detail.";
        } else {
          message = responseData.message;
        }
      }
    } else {
      debugPrint("response: $data");
      message = "Something went wrong.";
    }
    result = ResponseItem(data: data, message: message, status: status);
    // log("response: {data: ${result.data}, message: $message, status: $status}",
    //     name: APP_NAME);
    // log("message: ${result.message}", name: 'message');

    return result;
  }

  static Future baseOnValue(http.Response response) async {
    ResponseItem? result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool status = false;
    String message;
    dynamic data = responseData;

    debugPrint("responseCode: ${response.statusCode}");
    if (response.statusCode == 200) {
      message = "Ok";
      status = true;
      data = responseData;
    } else {
      // log("response: $data", name: 'eroor');
      message = "Something went wrong.";
    }
    result = ResponseItem(data: data, message: message, status: status);
    // log("response: {data: ${result.data}, message: $message, status: $status}",
    //     name: APP_NAME);
    return result;
  }

  static onError(error) {
    debugPrint("Error caused: $error");
    bool status = false;
    String message = "Unsuccessful request";
    if (error is SocketException) {
      message = ResponseException("No internet connection").toString();
    } else if (error is FormatException) {
      message = ResponseException("Something wrong in response.").toString() +
          error.toString();
    }
    return ResponseItem(data: null, message: message, status: status);
  }
}
