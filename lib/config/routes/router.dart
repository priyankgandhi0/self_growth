import 'package:get/get.dart';

import '../../ui/screens/auth_module/personal_info_registration_screen.dart';
import '../../ui/screens/test/test_screen.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signIn = "/sign_in";
  static const String test = "/test";
  static const String personalInfoRegistrationScreen =
      "/PersonalInfoRegistrationScreen";

  static List<GetPage> pages = [
    GetPage(
      name: test,
      page: () => const Test(),
    ),
    GetPage(
      name: personalInfoRegistrationScreen,
      page: () => PersonalInfoRegistrationScreen(),
    )
  ];
}
