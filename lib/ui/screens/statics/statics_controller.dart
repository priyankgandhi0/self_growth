import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../gen/assets.gen.dart';

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
}
