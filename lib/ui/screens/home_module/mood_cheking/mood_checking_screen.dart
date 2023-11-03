import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_button.dart';
import 'package:self_growth/ui/widgets/start_up_text_field.dart';

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
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.backGroundImage.path),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: GetBuilder<MoodCheckingCon>(builder: (ctrl) {
            return SafeArea(
              child: Column(
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
                    widget: Assets.icons.emoji.svg(),
                    child: Column(
                      children: [
                        40.w.spaceH(),
                        'How do you feel?'.appSwitzerTextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.sp),
                        12.w.spaceH(),
                        ButtonCard(
                          onTap: () {},
                          title: 'Today, 8:00 AM',
                          icon: Assets.icons.dateRange.svg(),
                        ),
                        24.w.spaceH(),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                5,
                                (index) => CircleAvatar(
                                  backgroundColor:
                                      (ctrl.sliderValue >= 0 && index == 0) ||
                                              (ctrl.sliderValue >= 25 &&
                                                  (index == 1 || index == 0)) ||
                                              (ctrl.sliderValue >= 50 &&
                                                  (index == 1 ||
                                                      index == 0 ||
                                                      index == 2)) ||
                                              (ctrl.sliderValue >= 75 &&
                                                  (index == 1 ||
                                                      index == 0 ||
                                                      index == 2 ||
                                                      index == 3))
                                          ? borderPurpleColor
                                          : grey_D9D9D9,
                                  radius: 6.r,
                                ),
                              ),
                            ).paddingSymmetric(horizontal: 20.w),
                            SizedBox(
                              height: 20,
                              child: SliderTheme(
                                data: SliderThemeData(
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 9.r, elevation: 0.0),
                                ),
                                child: Slider(
                                  min: 0.0,
                                  max: 100.0,
                                  inactiveColor: grey_D9D9D9,
                                  activeColor: borderPurpleColor,
                                  onChanged: (value) {
                                    ctrl.sliderValue = value;
                                    ctrl.update();
                                  },
                                  value: ctrl.sliderValue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            'Unhappy'.appSwitzerTextStyle(
                              fontColor: doteColor,
                              fontSize: 13.sp,
                            ),
                            'Happy'.appSwitzerTextStyle(
                              fontColor: doteColor,
                              fontSize: 13.sp,
                            ),
                            'Normal'.appSwitzerTextStyle(
                              fontColor: doteColor,
                              fontSize: 13.sp,
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20.w)
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
                        title: 'Family',
                        widget: Assets.icons.familyImg.svg(),
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
                        title: ctrl.moodList[index],
                        widget: SvgPicture.asset(ctrl.moodImageList[index],
                            width: 24.w, fit: BoxFit.fill, height: 24.w),
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
                              'Add notes'.appSwitzerTextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w600),
                              16.w.spaceH(),
                              const AppTextField(
                                labelText: 'Time',
                                hintText: '9:00 AM',
                              ),
                              16.w.spaceH(),
                              const AppTextField(
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
                  ).paddingSymmetric(horizontal: 40.w),
                  24.w.spaceH(),
                ],
              ).paddingSymmetric(vertical: 16.w),
            );
          }),
        ),
      ),
    );
  }
}

class FamilyCard extends StatelessWidget {
  const FamilyCard(
      {Key? key,
      required this.isSelected,
      this.onTap,
      required this.widget,
      required this.title})
      : super(key: key);
  final bool isSelected;
  final String title;
  final Widget widget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 67.w,
        width: 67.w,
        decoration: !isSelected
            ? const BoxDecoration()
            : BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.boxBorder.path))),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget,
              title.appSwitzerTextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.w,
                  fontColor: doteColor),
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
            '  $title'.appSwitzerTextStyle(
                fontColor: borderPurpleColor.withOpacity(.7),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
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
                title.appSwitzerTextStyle(
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
