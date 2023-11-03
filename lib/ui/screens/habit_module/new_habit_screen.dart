import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_title_bar.dart';
import 'package:self_growth/ui/widgets/habit_card.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';

class NewHabitScreen extends StatelessWidget {
  const NewHabitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.backGroundImage.path),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.w.spaceH(),
                CommonAppBar(
                  icon: const Icon(Icons.close, color: borderPurpleColor),
                  title: newHabbit,
                  padding: 0,
                  onTap: () {
                    Get.back();
                  },
                ),
                Container(
                  height: 56.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: white_FFFFFF,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Material(
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                      onTap: () {
                        Get.toNamed(Routes.createNewHabitScreen);
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add),
                            createNewHabbit.appSwitzerTextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).paddingSymmetric(vertical: 18.h),
                6.h.spaceH(),
                recomended
                    .appSwitzerTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start)
                    .paddingSymmetric(),
                20.h.spaceH(),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => 16.h.spaceH(),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return HabitCard(
                      onTap: () {
                        Get.toNamed(Routes.habitPredefinedScreen);
                      },
                      title: 'Drinking Water',
                      subTitle: 'This is description',
                      tags: const [
                        'Build Habit',
                        'Daily',
                        'Popular',
                      ],
                    );
                  },
                ),
                20.h.spaceH()
              ],
            ).paddingSymmetric(horizontal: 16.w),
          ),
        ),
      ),
    );
  }
}
