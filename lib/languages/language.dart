import 'package:get/get.dart';

import 'arabic_lan.dart';
import 'eng_lan.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar_AE': ArLanguage().arLanguage,
    'en_US': EnLanguage().enLanguage,
  };
}