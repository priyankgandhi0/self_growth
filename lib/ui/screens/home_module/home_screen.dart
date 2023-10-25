import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/habit_module/create_new_habit.dart';
import 'package:self_growth/ui/screens/home_module/home_controller.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/app_dialogs.dart';
import '../self_discovery/discover_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Today, 2 Feb 2023'
              .appTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)
              .paddingSymmetric(horizontal: 20.w),
          24.w.spaceH(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                ctrl.dayList.length,
                (index) => HorizontalNotesCard(
                    title: ctrl.dayList[index],
                    index: index,
                    onTap: () {
                      if (ctrl.isSelectedDay.contains(index)) {
                        ctrl.isSelectedDay.remove(index);
                      } else {
                        ctrl.isSelectedDay.add(index);
                      }

                      ctrl.update();
                    },
                    selected: ctrl.isSelectedDay.contains(index)),
              ),
            ),
          ).paddingSymmetric(horizontal: 20.w),
          20.w.spaceH(),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r), color: white_FFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NoteCommonCard(
                  image: Assets.icons.edit.path,
                  title: 'Note title',
                  time: '7:00 AM ·',
                  notes: 'This is some text',
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.noteHistoryScreen);
                  },
                  child: Container(
                    height: 40.w,
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(colors: [
                        //   const Color(0XFFD4E0DF).withOpacity(.5),
                        //   const Color(0XFFE0CECD).withOpacity(.5),
                        //   const Color(0XFFEDE3FF).withOpacity(.5),
                        // ]),
                        image: DecorationImage(
                            image: AssetImage(Assets.images.butCon.path),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        'View history'.appTextStyle(
                            fontColor: doteColor,
                            fontSize: 14.w,
                            fontWeight: FontWeight.w600),
                        5.w.spaceW(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: doteColor,
                          size: 12.w,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w),
          16.w.spaceH(),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r), color: white_FFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHabit
                    .appTextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600)
                    .paddingSymmetric(horizontal: 20.w),
                16.w.spaceH(),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BuildHabitCard(
                        selected: ctrl.isSelectedHabit == index,
                        selectedDay: ctrl.isSelectedDayTick == index,
                        dayOnTap: () {
                          ctrl.isSelectedDayTick = index;
                          ctrl.update();
                        },
                        onTap: () {
                          ctrl.isSelectedHabit = index;
                          ctrl.update();
                        },
                        title: 'Reading Book',
                        subTitle: 'EVERY DAY',
                        day: '8',
                      );
                    },
                    separatorBuilder: (context, index) {
                      return 16.w.spaceH();
                    },
                    itemCount: 2)
              ],
            ).paddingAll(16.w),
          ).paddingSymmetric(horizontal: 20.w),
          16.w.spaceH(),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r), color: white_FFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                quitHabit.appTextStyle(
                    fontSize: 17.sp, fontWeight: FontWeight.w600),
                16.w.spaceH(),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return QuitHabitCard(
                        selectedDay: ctrl.isSelectedDayTick1 == index,
                        dayOnTap: () {
                          ctrl.isSelectedDayTick1 = index;
                          ctrl.update();
                        },
                        buttonOnTap: () {
                          openBottomDialogBox(
                              padding: 350.w,
                              child: Column(
                                children: [
                                  ProfileDataCard(
                                      image: Assets.icons.resetHabit.path,
                                      height: 24.w,
                                      title: 'Reset habit'),
                                  const Divider()
                                      .paddingSymmetric(vertical: 6.w),
                                  ProfileDataCard(
                                      image: Assets.icons.delete.path,
                                      height: 24.w,
                                      title: 'Delete habit')
                                ],
                              ),
                              context: context);
                        },
                        title: 'I have been cafeein free for',
                        subTitle: 'Abstinence time',
                        time: '17h : 2m : 36s',
                        day: '8',
                      );
                    },
                    separatorBuilder: (context, index) {
                      return 16.w.spaceH();
                    },
                    itemCount: 2)
              ],
            ).paddingAll(16.w),
          ).paddingSymmetric(horizontal: 20.w),
          16.w.spaceH(),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r), color: white_FFFFFF),
            child: Column(
              children: [
                Row(
                  children: [
                    'Recomended for you'.appTextStyle(
                        fontWeight: FontWeight.w700, fontSize: 17.sp),
                    const Spacer(),
                    Assets.icons.sliders.svg()
                  ],
                ),
                20.w.spaceH(),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () {}),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.

                              onPressed: (context) {},

                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.red,
                              autoClose: false,

                              icon: Icons.do_disturb,
                            ),
                          ],
                        ),
                        child: DiscoverCommonCard(
                          color: greyLightColor,
                          buttonColor: white_FFFFFF,
                          onTap: () {
                            // bottomBarController.changeTab(BottomNavEnum.other);

                            // bottomBarController.tab = AllDisCoverDataScreen();
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return 16.w.spaceH();
                    },
                    itemCount: 3)
              ],
            ).paddingAll(16.w),
          )
        ],
      ).paddingSymmetric(vertical: 24.w);
    });
  }
}

class BuildHabitCard extends StatelessWidget {
  const BuildHabitCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.day,
      this.onTap,
      required this.selected,
      this.dayOnTap,
      required this.selectedDay})
      : super(key: key);
  final String title;
  final void Function()? onTap;
  final void Function()? dayOnTap;
  final String subTitle;
  final String day;
  final bool selected;
  final bool selectedDay;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: grey_969696.withOpacity(.2)),
                color: white_FFFFFF),
            child: Row(
              children: [
                !selected
                    ? Assets.icons.right
                        .svg(width: 24.w, fit: BoxFit.fill, height: 24.w)
                    : Assets.icons.selectedRight
                        .svg(width: 24.w, fit: BoxFit.fill, height: 24.w),
                10.w.spaceW(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title.appTextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.sp),
                    5.w.spaceH(),
                    subTitle.appTextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        fontColor: grey_969696.withOpacity(.8))
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 12.w, vertical: 10.w),
          ),
          Positioned(
            right: 16.w,
            bottom: 10.w,
            child: Row(
              children: [
                InkWell(
                  onTap: dayOnTap,
                  child: (selectedDay
                          ? Assets.icons.selected
                          : Assets.icons.minimize)
                      .svg(width: 16.w, height: 16.w, fit: BoxFit.cover),
                ),
                10.w.spaceW(),
                '$day day streak'.appTextStyle(
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w400,
                    fontColor: grey_969696,
                    fontSize: 12.sp)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class QuitHabitCard extends StatelessWidget {
  const QuitHabitCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.day,
      required this.time,
      this.buttonOnTap,
      required this.selectedDay,
      this.dayOnTap})
      : super(key: key);
  final String title;
  final String subTitle;
  final String day;
  final String time;
  final Function()? buttonOnTap;
  final Function()? dayOnTap;

  final bool selectedDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: grey_969696.withOpacity(.2)),
          color: white_FFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconCard(title: '☕️'),
              10.w.spaceW(),
              title.appTextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              const Spacer(),
              InkWell(
                  onTap: buttonOnTap,
                  splashFactory: NoSplash.splashFactory,
                  child: Assets.icons.threeDote.svg())
            ],
          ),
          8.w.spaceH(),
          subTitle
              .appTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.sp,
                  fontColor: grey_969696)
              .paddingOnly(bottom: 4.w),
          Row(
            children: [
              time.appTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              const Spacer(),
              InkWell(
                onTap: dayOnTap,
                child: (selectedDay
                        ? Assets.icons.selected
                        : Assets.icons.minimize)
                    .svg(width: 16.w, height: 16.w, fit: BoxFit.cover),
              ),
              10.w.spaceW(),
              '$day day streak'.appTextStyle(
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  fontColor: grey_969696,
                  fontSize: 12.sp)
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 12.w, vertical: 10.w),
    );
  }
}
