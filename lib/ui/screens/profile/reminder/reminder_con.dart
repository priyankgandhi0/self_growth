import 'package:get/get_state_manager/get_state_manager.dart';

class ReminderController extends GetxController {
  bool _switchValue = true;

  bool get switchValue => _switchValue;

  set switchValue(bool value) {
    _switchValue = value;
    update();
  }

  bool _switchValue1 = true;

  bool get switchValue1 => _switchValue1;

  set switchValue1(bool value) {
    _switchValue1 = value;
    update();
  }
}
