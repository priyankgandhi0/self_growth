import 'package:get/get.dart';
import 'package:self_growth/ui/screens/add_photo/add_photo_screen.dart';
import 'package:self_growth/ui/screens/bottom_navigation/bottom_navigation_screen.dart';
import 'package:self_growth/ui/screens/habit_module/create_new_habit.dart';
import 'package:self_growth/ui/screens/habit_module/habit_predefined_screen.dart';
import 'package:self_growth/ui/screens/habit_module/new_habit_screen.dart';
import 'package:self_growth/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:self_growth/ui/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:self_growth/ui/screens/profile/profile_screen.dart';
import 'package:self_growth/ui/screens/self_discovery/self_discover/self_discover.dart';

import '../../ui/screens/auth/forget_password/change_password_screen.dart';
import '../../ui/screens/auth/forget_password/forget_password_screen.dart';
import '../../ui/screens/auth/personal_info/personal_info_screen.dart';
import '../../ui/screens/auth/sign_up/sign_up_screen.dart';
import '../../ui/screens/home_module/home_screen.dart';
import '../../ui/screens/home_module/mood_cheking/mood_checking_screen.dart';
import '../../ui/screens/home_module/note_history/note_history_screen.dart';
import '../../ui/screens/profile/reminder/reminder_screen.dart';
import '../../ui/screens/profile/subscription/subscription_screen.dart';
import '../../ui/screens/self_discovery/self_discover/questions_main.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String homeScreen = "/HomeScreen";
  static const String signIn = "/sign_in";
  static const String test = "/test";
  static const String onboarding = "/onboarding";
  static const String signUpScreen = "/signUpScreen";
  static const String personalInfoScreen = "/personalInfoScreen";
  static const String newHabitScreen = "/newHabitScreen";
  static const String habitPredefinedScreen = "/habitPredefinedScreen";
  static const String createNewHabitScreen = "/createNewHabitScreen";
  static const String profileScreen = "/profileScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String bottomNavigationScreen = "/bottomNavigationScreen";
  static const String subscriptionScreen = "/subscriptionScreen";
  static const String reminderScreen = "/reminderScreen";
  static const String selfDiscoverScreen = "/selfDiscoverScreen";
  static const String firstQuestionScreen = "/firstQuestionScreen";
  static const String noteHistoryScreen = "/noteHistoryScreen";
  static const String moodCheckingScreen = "/moodCheckingScreen";
  static const String addPhotoScreen = "/addPhotoScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String changePassVerificationScreen =
      "/changePassVerificationScreen";

  static List<GetPage> pages = [
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
        transition: Transition.downToUp),
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
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: editProfileScreen,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: bottomNavigationScreen,
      page: () => BottomNavigationScreen(),
    ),
    GetPage(
      name: subscriptionScreen,
      page: () => SubscriptionScreen(),
    ),
    GetPage(
      name: reminderScreen,
      page: () => ReminderScreen(),
    ),
    GetPage(
        name: selfDiscoverScreen,
        page: () => const SelfDiscoverScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: addPhotoScreen,
        page: () => const AddPhotoScreen(),
        transition: Transition.downToUp),
    GetPage(
      name: firstQuestionScreen,
      page: () => FirstQuestionScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: noteHistoryScreen,
      page: () => NoteHistoryScreen(),
    ),
    GetPage(
      name: moodCheckingScreen,
      page: () => MoodCheckingScreen(),
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
    ),
    GetPage(
      name: changePassVerificationScreen,
      page: () => ChangePassVerificationScreen(),
    ),
  ];
}
