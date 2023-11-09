import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';

import 'package:self_growth/ui/screens/bottom_navigation/bottom_bar_controller.dart';
import 'package:self_growth/ui/screens/home_module/home_controller.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';

import '../../../config/routes/router.dart';
import '../../../core/utils/app_helper.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/file_picker_utils.dart';
import '../home_module/home_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({Key? key}) : super(key: key);
  final BottomBarController bottomBarController =
      Get.put(BottomBarController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: GetBuilder<BottomBarController>(builder: (ctrl) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: background_EBEBEB,
          floatingActionButton: Visibility(
              visible: ctrl.isSelectedTab == 4 && bottomBarController.isOpen,
              child: Assets.icons.floatButton.svg().paddingOnly(bottom: 80.w)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,

          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: Get.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage(Assets.images.backGroundImage.path),
                            fit: BoxFit.fill)),
                    child: SafeArea(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ctrl.tab ?? HomeScreen(),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: ctrl.isOpenDialog,
                    child: OpenBottomDialog(
                      context: context,
                      onTap: () {
                        ctrl.isOpenDialog = false;
                        ctrl.update();
                      },
                      child: ctrl.isOpenHomeDialog == 0
                          ? const AddButtonCard()
                          : ctrl.isOpenHomeDialog == 1
                              ? QuitHabitDialog()
                              : ctrl.isOpenHomeDialog == 2
                                  ? const AddPhotoDialog()
                                  : const SizedBox(),
                    ),
                  ),
                ],
              ),
              bottomBarWidget(ctrl, context),
            ],
          ),
        );
      }),
    );
  }

  Container bottomBarWidget(BottomBarController ctrl, BuildContext context) {
    return Container(
      height: 86.w,
      decoration: BoxDecoration(
          color: white_FFFFFF,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomBarWidget(
            title: 'Home',
            icon: Assets.icons.home.path,
            color: ctrl.isSelectedTab == 1 ? borderPurpleColor : doteColor,
            iconColor: ctrl.isSelectedTab == 1 ? borderPurpleColor : doteColor,
            onTap: () {
              ctrl.isSelectedTab = 1;
              ctrl.changeTab(BottomNavEnum.home);
              ctrl.isOpenHomeDialog = -1;
              ctrl.isOpenDialog = false;
              ctrl.update();
            },
          ),
          BottomBarWidget(
            icon: Assets.icons.chart.path,
            title: 'Insight',
            color: ctrl.isSelectedTab == 2 ? borderPurpleColor : doteColor,
            iconColor: ctrl.isSelectedTab == 2 ? borderPurpleColor : doteColor,
            onTap: () {
              ctrl.isSelectedTab = 2;

              ctrl.changeTab(BottomNavEnum.insight);
              ctrl.isOpenHomeDialog = -1;
              ctrl.isOpenDialog = false;
              ctrl.update();
            },
          ),
          BottomBarWidget(
            title: '',
            widget: Assets.icons.menu.svg(),
            color: ctrl.isSelectedTab == 3 ? borderPurpleColor : doteColor,
            onTap: () {
              ctrl.isOpenDialog = true;
              ctrl.isOpenHomeDialog = 0;
              ctrl.isSelectedTab = 3;
              // ctrl.changeTab(BottomNavEnum.home);

              /* openBottomDialogBox(
                  padding: 400.w,
                  child: Column(
                    children: [
                      ProfileDataCard(
                        image: Assets.icons.moodCheck.path,
                        height: 32.w,
                        title: 'Mood Checking',
                        onTap: () {
                          Get.back();
                          Get.toNamed(Routes.moodCheckingScreen);
                        },
                      ),
                      const CommonDivider().paddingSymmetric(vertical: 8.w),
                      ProfileDataCard(
                          image: Assets.icons.voiceNote.path,
                          height: 32.w,
                          title: 'Voice Note'),
                      const CommonDivider().paddingSymmetric(vertical: 8.w),
                      ProfileDataCard(
                          image: Assets.icons.addPhoto.path,
                          height: 32.w,
                          onTap: () {
                            Get.back();
                            Get.toNamed(Routes.addPhotoScreen);
                          },
                          title: 'Add Photo')
                    ],
                  ),
                  context: context);*/
              ctrl.update();
            },
            icon: '',
          ),
          BottomBarWidget(
            icon: Assets.icons.discovery.path,
            title: 'Discovery',
            iconColor: ctrl.isSelectedTab == 4 ? borderPurpleColor : doteColor,
            color: ctrl.isSelectedTab == 4 ? borderPurpleColor : doteColor,
            onTap: () {
              ctrl.isSelectedTab = 4;
              ctrl.changeTab(BottomNavEnum.discovery);
              ctrl.isOpen = false;
              ctrl.isOpenDialog = false;
              ctrl.isOpenHomeDialog = -1;
              ctrl.update();
            },
          ),
          BottomBarWidget(
            icon: Assets.icons.user.path,
            title: 'Profile',
            color: ctrl.isSelectedTab == 5 ? borderPurpleColor : doteColor,
            iconColor: ctrl.isSelectedTab == 5 ? borderPurpleColor : doteColor,
            onTap: () {
              ctrl.isSelectedTab = 5;

              ctrl.changeTab(BottomNavEnum.profile);
              ctrl.isOpenDialog = false;
              ctrl.isOpenHomeDialog = -1;
              ctrl.update();
            },
          ),
        ],
      ),
    );
  }
}

class AddButtonCard extends StatelessWidget {
  const AddButtonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(builder: (ctrl) {
      return Column(
        children: [
          ProfileDataCard(
            image: Assets.icons.moodCheck.path,
            height: 32.w,
            title: 'Mood Checking',
            onTap: () {
              ctrl.isOpenDialog = false;
              ctrl.update();
              Get.toNamed(Routes.moodCheckingScreen);
            },
          ),
          const CommonDivider().paddingSymmetric(vertical: 8.w),
          ProfileDataCard(
              image: Assets.icons.voiceNote.path,
              height: 32.w,
              onTap: () {
                ctrl.isOpenDialog = false;
                ctrl.update();
                Get.toNamed(Routes.voiceNoteScreen);
              },
              title: 'Voice Note'),
          const CommonDivider().paddingSymmetric(vertical: 8.w),
          ProfileDataCard(
              image: Assets.icons.addPhoto.path,
              height: 32.w,
              onTap: () {
                ctrl.isOpenDialog = true;
                ctrl.isOpenHomeDialog = 2;
                ctrl.update();
              },
              title: 'Add Photo'),
        ],
      );
    });
  }
}

class QuitHabitDialog extends StatelessWidget {
  QuitHabitDialog({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(builder: (ctrl) {
      return Column(
        children: [
          ProfileDataCard(
              image: Assets.icons.resetHabit.path,
              height: 24.w,
              title: 'Reset habit'),
          const CommonDivider().paddingSymmetric(vertical: 10.w),
          ProfileDataCard(
              onTap: () {
                ctrl.isOpenDialog = false;
                ctrl.update();
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                      title: 'Delete habit',
                      description: 'Are you sure to delete habit?',
                      onCancel: () {
                        Get.back();
                      },
                      isCancel: true,
                      textConfirm: 'Delete',
                      textCancel: 'Cancel',
                      onConfirm: () {
                        homeController.deleteUserHabit(
                            ctrl.deleteHabitId.toString(), ctrl.selectedDate);

                        ctrl.update();
                      },
                    );
                  },
                );
              },
              image: Assets.icons.delete.path,
              height: 24.w,
              title: 'Delete habit')
        ],
      );
    });
  }
}

class AddPhotoDialog extends StatelessWidget {
  const AddPhotoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(builder: (ctrl) {
      return Column(
        children: [
          ProfileDataCard(
            image: Assets.icons.camera.path,
            height: 32.w,
            title: 'Take Photo',
            onTap: () {
              PickFile().imageFromCamera(
                  context: context,
                  onImageChose: (image) {
                    ctrl.isOpenDialog = false;
                    ctrl.update();
                    Get.toNamed(Routes.addPhotoScreen,
                        arguments: {"data": image});
                  });
              // Navigator.pop(context);
            },
          ),
          const CommonDivider().paddingSymmetric(vertical: 8.w),
          ProfileDataCard(
            image: Assets.icons.addPhoto.path,
            height: 32.w,
            title: 'Open Gallery',
            onTap: () {
              ctrl.isOpenDialog = false;
              ctrl.update();

              PickFile().imageFormGallery(
                  context: context,
                  onImageChose: (image) {
                    ctrl.isOpenDialog = false;
                    ctrl.update();
                    Get.toNamed(Routes.addPhotoScreen,
                        arguments: {"data": image});
                  });
              // Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }
}
