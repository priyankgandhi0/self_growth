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
      "gender": gender,
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
}
