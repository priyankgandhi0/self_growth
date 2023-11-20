import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api/repositories/habit_repo.dart';
import '../../../api/response_item.dart';
import '../../../config/routes/router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/add_photo_model.dart';
import '../../widgets/app_snack_bar.dart';
import '../home_module/home_controller.dart';

class AddPhotoController extends GetxController {
  RxBool isLoading = false.obs;
  File? imagePath;
  addMoodPhoto(File imageFile) async {
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);

    result = await HabitRepo.addMoodPhoto(moodImages: imageFile);

    try {
      if (result.status) {
        if (result.data != null) {
          AddPhotoModel response = AddPhotoModel.fromJson(result.toJson());
          if (response.data != null) {
            Get.find<HomeController>()
                .getUserMood(DateFormat('yyyy-MM-dd').format(DateTime.now()));
            isLoading.value = false;
            showAppSnackBar(response.msg!, status: true);
            // log('response.data--${response.data}');
            Get.toNamed(Routes.moodCheckingScreen);
          }

          // Get.toNamed(Routes.selfDiscoverScreen);
        }
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (error) {
      isLoading.value = false;
      showAppSnackBar(errorText);
    }
    isLoading.value = false;
    update();
  }

  DateTime selectedDate = DateTime.now();
}
