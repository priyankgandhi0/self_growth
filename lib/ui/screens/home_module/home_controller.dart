import 'package:get/get.dart';

class HomeController extends GetxController {
  List<String> dayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  List<String> noteList = ['Work', 'Family', 'Blessed'];
  List<int> _isSelectedDay = [0];

  List<int> get isSelectedDay => _isSelectedDay;

  set isSelectedDay(List<int> value) {
    _isSelectedDay = value;
    update();
  }
}
