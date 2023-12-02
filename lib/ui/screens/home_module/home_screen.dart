import 'dart:async';
import 'dart:collection';
import 'dart:developer';
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
import 'package:self_growth/ui/screens/home_module/mood_checking/mood_checking_con.dart';
import 'package:self_growth/ui/widgets/app_button.dart';
import 'package:self_growth/ui/widgets/common_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../config/routes/router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/audio_player.dart';
import '../../widgets/current_week_utils.dart';
import '../self_discovery/discover_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  final MoodCheckingCon moodCheckingCon = Get.put(MoodCheckingCon());
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
              14.w.spaceH(),
              WeeklyCalender(
                currentDay: DateTime.now(),
                focusDay: DateTime.now(),
                onDaySelected: (selectedDay, focusDay) {},
                onMonthChange: (date) {},
                selectedDays: LinkedHashSet<DateTime>(
                  equals: isSameDay,
                ),
                calenderFormat: CalendarFormat.week,
              ).paddingAll(10),
              /*    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  ctrl.dayList.length,
                  (index) => HorizontalNotesCard(
                      title: ctrl.dayList[index],
                      date: ctrl.dateList[index],
                      index: index,
                      onTap: () {
                        if (DateTime.now().day ==
                            (findFirstDateOfTheWeek(DateTime.now()).day +
                                index)) {
                          ctrl.isSelectedDay = index;
                          ctrl.getUserHabit(
                              DateFormat('yyyy-MM-dd').format(DateTime.now()));
                          ctrl.getUserMood(
                              DateFormat('yyyy-MM-dd').format(DateTime.now()));
                          ctrl.update();
                        }
                      },
                      selected: ctrl.isSelectedDay == 0
                          ? ((findFirstDateOfTheWeek(DateTime.now()).day) +
                                  index) ==
                              DateTime.now().day
                          : ctrl.isSelectedDay == index),
                ),
              ).paddingSymmetric(horizontal: 20.w),*/
              // 20.w.spaceH(),
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
                        : NoteCommonCard(
                            iconOnTap: () {
                              bottomBarController.isOpenDialog = true;
                              bottomBarController.isOpenHomeDialog = 3;
                              moodCheckingCon.editMood = ctrl.moodData.first;
                              bottomBarController.update();
                              moodCheckingCon.update();
                            },
                            image: ctrl.moodData.first.type == moodVoiceType
                                ? Assets.icons.voice.path
                                : ctrl.moodData.first.type == moodImageType
                                    ? Assets.icons.imageCapture.path
                                    : Assets.icons.edit.path,
                            title: ctrl.moodData.first.type == moodTextType
                                ? (ctrl.moodData.first.title ?? "").toString()
                                : ctrl.moodData.first.type == moodVoiceType
                                    ? 'Voice Note'
                                    : "Image Capture",
                            time: DateFormat('hh:mm a').format(DateTime.parse(
                                '${ctrl.moodData.first.moodDate} ${ctrl.moodData.first.noteTime}'
                                    .toString())),
                            chipTitleColor: doteColor,
                            fellingList:
                                (ctrl.moodData.first.unhappyReasonFeeling ??
                                        []) +
                                    (ctrl.moodData.first.howAreYouFeelingList ??
                                        []),
                            notes: ctrl.moodData.first.note.toString(),
                            widget: ctrl.moodData.first.type == moodImageType
                                ? AddImageCard(
                                    widget: commonCachedNetworkImage(
                                        borderRadius: 8.r,
                                        imageUrl:
                                            '${ImageBaseUrl.MOODIMAGEURL}${ctrl.moodData.first.moodPhoto}',
                                        height: 140.w,
                                        width: Get.width),
                                  )
                                : ctrl.moodData.first.type == moodVoiceType
                                    ? Container(
                                        height: 69.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: background_F5F5F5),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20.w),
                                          child: AudioPlayer(
                                            source:
                                                "${ImageBaseUrl.MOODAUDIOURL}${ctrl.moodData.first.audioFile}",
                                            onDelete: () {},
                                          ),
                                        ),
                                      ).paddingAll(16.w)
                                    : const SizedBox(),
                          ),
                    GestureDetector(
                      onTap: () {
                        if (ctrl.moodData.isNotEmpty) {
                          Get.toNamed(Routes.noteHistoryScreen);
                        } else {}
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
                                percent: (ctrl.logActivityUsing[index] >=
                                        (ctrl.habitData[index].goalTimes ?? 0))
                                    ? 1
                                    : (ctrl.logActivityUsing[index] /
                                        (ctrl.habitData[index].goalTimes ?? 0)),
                                selectedDay: ctrl.habitData[index].streak != 0,
                                value:
                                    '${(ctrl.logActivityUsing[index])}/${(ctrl.habitData[index].goalTimes ?? 0)}',
                                onTap: () {
                                  ctrl.checkInUserHabit(
                                      ctrl.habitData[index].habitId.toString());
                                  int addValue =
                                      (ctrl.habitData[index].logActivityUsing ??
                                          1);
                                  ctrl.logActivityUsing[index] =
                                      ctrl.logActivityUsing[index] + addValue;
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
                                selectedDay: true,
                                dayOnTap: () {},
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
                              selectedDay: true,
                              dayOnTap: () {},
                              buttonOnTap: () {
                                bottomBarController.isOpenDialog = true;
                                bottomBarController.isOpenHomeDialog = 1;
                                bottomBarController.deleteHabitId =
                                    ctrl.quitData[index].habitId ?? 0;
                                // bottomBarController.selectedDate = DateFormat(
                                //         'yyyy-MM-dd')
                                //     .format(DateTime(
                                //         DateTime.now().year,
                                //         DateTime.now().month,
                                //         (findFirstDateOfTheWeek(DateTime.now())
                                //                 .day) +
                                //             index))
                                //     .toString();
                                bottomBarController.update();
                              },
                              title: ctrl.quitData[index].habitName ?? "",
                              subTitle: ctrl.quitData[index].note != ""
                                  ? (ctrl.quitData[index].note ?? "")
                                  : 'Abstinence time',
                              time: ctrl.quitData[index].goalResetTime ?? "",
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
                /*!selected
                    ? Assets.icons.right
                        .svg(width: 24.w, fit: BoxFit.fill, height: 24.w)
                    : */
                Assets.icons.selectedRight
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
                  // onTap: dayOnTap,
                  child: (/*selectedDay
                          ?*/
                          Assets.icons.selected /*: Assets.icons.minimize*/)
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
    required this.percent,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;
  final void Function()? dayOnTap;
  final String subTitle;
  final String day;
  final String value;
  final bool selectedDay;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
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
                InkWell(
                  onTap: onTap,
                  child: Assets.icons.right
                      .svg(width: 24.w, fit: BoxFit.fill, height: 24.w),
                ),
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
                      percent: percent,
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

class QuitHabitCard extends StatefulWidget {
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
  State<QuitHabitCard> createState() => _QuitHabitCardState();
}

class _QuitHabitCardState extends State<QuitHabitCard> {
  String times = '0h : 0m : 0s';
  Timer? _timer;
  bool startTimer = true;
  Widget formatTime(String date) {
    if (startTimer) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (t) {
          DateTime time = DateTime.parse(date).getLocalDateTime();
          final startTime = DateTime(time.year, time.month, time.day, time.hour,
              time.minute, time.second);
          final currentTime = DateTime.now();
          final diffHr = currentTime.difference(startTime).inHours;
          final diffMn = (currentTime.difference(startTime).inMinutes) % 60;
          final diffSc = (currentTime.difference(startTime).inSeconds) % 60;
          times = '${diffHr}h : ${diffMn}m :  ${diffSc}s';
          if (mounted) {
            // setState(() {});
          }
        },
      );
    }
    return times.appSwitzerTextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.sp,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    startTimer = false;
  }

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
              widget.title.appSwitzerTextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14.sp),
              const Spacer(),
              InkWell(
                  onTap: widget.buttonOnTap,
                  splashFactory: NoSplash.splashFactory,
                  // ignore: deprecated_member_use_from_same_package
                  child: Assets.icons.threeDote.svg(color: borderPurpleColor))
            ],
          ),
          8.w.spaceH(),
          widget.subTitle
              .appSwitzerTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  fontColor: doteColor)
              .paddingOnly(bottom: 4.w),
          Row(
            children: [
              formatTime(widget.time),
              const Spacer(),
              InkWell(
                // onTap: widget.dayOnTap,
                child: (/*widget.selectedDay
                        ?*/
                        Assets.icons.selected /*: Assets.icons.minimize*/)
                    .svg(width: 16.w, height: 16.w, fit: BoxFit.cover),
              ),
              5.w.spaceW(),
              '${widget.day} day streak'.appSwitzerTextStyle(
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
