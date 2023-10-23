import 'package:get/get.dart';

import '../../../generated/assets.dart';

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
}
