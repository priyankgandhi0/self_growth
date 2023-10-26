import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/gen/assets.gen.dart';
import 'package:self_growth/ui/screens/statics/statics_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/constants/app_strings.dart';
import '../../widgets/common_widget.dart';

class StaticsScreen extends StatefulWidget {
  StaticsScreen({Key? key}) : super(key: key);

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {
  final StaticsController staticsController = Get.put(StaticsController());
  late TooltipBehavior tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticsController>(builder: (ctrl) {
      return Column(
        children: [
          statistic.appSwitzerTextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
              textAlign: TextAlign.center),
          16.w.spaceH(),
          Container(
            height: 40.w,
            decoration: BoxDecoration(
                color: white_FFFFFF.withOpacity(.8),
                borderRadius: BorderRadius.circular(20.r)),
            child: Row(
              children: List.generate(
                  3,
                  (index) => Expanded(
                          child: GestureDetector(
                        onTap: () {
                          ctrl.isSelectedTab = index;
                          ctrl.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ctrl.isSelectedTab == index
                                  ? borderPurpleColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(40.r)),
                          child: Center(
                            child: ctrl.isSelectedTab == index
                                ? ctrl.dayList[index].appGradientTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp)
                                : ctrl.dayList[index].appSwitzerTextStyle(
                                    fontColor: borderPurpleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp),
                          ),
                        ).paddingAll(4.w),
                      ))),
            ),
          ).paddingSymmetric(horizontal: 20.w),
          23.w.spaceH(),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: white_FFFFFF.withOpacity(.8),
                borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderCard(
                  title: moodSummary,
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 480.w,
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MoodSummaryCard(
                            size: 160.w,
                            title: 'All-or Nothing Thinking',
                            icon: Assets.icons.noThinking.path,
                            value: '50%',
                          ),
                        ],
                      ).paddingOnly(right: 28.w, top: 16.w),
                    ),
                    Positioned(
                      top: 97.w,
                      left: 16.w,
                      child: MoodSummaryCard(
                        size: 140.w,
                        title: 'Not Accepting',
                        icon: Assets.icons.notAccept.path,
                        value: '25%',
                      ),
                    ),
                    Positioned(
                      bottom: 162.w,
                      right: 16.w,
                      child: MoodSummaryCard(
                        size: 130.w,
                        title: 'Blaming',
                        icon: Assets.icons.blaming.path,
                        value: '12.5%',
                      ),
                    ),
                    Positioned(
                      bottom: 107.w,
                      left: 16.w,
                      child: MoodSummaryCard(
                        size: 120.w,
                        title: 'Should and \nMust statement',
                        icon: Assets.icons.statment.path,
                        value: '10%',
                      ),
                    ),
                    Positioned(
                      bottom: 30.w,
                      right: 86.w,
                      child: MoodSummaryCard(
                        size: 120.w,
                        title: 'Learning',
                        icon: Assets.icons.learning.path,
                        value: '3%',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w),
          20.w.spaceH(),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: white_FFFFFF.withOpacity(.8),
                borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              children: [
                const HeaderCard(
                  title: 'Mood Trends',
                ),
                16.w.spaceH(),
                SizedBox(
                    height: 225.w,
                    child: SfCartesianChart(
                        primaryYAxis: NumericAxis(
                            numberFormat: NumberFormat.compact(),
                            minimum: 0,
                            labelStyle: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: doteColor),
                            maximum: 150,
                            // axisLabelFormatter: '{value}M',
                            interval: 50,
                            borderWidth: 0,
                            borderColor: Colors.transparent,
                            axisLine:
                                const AxisLine(width: 0, color: Colors.red),
                            majorTickLines: const MajorTickLines(
                              size: 0,
                            )),
                        tooltipBehavior: buildTooltipBehavior(
                            title: 'Today, Feb 7', subTitle: 'Happy'),
                        plotAreaBorderColor: Colors.transparent,
                        primaryXAxis: CategoryAxis(
                            labelStyle: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: doteColor),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            majorGridLines:
                                const MajorGridLines(width: 0, dashArray: [0]),
                            minimum: 0,
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(width: 0)),
                        series: <ChartSeries<MoodTrends, String>>[
                          LineSeries<MoodTrends, String>(
                              dataSource: [
                                MoodTrends(0, 'M'),
                                MoodTrends(25, 'T'),
                                MoodTrends(50, 'W'),
                                MoodTrends(60, 'T '),
                                MoodTrends(70, 'F'),
                                MoodTrends(80, 'S'),
                                MoodTrends(100, 'S '),
                              ],
                              xValueMapper: (MoodTrends sales, _) => sales.day,
                              yValueMapper: (MoodTrends sales, _) =>
                                  sales.value,
                              color: borderPurpleColor,
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  color: borderPurpleColor,
                                  borderColor: borderPurpleColor))
                        ])),
                16.w.spaceH(),
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w),
          20.w.spaceH(),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: white_FFFFFF.withOpacity(.8),
                borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoodCheckCard(
                  title: whatImproveYourMood,
                  imgList: ctrl.noteImageList,
                  titleList: ctrl.noteList,
                ),
                const CommonDivider()
                    .paddingSymmetric(horizontal: 20.w, vertical: 5.w),
                MoodCheckCard(
                  title: 'that’s why you feel...',
                  imgList: ctrl.noteImageList,
                  titleList: ctrl.noteList,
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w),
          20.w.spaceH(),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: white_FFFFFF.withOpacity(.8),
                borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoodCheckCard(
                  title: 'What upset you',
                  imgList: ctrl.noteImageList,
                  titleList: ctrl.noteList,
                ),
                const CommonDivider()
                    .paddingSymmetric(horizontal: 20.w, vertical: 5.w),
                MoodCheckCard(
                  title: 'that’s why you feel...',
                  imgList: ctrl.noteImageList,
                  titleList: ctrl.noteList,
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w)
        ],
      );
    });
  }

  TooltipBehavior buildTooltipBehavior(
      {String title = '', String subTitle = ''}) {
    return TooltipBehavior(
      color: Colors.white.withOpacity(.5),
      builder: (data, point, series, pointIndex, seriesIndex) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: borderPinkColor.withOpacity(.3)),
              borderRadius: BorderRadius.circular(5.r),
              color: background_EBEBEB.withOpacity(.1)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title.appSwitzerTextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Switzer',
                  fontColor: doteColor,
                  fontSize: 16.sp),
              subTitle.appSwitzerTextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Switzer',
                  fontSize: 16.sp)
            ],
          ).paddingSymmetric(vertical: 6.w, horizontal: 8.w),
        );
      },
      activationMode: ActivationMode.singleTap,
      enable: true,
    );
  }
}

class ProfileDataCard extends StatelessWidget {
  const ProfileDataCard(
      {Key? key,
      required this.title,
      this.onTap,
      this.height,
      this.titleColor,
      required this.image})
      : super(key: key);
  final String title;
  final void Function()? onTap;
  final double? height;
  final Color? titleColor;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            image,
            width: height ?? 24.w,
            height: height ?? 19.w,
            fit: BoxFit.contain,
          ),
          10.w.spaceW(),
          title.appSwitzerTextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              fontColor: titleColor ?? borderPurpleColor)
        ],
      ),
    );
  }
}

class MoodTrends {
  MoodTrends(this.value, this.day);
  final num value;
  final String day;
}

class MoodSummaryCard extends StatelessWidget {
  const MoodSummaryCard(
      {Key? key,
      required this.icon,
      required this.value,
      required this.title,
      required this.size})
      : super(key: key);
  final String icon;
  final String value;
  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(Assets.images.circle.path), fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          value.appSwitzerTextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22.sp,
          ),
          title.appSwitzerTextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
          )
        ],
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.w.spaceH(),
        title
            .appSwitzerTextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp)
            .paddingSymmetric(horizontal: 20.w),
        Row(
          children: [
            'Feb 17 - Feb 24'.appSwitzerTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontColor: doteColor),
            const Spacer(),
            Assets.icons.leftArrow.svg(),
            10.w.spaceW(),
            Assets.icons.rightArrow.svg(),
          ],
        ).paddingSymmetric(horizontal: 20.w),
        10.w.spaceH(),
        const CommonDivider().paddingSymmetric(vertical: 8.w),
      ],
    );
  }
}

class MoodCheckCard extends StatelessWidget {
  const MoodCheckCard(
      {Key? key,
      required this.title,
      required this.titleList,
      required this.imgList})
      : super(key: key);
  final String title;
  final List<String> titleList;
  final List<String> imgList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title
            .appSwitzerTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)
            .paddingAll(20.w),
        Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 8.w,
            runSpacing: 16.w,
            children: List.generate(
                titleList.length,
                (index) => Container(
                      height: 36.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        border: const GradientBoxBorder(
                            gradient: LinearGradient(colors: [
                              borderPinkColor,
                              borderPurpleColor,
                              borderPurpleColor,
                              borderPurpleColor,
                              borderPinkColor
                            ]),
                            width: 1),
                      ),
                      child: ProfileDataCard(
                        title: titleList[index],
                        height: 20.w,
                        image: imgList[index],
                        titleColor: borderPurpleColor,
                        onTap: () {},
                      ),
                    ))).paddingOnly(left: 16.w, bottom: 18.w),
      ],
    );
  }
}
