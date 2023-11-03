import 'package:get/get.dart';

import '../../../config/routes/router.dart';
import '../../../core/utils/preferences.dart';
import '../../../generated/assets.dart';
import '../../widgets/app_snack_bar.dart';

class ProfileController extends GetxController {
  List<String> profileList = [
    'My subscription',
    'Reminder',
    'Privacy and Policy',
    'Important numbers',
    'Language'
  ];

  List<String> imagePath = [
    Assets.iconsMySubscription,
    Assets.iconsBell,
    Assets.iconsPrivacy,
    Assets.iconsImpNumber,
    Assets.iconsLang,
  ];

  logOut() {
    preferences.clearUserItem();
    preferences.putBool(SharedPreference.IS_LOG_IN, false);
    Get.offAllNamed(Routes.onboarding);
    showAppSnackBar('Logout Successfully.', status: true);
  }
}
