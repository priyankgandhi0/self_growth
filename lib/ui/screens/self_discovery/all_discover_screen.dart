import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'discover_screen.dart';

class AllDisCoverDataScreen extends StatelessWidget {
  const AllDisCoverDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.w.spaceH(),
        'Discover'.appTextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
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
                itemCount: 7)
            .paddingSymmetric(horizontal: 20.w)
      ],
    );
  }
}
