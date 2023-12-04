import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../gen/assets.gen.dart';
import '../screens/habit_module/create_new_habit.dart';

class WeeklyCalender extends StatefulWidget {
  OnDaySelected? onDaySelected;
  DateTime? currentDay = DateTime.now();
  DateTime? focusDay = DateTime.now();
  Function(DateTime focusedDay)? onMonthChange;

  Function(PageController pageController)? onCalenderCreated;
  Function? calenderBuildCompleted;
  Set<DateTime>? selectedDays;
  CalendarFormat? calenderFormat;
  bool? headerVisible;

  WeeklyCalender({
    this.currentDay,
    this.onDaySelected,
    this.onMonthChange,
    this.onCalenderCreated,
    this.calenderBuildCompleted,
    this.focusDay,
    this.selectedDays,
    this.calenderFormat,
    this.headerVisible,
    Key? key,
  }) : super(key: key);

  @override
  State<WeeklyCalender> createState() => _WeeklyCalenderState();
}

class _WeeklyCalenderState extends State<WeeklyCalender> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.calenderBuildCompleted != null) {
        widget.calenderBuildCompleted!();
      }

      setState(() {});
    });
    super.initState();
  }

  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 20),
      lastDay: DateTime.utc(2040, 10, 20),
      focusedDay: widget.focusDay!,
      currentDay: widget.currentDay,
      headerVisible: false,
      availableGestures: AvailableGestures.none,
      onDaySelected: widget.onDaySelected,
      selectedDayPredicate: (day) {
        return widget.selectedDays?.contains(day) ?? false;
      },
      calendarFormat: widget.calenderFormat ?? CalendarFormat.month,
      daysOfWeekVisible: true,
      sixWeekMonthsEnforced: false,
      rowHeight: 60.w,
      startingDayOfWeek: StartingDayOfWeek.monday,
      weekendDays: const [DateTime.monday, DateTime.saturday],
      daysOfWeekHeight: 0.w,
      onCalendarCreated: (controller) {
        pageController = controller;
      },
      shouldFillViewport: false,
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week',
      },
      calendarStyle: calenderStyle(),
      calendarBuilders: calenderBuilders(),
    );
  }

  DaysOfWeekStyle daysOfWeekStyle() {
    return DaysOfWeekStyle(
      weekdayStyle: fMTextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      weekendStyle: fMTextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  BoxDecoration decoration() {
    return const BoxDecoration(
      color: Colors.red,
      //borderRadius: BorderRadius.circular(10),
      border: Border(
        left: BorderSide(
          color: borderPurpleColor,
          width: 1,
        ),
        right: BorderSide(
          color: borderPurpleColor,
          width: 1,
        ),
        bottom: BorderSide(
          color: borderPurpleColor,
          width: 1,
        ),
        top: BorderSide(
          color: borderPurpleColor,
          width: 1,
        ),
      ),
    );
  }

  TextStyle fMTextStyle({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
        color: color,
        fontFamily: 'Switzer',
        fontWeight: fontWeight,
        fontSize: fontSize);
  }

  CalendarStyle calenderStyle() {
    return CalendarStyle(
      outsideDaysVisible: true,
      isTodayHighlighted: true,
      cellMargin: EdgeInsets.all(3),
      defaultTextStyle: fMTextStyle(
        color: borderPurpleColor,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      weekendTextStyle: fMTextStyle(
        color: borderPurpleColor,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      selectedTextStyle: fMTextStyle(
        color: borderPurpleColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      todayTextStyle: fMTextStyle(
        color: borderPurpleColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      cellPadding: EdgeInsets.zero,
      selectedDecoration: decoration(),
      todayDecoration: decoration(),
    );
  }

  calenderBuilders() {
    return CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) =>
          defaultBuilder(context, day, focusedDay),
      todayBuilder: (context, day, focusedDay) =>
          toDayBuilder(context, day, focusedDay),
      disabledBuilder: (context, day, focusedDay) =>
          disableBuilder(context, day, focusedDay),
      outsideBuilder: (context, day, focusedDay) =>
          defaultBuilder(context, day, focusedDay),
    );
  }

  Widget? defaultBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return Column(
      children: [
        (DateFormat('EE').format(day).toString())
            .toString()
            .appSwitzerTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                fontColor: borderPurpleColor.withOpacity(.8)),
        5.w.spaceH(),
        DateTime.now().isAfter(day)
            ? Assets.icons.right.svg(
                width: 32.w,
                height: 32.w,
                fit: BoxFit.contain,
              )
            : IconCard(
                title: '${(day.day)}',
                isHome: true,
              ),
      ],
    );
  }

  Widget? disableBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    log('day.day==${day.day}');
    return Column(
      children: [
        (DateFormat('E').format(day).toString().characters.first)
            .toString()
            .appSwitzerTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                fontColor: borderPurpleColor.withOpacity(.8)),
        5.w.spaceH(),
        Assets.icons.right.svg(
          width: 32.w,
          height: 32.w,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget? selectedBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    log('day.day==${focusedDay.day}');
    return Column(
      children: [
        (DateFormat('E').format(day).toString().characters.first)
            .toString()
            .appSwitzerTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                fontColor: borderPurpleColor.withOpacity(.8)),
        5.w.spaceH(),
        Assets.icons.right.svg(
          width: 32.w,
          height: 32.w,
          fit: BoxFit.contain,
        )
      ],
    );
  }

  Widget? toDayBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return Column(
      children: [
        (DateFormat('EE').format(day).toString())
            .toString()
            .appSwitzerTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                fontColor: borderPurpleColor.withOpacity(.8)),
        5.w.spaceH(),
        Container(
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: borderPurpleColor),
            child: Center(
                child: day.day.toString().appGradientTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: white_FFFFFF)))
      ],
    );
  }
}

class WeekData {
  DateTime startDate;
  DateTime endDate;
  WeekData({required this.startDate, required this.endDate});
}

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime
      .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday))
      .add(const Duration(days: 1));
}
