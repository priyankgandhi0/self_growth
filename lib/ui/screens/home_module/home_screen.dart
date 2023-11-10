import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/constants/request_const.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/bottom_navigation/bottom_bar_controller.dart';
import 'package:self_growth/ui/screens/habit_module/create_new_habit.dart';
import 'package:self_growth/ui/screens/home_module/home_controller.dart';
import 'package:self_growth/ui/widgets/app_button.dart';
import 'package:self_growth/ui/widgets/app_loader.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_strings.dart';

import '../../../gen/assets.gen.dart';
import '../../widgets/audio_player.dart';
import '../../widgets/current_week_utils.dart';
import '../self_discovery/discover_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  final BottomBarController bottomBarController =
      Get.put(BottomBarController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<HomeController>(initState: (state) {
          Future.delayed(const Duration(milliseconds: 0), () {
            homeController
                .getUserHabit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
            homeController
                .getUserMood(DateFormat('yyyy-MM-dd').format(DateTime.now()));
          });
        }, builder: (ctrl) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Today, ${DateFormat.yMMMd('en_US').format(DateTime.now()).replaceAll(',', "")}'
                  .appSwitzerTextStyle(
                      fontSize: 20.sp, fontWeight: FontWeight.w600)
                  .paddingSymmetric(horizontal: 20.w),
              24.w.spaceH(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  ctrl.dayList.length,
                  (index) => HorizontalNotesCard(
                      title: ctrl.dayList[index],
                      date: (findFirstDateOfTheWeek(DateTime.now()).day),
                      index: index,
                      onTap: () {
                        if (DateTime.now().day ==
                            (findFirstDateOfTheWeek(DateTime.now()).day +
                                index)) {
                          ctrl.isSelectedDay = index;
                          String selectedDate = DateFormat('yyyy-MM-dd')
                              .format(DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  (findFirstDateOfTheWeek(DateTime.now()).day) +
                                      index))
                              .toString();
                          ctrl.getUserHabit(selectedDate);
                          ctrl.getUserMood(selectedDate);
                          ctrl.update();
                        }
                      },
                      selected: ctrl.isSelectedDay == 0
                          ? ((findFirstDateOfTheWeek(DateTime.now()).day) +
                                  index) ==
                              DateTime.now().day
                          : ctrl.isSelectedDay == index),
                ),
              ).paddingSymmetric(horizontal: 20.w),
              20.w.spaceH(),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: white_FFFFFF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ctrl.moodData.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'How did you feel today?'.appSwitzerTextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17.sp),
                              5.w.spaceH(),
                              'Log your mood to get insight'
                                  .appSwitzerTextStyle(
                                      fontColor: doteColor, fontSize: 14.sp),
                              20.w.spaceH(),
                              RoundAppButton(
                                width: 128.w,
                                height: 34.w,
                                title: 'Log your mood',
                                onTap: () {
                                  bottomBarController.isOpenDialog = true;
                                  bottomBarController.isOpenHomeDialog = 0;
                                  // bottomBarController.isSelectedTab = 1;
                                  // bottomBarController.changeTab(BottomNavEnum.home);
                                  bottomBarController.update();
                                },
                              )
                            ],
                          ).paddingAll(20.w)
                        : ctrl.moodData.first.type == "MOOD"
                            ? NoteCommonCard(
                                image: Assets.icons.edit.path,
                                title: (ctrl.moodData.first.feeling!.isEmpty
                                        ? "Title"
                                        : ctrl.moodData.first.feeling)
                                    .toString(),
                                time: DateFormat('hh:mm a').format(DateTime.parse(
                                    '${ctrl.moodData.first.moodDate} ${ctrl.moodData.first.noteTime}'
                                        .toString())),
                                chipTitleColor: doteColor,
                                fellingList:
                                    ctrl.moodData.first.unhappyReasonFeeling ??
                                        [],
                                notes: ctrl.moodData.first.note.toString(),
                              )
                            : ctrl.moodData.first.type == "PHOTO"
                                ? Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: white_FFFFFF),
                                    child: NoteCommonCard(
                                      showIcon: true,
                                      image: Assets.icons.imageCapture.path,
                                      title: (ctrl.moodData.first.title!.isEmpty
                                              ? "Image Title"
                                              : ctrl.moodData.first.title)
                                          .toString(),
                                      time: DateFormat('hh:mm a').format(
                                          DateTime.parse(
                                              '${ctrl.moodData.first.moodDate} ${ctrl.moodData.first.noteTime}'
                                                  .toString())),
                                      fellingList: ctrl.moodData.first
                                              .unhappyReasonFeeling ??
                                          [],
                                      isImage: false,
                                      widget: AddImageCard(
                                        widget: commonCachedNetworkImage(
                                            borderRadius: 8.r,
                                            imageUrl:
                                                '${ImageBaseUrl.MOODIMAGEURL}${ctrl.moodData.first.moodPhoto}',
                                            height: 140.w,
                                            width: Get.width),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: white_FFFFFF),
                                    child: NoteCommonCard(
                                      image: Assets.icons.voice.path,
                                      showIcon: false,
                                      fellingList: ctrl.moodData.first
                                              .unhappyReasonFeeling ??
                                          [],
                                      title: (ctrl.moodData.first.title!.isEmpty
                                              ? 'Voice title'
                                              : ctrl.moodData.first.title)
                                          .toString(),
                                      time: DateFormat('hh:mm a').format(
                                          DateTime.parse(
                                              '${ctrl.moodData.first.moodDate} ${ctrl.moodData.first.noteTime}'
                                                  .toString())),
                                      widget: Container(
                                        height: 69.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: background_F5F5F5),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20.w),
                                          child: AudioPlayer(
                                            source:
                                                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
                                            onDelete: () {
                                              ctrl.showPlayer =
                                                  !ctrl.showPlayer;
                                              ctrl.update();
                                            },
                                          ),
                                        ),
                                      ).paddingAll(16.w),
                                    ),
                                  ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.noteHistoryScreen);
                      },
                      child: Container(
                        height: 40.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.images.butCon.path),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            'View history'.appSwitzerTextStyle(
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
              Visibility(
                  visible: ctrl.habitData.isNotEmpty,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: white_FFFFFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Habits'.appSwitzerTextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                        16.w.spaceH(),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return HabitCard(
                                selectedDay: ctrl.habitData[index].streak != 0,
                                value: index == 0 ? '1/2' : '2/3',
                                dayOnTap: () {
                                  ctrl.update();
                                },
                                onTap: () {
                                  ctrl.isSelectedHabit = index;
                                  ctrl.update();
                                },
                                title: ctrl.habitData[index].habitName ?? "",
                                subTitle: 'EVERY DAY',
                                day: ctrl.habitData[index].streak.toString(),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const CommonDivider()
                                  .paddingSymmetric(horizontal: 4.w);
                            },
                            itemCount: ctrl.habitData.length)
                      ],
                    ).paddingAll(16.w),
                  ).paddingOnly(right: 20.w, left: 20.w, bottom: 16.w)),
              Visibility(
                  visible: ctrl.buildData.isNotEmpty,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: white_FFFFFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHabit.appSwitzerTextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                        16.w.spaceH(),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BuildHabitCard(
                                selected: ctrl.isSelectedHabit == index,
                                selectedDay: ctrl.buildData[index].streak !=
                                        0 ||
                                    ctrl.isSelectedDayTick1.contains(
                                        ctrl.buildData[index].habitId ?? 0) ||
                                    ctrl.isSelectedDayTick.contains(
                                        ctrl.buildData[index].habitId ?? 0),
                                dayOnTap: () {
                                  if (ctrl.isSelectedDayTick.contains(
                                      ctrl.buildData[index].habitId ?? 0)) {
                                  } else {
                                    ctrl.checkInUserHabit(ctrl
                                        .habitData[index].habitId
                                        .toString());
                                    ctrl.isSelectedDayTick.add(
                                        ctrl.buildData[index].habitId ?? 0);
                                  }
                                  ctrl.update();
                                },
                                onTap: () {
                                  ctrl.isSelectedHabit = index;
                                  ctrl.update();
                                },
                                title: ctrl.buildData[index].habitName ?? "",
                                subTitle: 'EVERY DAY',
                                day: ctrl.buildData[index].streak.toString(),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const CommonDivider()
                                  .paddingSymmetric(horizontal: 4.w);
                            },
                            itemCount: ctrl.buildData.length)
                      ],
                    ).paddingAll(16.w),
                  ).paddingOnly(right: 20.w, left: 20.w, bottom: 16.w)),
              Visibility(
                visible: ctrl.quitData.isNotEmpty,
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: white_FFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      quitHabit.appSwitzerTextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w600),
                      16.w.spaceH(),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return QuitHabitCard(
                              selectedDay: ctrl.quitData[index].streak != 0 ||
                                  ctrl.isSelectedDayTick1.contains(
                                      ctrl.quitData[index].habitId ?? 0),
                              dayOnTap: () {
                                if (ctrl.isSelectedDayTick1.contains(
                                    ctrl.quitData[index].habitId ?? 0)) {
                                } else {
                                  ctrl.checkInUserHabit(
                                      ctrl.quitData[index].habitId.toString());
                                  ctrl.isSelectedDayTick1
                                      .add(ctrl.quitData[index].habitId ?? 0);
                                }
                                ctrl.update();
                              },
                              buttonOnTap: () {
                                bottomBarController.isOpenDialog = true;
                                bottomBarController.isOpenHomeDialog = 1;
                                bottomBarController.deleteHabitId =
                                    ctrl.quitData[index].habitId ?? 0;
                                bottomBarController.selectedDate = DateFormat(
                                        'yyyy-MM-dd')
                                    .format(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        (findFirstDateOfTheWeek(DateTime.now())
                                                .day) +
                                            index))
                                    .toString();
                                bottomBarController.update();
                              },
                              title: ctrl.quitData[index].habitName ?? "",
                              subTitle: ctrl.quitData[index].note != ""
                                  ? (ctrl.quitData[index].note ?? "")
                                  : 'Abstinence time',
                              time:
                                  '${(ctrl.quitData[index].reminderTime ?? "").split(":").first}h : ${(ctrl.quitData[index].reminderTime ?? "").split(":")[1]}m :  ${(ctrl.quitData[index].reminderTime ?? "").split(":").last}s',
                              day: ctrl.quitData[index].streak.toString(),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return 16.w.spaceH();
                          },
                          itemCount: ctrl.quitData.length)
                    ],
                  ).paddingAll(16.w),
                ).paddingOnly(right: 20.w, left: 20.w, bottom: 16.w),
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: white_FFFFFF),
                child: Column(
                  children: [
                    Row(
                      children: [
                        'Recomended for you'.appSwitzerTextStyle(
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
              ),
              86.w.spaceH(),
            ],
          ).paddingSymmetric(vertical: 24.w);
        }),
        Obx(() => homeController.isLoading.value
            ? const AppProgress()
            : const SizedBox())
      ],
    );
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
                border: Border.all(color: Colors.transparent),
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
                    title.appSwitzerTextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.sp),
                    5.w.spaceH(),
                    subTitle.appSwitzerTextStyle(
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
                5.w.spaceW(),
                '$day day streak'.appSwitzerTextStyle(
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w400,
                    fontColor: doteColor,
                    fontSize: 12.sp)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  const HabitCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.day,
    this.onTap,
    this.dayOnTap,
    required this.value,
    required this.selectedDay,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;
  final void Function()? dayOnTap;
  final String subTitle;
  final String day;
  final String value;
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
                border: Border.all(color: Colors.transparent),
                color: white_FFFFFF),
            child: Row(
              children: [
                Assets.icons.right
                    .svg(width: 24.w, fit: BoxFit.fill, height: 24.w),
                10.w.spaceW(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title.appSwitzerTextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.sp),
                    5.w.spaceH(),
                    Row(
                      children: [
                        InkWell(
                          onTap: dayOnTap,
                          child: (selectedDay
                                  ? Assets.icons.selected
                                  : Assets.icons.minimize)
                              .svg(
                                  width: 16.w, height: 16.w, fit: BoxFit.cover),
                        ),
                        5.w.spaceW(),
                        '$day day streak'.appSwitzerTextStyle(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            fontColor: doteColor,
                            fontSize: 12.sp)
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Stack(
                  children: [
                    // Container(
                    //   width: 48.w,
                    //   height: 48.w,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: AssetImage(Assets.images.ring.path),
                    //           fit: BoxFit.fill)),
                    // ),
                    CircularPercentIndicator(
                      radius: 25.r,
                      lineWidth: 3.w,
                      animation: true,
                      percent: .2,
                      backgroundColor: doteColor.withOpacity(.4),
                      center: value.appSwitzerTextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: borderPurpleColor,
                    ),
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 10.w, vertical: 10.w),
          ),
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
          image: DecorationImage(
              image: AssetImage(Assets.images.card.path), fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconCard(title: '☕️'),
              10.w.spaceW(),
              title.appSwitzerTextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14.sp),
              const Spacer(),
              InkWell(
                  onTap: buttonOnTap,
                  splashFactory: NoSplash.splashFactory,
                  // ignore: deprecated_member_use_from_same_package
                  child: Assets.icons.threeDote.svg(color: borderPurpleColor))
            ],
          ),
          8.w.spaceH(),
          subTitle
              .appSwitzerTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  fontColor: doteColor)
              .paddingOnly(bottom: 4.w),
          Row(
            children: [
              time.appSwitzerTextStyle(
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
              5.w.spaceW(),
              '$day day streak'.appSwitzerTextStyle(
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  fontColor: doteColor,
                  fontSize: 12.sp)
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 12.w, vertical: 10.w),
    );
  }
}
