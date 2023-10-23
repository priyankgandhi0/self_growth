import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/statics/statics_controller.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';

import '../../../core/constants/app_strings.dart';

class StaticsScreen extends StatelessWidget {
  StaticsScreen({Key? key}) : super(key: key);
  final StaticsController staticsController = Get.put(StaticsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticsController>(builder: (context) {
      return Column(
        children: [
          AppTitleBar(
            titleText: statistic,
            backgroundColor: background_EBEBEB,
            centerTitle: true,
            isHome: true,
          ),
          Container(
            height: 40.w,
            decoration: BoxDecoration(
                color: background_E6E6E6,
                borderRadius: BorderRadius.circular(20.r)),
            child: Row(
              children: List.generate(
                  3,
                  (index) => Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: background_E6E6E6,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: 'Week'.appTextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ))),
            ),
          ).paddingSymmetric(horizontal: 20.w)
        ],
      );
    });
  }
}
