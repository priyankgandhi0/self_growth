import 'package:get/get.dart';

class NoteHistoryController extends GetxController {
  List _isSelectedDay = [0];

  List get isSelectedDay => _isSelectedDay;

  set isSelectedDay(List value) {
    _isSelectedDay = value;
    update();
  }

  bool _showPlayer = false;

  bool get showPlayer => _showPlayer;

  set showPlayer(bool value) {
    _showPlayer = value;
    update();
  }
}
