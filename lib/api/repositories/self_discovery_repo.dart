import '../../core/constants/app_constant.dart';
import '../../core/constants/request_const.dart';
import '../api_helper.dart';
import '../response_item.dart';

class SelfDiscoveryRepo {
  static Future<ResponseItem> getQueList() async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    var queryParameters = {RequestParam.service: ApiEndPoint.getQuestionsList};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.getRequest(
        requestUrl, requestHeader(passAuth: true));

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> submitAnswer(String queAnsJson) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {"answer_json": queAnsJson};
    var queryParameters = {RequestParam.service: ApiEndPoint.submitAnswer};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
