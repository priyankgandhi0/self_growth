import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_button.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/common_widget.dart';
import 'mood_cheking_con.dart';

class MoodCheckingScreen extends StatelessWidget {
  MoodCheckingScreen({Key? key}) : super(key: key);
  final MoodCheckingCon moodCheckingCon = Get.put(MoodCheckingCon());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<MoodCheckingCon>(builder: (ctrl) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                        onTap: () {
                          Get.back();
                        },
                        splashFactory: NoSplash.splashFactory,
                        child: const Icon(Icons.close))
                    .paddingSymmetric(horizontal: 20.w),
                ProfileBoxCard(
                  isImage: true,
                  imagePath: Assets.icons.emogi,
                  child: Column(
                    children: [
                      40.w.spaceH(),
                      'How do you feel?'.appTextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.sp),
                      12.w.spaceH(),
                      ButtonCard(
                        onTap: () {},
                        title: 'Today, 8:00 AM',
                        icon: Assets.icons.dateRange.svg(),
                      ),
                      24.w.spaceH(),
                      SfRangeSlider(
                        min: 0.0,
                        max: 100.0,
                        inactiveColor: grey_969696,
                        activeColor: black_000000,
                        onChanged: (value) {},
                        values: SfRangeValues(0.0, 20.0),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 24.w, vertical: 24.w),
                ),
                FeelingCard(
                  buttonOnTap: () {},
                  buttonText: 'Add other activity',
                  title: 'What’s making your day unhappy?',
                  widget: List.generate(
                    12,
                    (index) => FamilyCard(
                      isSelected: ctrl.isSelect == index,
                      onTap: () {
                        ctrl.isSelect = index;
                      },
                    ),
                  ),
                ),
                FeelingCard(
                  buttonOnTap: () {},
                  buttonText: 'Add other feeling',
                  title: 'How are you feeling about this?',
                  widget: List.generate(
                    12,
                    (index) => FamilyCard(
                      isSelected: ctrl.isSelect1 == index,
                      onTap: () {
                        ctrl.isSelect1 = index;
                      },
                    ),
                  ),
                ),
                16.w.spaceH(),
                Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                            color: white_FFFFFF),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Add notes'.appTextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                            16.w.spaceH(),
                            AppTextField(
                              labelText: 'Time',
                              hintText: '9:00 AM',
                            ),
                            16.w.spaceH(),
                            AppTextField(
                              labelText: 'Notes',
                              hintText: 'Add note',
                            )
                          ],
                        ).paddingSymmetric(horizontal: 16.w, vertical: 30.w))
                    .paddingSymmetric(horizontal: 20.w),
                16.w.spaceH(),
                RoundAppButton(
                  onTap: () {},
                  title: 'Continue',
                ).paddingSymmetric(horizontal: 40.w)
              ],
            ).paddingSymmetric(vertical: 16.w);
          }),
        ),
      ),
    );
  }
}

class FamilyCard extends StatelessWidget {
  const FamilyCard({Key? key, required this.isSelected, this.onTap})
      : super(key: key);
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 67.w,
        width: 67.w,
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected ? grey_969696 : Colors.transparent),
            borderRadius: BorderRadius.circular(8.r)),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 32.w,
                width: 32.w,
                decoration: BoxDecoration(
                    color: background_EBEBEB,
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              'Family'.appTextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.w,
                  fontColor: grey_969696),
            ],
          ),
        ));
  }
}

class ButtonCard extends StatelessWidget {
  const ButtonCard(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  final String title;
  final Widget icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: background_F5F5F5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            '  $title'
                .appTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ],
        ).paddingSymmetric(horizontal: 10.w),
      ),
    );
  }
}

class FeelingCard extends StatelessWidget {
  const FeelingCard({
    Key? key,
    required this.widget,
    required this.title,
    required this.buttonText,
    required this.buttonOnTap,
  }) : super(key: key);
  final List<Widget> widget;
  final String title;
  final String buttonText;
  final Function() buttonOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w), color: white_FFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.appTextStyle(
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp),
                16.w.spaceH(),
                Wrap(children: widget),
                16.w.spaceH(),
                Align(
                  alignment: Alignment.center,
                  child: ButtonCard(
                    onTap: () {},
                    title: buttonText,
                    icon: Icon(Icons.add, size: 14.sp),
                  ),
                ),
              ],
            ).paddingAll(32.w))
        .paddingSymmetric(horizontal: 20.w, vertical: 16.w);
  }
}
