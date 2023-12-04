import '../../core/constants/app_constant.dart';
import '../../core/constants/request_const.dart';
import '../api_helper.dart';
import '../response_item.dart';

class StaticsRepo {
  static Future<ResponseItem> getFeelingsListRepo({
    required String fromDate,
    required String toDate,
  }) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    Map<String, dynamic> params = {"from_date": fromDate, "to_date": toDate};
    var queryParameters = {RequestParam.service: ApiEndPoint.getFeelingsList};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = BaseUrl.URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, params, true);

    status = result.status;

    data = result.data;
    var message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
