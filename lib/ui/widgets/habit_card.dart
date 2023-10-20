import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_chip.dart';

class HabitCard extends StatelessWidget {
  HabitCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.imgUrl = "",
      this.tags = const []})
      : super(key: key);

  final String title;
  final String subTitle;
  final String imgUrl;
  List<String> tags;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: white_FFFFFF, borderRadius: BorderRadius.circular(8.r)),
      child: Material(
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          onTap: () {
            print(' Habbit');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: grey_D9D9D9,
                    borderRadius: BorderRadius.circular(7.r)),
                height: 64.h,
                width: 64.w,
              ).paddingOnly(top: 8.5.h, bottom: 8.5.h),
              12.w.spaceW(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title.appTextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  8.h.spaceH(),
                  subTitle.appTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontColor: black_000000.withOpacity(0.5)),
                  8.h.spaceH(),
                  SizedBox(
                    width: Get.width - 140.w,
                    child: Wrap(
                      runSpacing: 0.0,
                      runAlignment: WrapAlignment.start,
                      spacing: 5.0.w,
                      children: List.generate(
                        tags.length,
                        (index) => AppChip(title: tags[index]),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }
}
