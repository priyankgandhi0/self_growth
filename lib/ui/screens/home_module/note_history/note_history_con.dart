// import 'package:get/get.dart';
//
// import '../../../../api/repositories/habit_repo.dart';
// import '../../../../api/response_item.dart';
// import '../../../../core/constants/app_strings.dart';
// import '../../../../core/constants/request_const.dart';
// import '../../../../models/get_user_mood_model.dart';
// import '../../../widgets/app_snack_bar.dart';
//
// class NoteHistoryController extends GetxController {
//   RxBool isLoading = false.obs;
//   List<MoodData> moodData = [];
//   RxBool stopPagination = false.obs;
//   int page = 1;
//   deleteMoodCheckin(String moodCheckInId, String selectedDate) async {
//     moodData.clear();
//     isLoading.value = true;
//     ResponseItem result =
//         ResponseItem(data: null, message: errorText, status: false);
//     result = await HabitRepo.deleteMoodCheckin(
//       moodCheckInId: moodCheckInId,
//     );
//     try {
//       if (result.status) {
//         showAppSnackBar(result.message, status: true);
//         getUserMood(selectedDate, true);
//         isLoading.value = false;
//       } else {
//         isLoading.value = false;
//         showAppSnackBar(result.message);
//       }
//     } catch (error) {
//       isLoading.value = false;
//       showAppSnackBar(errorText);
//     }
//     isLoading.value = false;
//     update();
//   }
//
//   getUserMood(String selectedDate, bool isLoad, {bool isClear = true}) async {
//     if (isClear) {
//       isLoading.value = true;
//       moodData.clear();
//     } else {
//       isLoading.value = isClear ? false : true;
//     }
//
//     isLoading.value = isLoad ? true : false;
//     ResponseItem result =
//         ResponseItem(data: null, message: errorText, status: false);
//     result = await HabitRepo.getUserMood(
//         date: selectedDate, page: page, limit: LIMIT);
//     try {
//       if (result.status) {
//         GetUserMoodModel response = GetUserMoodModel.fromJson(result.toJson());
//         if (response.data != null) {
//           moodData.addAll(response.data!);
//           if (response.data!.length <= LIMIT) {
//             stopPagination.value = true;
//           }
//           stopPagination.value = false;
//         }
//         isLoading.value = false;
//       } else {
//         isLoading.value = false;
//         showAppSnackBar(result.message);
//       }
//     } catch (error) {
//       isLoading.value = false;
//       showAppSnackBar(errorText);
//     }
//     isLoading.value = false;
//     update();
//   }
// }
