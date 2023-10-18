import 'package:get/get.dart';
import 'package:self_growth/ui/screens/home_screen/home_screen.dart';

class Routes {
  Routes._();

  static const String splash = "/splash";
  static const String signIn = "/sign_in";
  static const String home = "/home";

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    )
  ];
}
