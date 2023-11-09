import 'dart:io';

import 'package:get/get.dart';

import '../../../api/repositories/habit_repo.dart';
import '../../../api/response_item.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/add_photo_model.dart';
import '../../widgets/app_snack_bar.dart';

class AddPhotoController extends GetxController {
  RxBool isLoading = false.obs;
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
            isLoading.value = false;
            Get.back();
            showAppSnackBar(response.msg!, status: true);
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
