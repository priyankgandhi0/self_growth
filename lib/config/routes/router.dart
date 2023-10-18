import 'package:get/get.dart';
import 'package:self_growth/ui/screens/home_screen/home_screen.dart';
import 'package:self_growth/ui/screens/onboarding_screen/onboarding_screen.dart';

import '../../ui/screens/auth/personal_info/personal_info_screen.dart';
import '../../ui/screens/auth/sign_up/sign_up_screen.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signIn = "/sign_in";
  static const String home = "/home";
  static const String onboarding = "/onboarding";
  static const String signUpScreen = "/signUpScreen";
  static const String personalInfoScreen = "/personalInfoScreen";

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: onboarding,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: personalInfoScreen,
      page: () => PersonalInfoScreen(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
    ),
  ];
}
