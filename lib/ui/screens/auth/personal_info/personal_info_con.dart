import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constant.dart';

class PersonalInfoCon extends GetxController {
  TextEditingController nameCon = TextEditingController();
  TextEditingController genderCon = TextEditingController();
  TextEditingController ageCon = TextEditingController();
  Gender? gender;
}
