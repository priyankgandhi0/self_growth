import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:self_growth/api/repositories/statics_repo.dart';

import '../../../api/response_item.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../../loader_controller.dart';
import '../../../models/get_feeling_chart_model.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/current_week_utils.dart';

class StaticsController extends GetxController {
  List<String> dayList = ['Week', 'Month', 'Year'];

  int isSelectedTab = 0;
  final List<String> noteList = [
    'Work',
    'Family',
    'Blessed',
    'Work',
    'Family',
  ];
  final List<String> noteImageList = [
    Assets.icons.work.path,
    Assets.icons.family.path,
    Assets.icons.blessd.path,
    Assets.icons.work.path,
    Assets.icons.family.path,
  ];

  List<ChartData> chartData = [];
  getFeelingsList() async {
    chartData.clear();
    Loader().showLoading();
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    String fromDateValue =
        DateFormat('yyyy-MM-dd').format(findFirstDateOfTheWeek(DateTime.now()));
    String toDateValue =
        DateFormat('yyyy-MM-dd').format(findLastDateOfTheWeek(DateTime.now()));
    result = await StaticsRepo.getFeelingsListRepo(
        fromDate: fromDateValue, toDate: toDateValue);
    try {
      if (result.status) {
        GetFeelingChartModel response =
            GetFeelingChartModel.fromJson(result.toJson());
        if (response.data != null) {
          chartData.addAll(response.data ?? []);
        }
        Loader().hideLoading();
      } else {
        Loader().hideLoading();
        showAppSnackBar(result.message);
      }
    } catch (error) {
      Loader().hideLoading();
      showAppSnackBar(errorText);
    }

    update();
  }
}
