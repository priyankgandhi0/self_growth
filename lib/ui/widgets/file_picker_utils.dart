import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';

import '../../core/constants/app_strings.dart';
import '../../gen/assets.gen.dart';
import 'app_dialogs.dart';

class PickFile {
  void openImageChooser(
      {required BuildContext context, required Function onImageChose}) {
    openBottomDialogBox(
      context: context,
      padding: 240.w,
      child: Column(
        children: [
          ProfileDataCard(
            image: Assets.icons.camera.path,
            height: 32.w,
            title: 'Take Photo',
            onTap: () {
              imageFromCamera(context: context, onImageChose: onImageChose);
              Navigator.pop(context);
            },
          ),
          const CommonDivider().paddingSymmetric(vertical: 8.w),
          ProfileDataCard(
            image: Assets.icons.addPhoto.path,
            height: 32.w,
            title: 'Open Gallery',
            onTap: () {
              imageFormGallery(context: context, onImageChose: onImageChose);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void imageFormGallery(
      {required BuildContext context, required Function onImageChose}) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.files.single.path!));
        onImageChose(File(pickedFile.files.single.path!));
        log(pickedFile.files.single.path!);
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message: withoutPermissonAppCanErroText.tr,
            mainButton: Platform.isIOS
                ? SnackBarAction(
                    label: settingsText.tr,
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  )
                : null,
            duration: const Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
          message: toAccessThisFeturePleaseErrorText.tr,
          mainButton: SnackBarAction(
            label: settingsText.tr,
            textColor: Colors.amber,
            onPressed: () {
              openAppSettings();
            },
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }
  }

  void imageFromCamera(
      {required BuildContext context, required Function onImageChose}) async {
    // var status = await Permission.camera.request();
    // if (status.isGranted) {
    //   final pickedFile = await ImagePicker()
    //       .pickImage(source: ImageSource.camera, imageQuality: 100);
    //   if (pickedFile != null) {
    //     // controller.addImage(File(pickedFile.path));
    //     onImageChose(File(pickedFile.path));
    //   }
    //   return;
    // }
    // else if (status.isDenied) {
    //   Get.showSnackbar(
    //     GetSnackBar(
    //         message: withoutPermissonAppCanErroText.tr,
    //         mainButton: Platform.isIOS
    //             ? SnackBarAction(
    //                 label: settingsText.tr,
    //                 // textColor: Theme.of(context).accentColor,
    //                 onPressed: () {
    //                   openAppSettings();
    //                 },
    //               )
    //             : SnackBarAction(
    //                 label: settingsText.tr,
    //                 // textColor: Theme.of(context).accentColor,
    //                 onPressed: () {
    //                   openAppSettings();
    //                 },
    //               ),
    //         duration: Duration(seconds: 3)),
    //   );
    //   return;
    // }
    // else if (status.isPermanentlyDenied) {
    //   Get.showSnackbar(
    //     GetSnackBar(
    //         message: toAccessThisFeturePleaseErrorText.tr,
    //         mainButton: SnackBarAction(
    //           label: settingsText.tr,
    //           textColor: Colors.amber,
    //           onPressed: () {
    //             openAppSettings();
    //           },
    //         ),
    //         duration: Duration(seconds: 3)),
    //   );
    //   return;
    // }
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      // controller.addImage(File(pickedFile.path));
      onImageChose(File(pickedFile.path));
    }
    return;
  }

  void pickFileFormStorage(
      {required BuildContext context,
      required List<String> allowedExtension,
      required Function onFileChose}) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: allowedExtension
          // allowedExtensions: ['doc', 'pdf'],
          );
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.files.single.path!));
        onFileChose(File(pickedFile.files.single.path!));
        log(pickedFile.files.single.path!);
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message: withoutPermissonAppCanErroText.tr,
            mainButton: Platform.isIOS
                ? SnackBarAction(
                    label: settingsText.tr,
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  )
                : null,
            duration: const Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
          message: toAccessThisFeturePleaseErrorText.tr,
          mainButton: SnackBarAction(
            label: settingsText.tr,
            textColor: Colors.amber,
            onPressed: () {
              openAppSettings();
            },
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }
  }
}
