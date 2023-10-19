import 'package:get/get.dart';
import 'package:self_growth/ui/screens/habit_module/create_new_habit.dart';
import 'package:self_growth/ui/screens/habit_module/habit_predefined_screen.dart';
import 'package:self_growth/ui/screens/habit_module/new_habit_screen.dart';
import 'package:self_growth/ui/screens/onboarding_screen/onboarding_screen.dart';

import '../../ui/screens/auth/personal_info/personal_info_screen.dart';
import '../../ui/screens/auth/sign_up/sign_up_screen.dart';
import '../../ui/screens/test/test_screen.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signIn = "/sign_in";
  static const String test = "/test";
  static const String onboarding = "/onboarding";
  static const String signUpScreen = "/signUpScreen";
  static const String personalInfoScreen = "/personalInfoScreen";
  static const String newHabitScreen = "/newHabitScreen";
  static const String habitPredefinedScreen = "/habitPredefinedScreen";
  static const String createNewHabitScreen = "/createNewHabitScreen";

  static List<GetPage> pages = [
    GetPage(
      name: test,
      page: () => const Test(),
    ),
    GetPage(
      name: createNewHabitScreen,
      page: () => CreateNewHabitScreen(),
    ),
    GetPage(
      name: habitPredefinedScreen,
      page: () => const HabitPredefinedScreen(),
    ),
    GetPage(
      name: newHabitScreen,
      page: () => const NewHabitScreen(),
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
