import 'package:get/get_state_manager/get_state_manager.dart';

class ReminderController extends GetxController {
  bool _switchValue = true;

  bool get switchValue => _switchValue;

  set switchValue(bool value) {
    _switchValue = value;
    update();
  }
}
