import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/bottom_navigation/bottom_bar_controller.dart';
import 'discover_screen.dart';

// ignore: must_be_immutable
class AllDisCoverDataScreen extends StatelessWidget {
  const AllDisCoverDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.w.spaceH(),
        'Discover'
            .appSwitzerTextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
        16.w.spaceH(),
        ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return DiscoverCommonCard(
                    onTap: () {
                      // bottomBarController.changeTab(BottomNavEnum.other);

                      // bottomBarController.tab = AllDisCoverDataScreen();
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return 16.w.spaceH();
                },
                itemCount: 20)
            .paddingSymmetric(horizontal: 20.w),
        89.w.spaceH(),
      ],
    );
  }
}
