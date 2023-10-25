import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/onboarding_screen/onboarding_controller.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constant.dart';
import '../../gen/assets.gen.dart';
import '../screens/habit_module/create_new_habit.dart';
import 'file_picker_utils.dart';

class PageViewCard extends StatelessWidget {
  const PageViewCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.ctrl,
      required this.subTitle1})
      : super(key: key);
  final String title;
  final String subTitle;
  final String subTitle1;
  final Widget image;
  final OnBoardingController ctrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 400.w.spaceH(),
        image,
        20.w.spaceH(),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => CircleAvatar(
                      radius: 4.r,
                      backgroundColor: ctrl.initialPage == index
                          ? borderPurpleColor
                          : doteColor,
                    ).paddingSymmetric(horizontal: 2.w)),
          ),
        ),
        10.w.spaceH(),
        title
            .appTextStyle(
                fontColor: borderPurpleColor,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp)
            .paddingSymmetric(horizontal: 46.w)
            .paddingOnly(bottom: 5.w),
        subTitle
            .appTextStyle(
                fontColor: borderPurpleColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                fontSize: 14.sp)
            .paddingSymmetric(horizontal: 24.w),
        20.w.spaceH(),
        subTitle1
            .appTextStyle(
                fontColor: borderPurpleColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                fontSize: 14.sp)
            .paddingSymmetric(horizontal: 24.w),
      ],
    );
  }
}

class ProfileBoxCard extends StatelessWidget {
  const ProfileBoxCard({Key? key, required this.child, this.widget})
      : super(key: key);
  final Widget child;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 50.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.w),
                    color: white_FFFFFF),
                child: child)
            .paddingSymmetric(horizontal: 20.w),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: widget ??
              (Assets.icons.profile)
                  .svg(height: 100.w, width: 100.w, fit: BoxFit.contain),
        ),
      ],
    );
  }
}

class ProfileDataCard extends StatelessWidget {
  const ProfileDataCard({
    Key? key,
    required this.title,
    this.onTap,
    this.height,
    this.titleColor,
    required this.image,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;
  final double? height;

  final Color? titleColor;
  final String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            image,
            width: height ?? 24.w,
            height: height ?? 19.w,
            fit: BoxFit.contain,
          ),
          10.w.spaceW(),
          title.appTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              fontColor: titleColor ?? borderPurpleColor)
        ],
      ),
    );
  }
}

class HorizontalNotesCard extends StatelessWidget {
  const HorizontalNotesCard(
      {Key? key,
      required this.selected,
      required this.onTap,
      required this.title,
      required this.index})
      : super(key: key);
  final bool selected;
  final String title;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title.appTextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            fontColor: borderPurpleColor.withOpacity(.8)),
        5.w.spaceH(),
        index == 0 || index == 1
            ? Assets.icons.right.svg(
                width: 32.w,
                height: 32.w,
                fit: BoxFit.contain,
              )
            : GestureDetector(
                onTap: onTap,
                child: selected
                    ? Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: borderPurpleColor),
                        child: Center(
                            child: '${index + 1}'.appTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontColor: white_FFFFFF)))
                    : IconCard(title: '${index + 1}'))
      ],
    ).paddingOnly(right: 30.w);
  }
}

class AddImageCard extends StatelessWidget {
  const AddImageCard({Key? key, this.onTap, this.height, this.padding})
      : super(key: key);
  final void Function()? onTap;
  final double? height;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 140.w,
        width: Get.width,
        decoration: BoxDecoration(
          color: background_F5F5F5,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.image.path),
          ],
        ),
      ),
    ).paddingAll(padding ?? 16.w);
  }
}

class NoteCommonCard extends StatelessWidget {
  NoteCommonCard({
    Key? key,
    required this.title,
    this.notes = '',
    required this.time,
    this.showIcon,
    this.isVoiceNote,
    this.isImage,
    this.widget,
    required this.image,
  }) : super(key: key);
  final String title;
  final String notes;
  final String time;
  final bool? showIcon;
  final bool? isVoiceNote;
  final bool? isImage;
  final String image;
  final Widget? widget;

  final List<String> noteList = ['Work', 'Family', 'Blessed'];
  final List<String> noteImageList = [
    Assets.icons.work.path,
    Assets.icons.family.path,
    Assets.icons.blessd.path
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.w.spaceH(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(image),
            12.w.spaceW(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.appTextStyle(
                    fontWeight: FontWeight.w600, fontSize: 17.sp),
                time.appTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: borderPurpleColor.withOpacity(.8))
              ],
            ),
            const Spacer(),
            showIcon ?? true
                ? Assets.icons.threeDote.svg(color: borderPurpleColor)
                : const SizedBox()
          ],
        ).paddingSymmetric(horizontal: 16.w),
        notes.isNotEmpty
            ? notes
                .appTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: borderPurpleColor.withOpacity(.8))
                .paddingSymmetric(vertical: 16.w, horizontal: 16.w)
            : widget ?? const SizedBox(),
        SizedBox(
          height: 36.w,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
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
                    title: noteList[index],
                    height: 20.w,
                    image: noteImageList[index],
                    titleColor: borderPurpleColor,
                    onTap: () {},
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return 8.w.spaceW();
              },
              itemCount: noteList.length),
        ).paddingSymmetric(horizontal: 16.w),
        16.w.spaceH(),
        isImage ?? false
            ? Container(
                height: 40.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0XFFD4E0DF).withOpacity(.5),
                      const Color(0XFFE0CECD).withOpacity(.5),
                      const Color(0XFFEDE3FF).withOpacity(.5),
                    ]),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(12.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    'View history'
                        .appTextStyle(fontColor: doteColor, fontSize: 14.w),
                    5.w.spaceW(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: doteColor,
                      size: 12.w,
                    )
                  ],
                ),
              )
            : SizedBox()
      ],
    );
  }
}

class SelfDiscoveryCard extends StatelessWidget {
  const SelfDiscoveryCard(
      {Key? key,
      required this.title,
      this.onTap,
      this.size,
      this.color,
      this.widget})
      : super(key: key);
  final String title;
  final double? size;
  final Color? color;
  final Widget? widget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget ??
              SvgPicture.asset(
                Assets.icons.checkTrue.path,
                width: size ?? 20.w,
                height: size ?? 20.w,
                fit: BoxFit.cover,
              ),
          10.w.spaceW(),
          Expanded(
              child: title.appTextStyle(
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  fontColor: color ?? borderPurpleColor,
                  fontSize: 12.sp))
        ],
      ),
    );
  }
}

class ThirdQueCard extends StatelessWidget {
  const ThirdQueCard(
      {Key? key, required this.title, this.onTap, required this.value})
      : super(key: key);
  final String title;
  final String value;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.container.path),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(5.r)),
            child: Center(
              child: value.appTextStyle(
                  fontWeight: FontWeight.w600, fontSize: 12.sp),
            ),
          ),
          10.w.spaceW(),
          Expanded(
              child: title.appTextStyle(
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp))
        ],
      ),
    );
  }
}

class FirstQueCard extends StatelessWidget {
  const FirstQueCard(
      {Key? key, required this.title, this.onTap, required this.icon})
      : super(key: key);
  final String title;
  final String icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r), color: white_FFFFFF),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 32.w,
              height: 32.w,
              fit: BoxFit.fill,
            ),
            10.w.spaceW(),
            title.appTextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp)
          ],
        ).paddingSymmetric(horizontal: 16.w, vertical: 12.w),
      ),
    );
  }
}

class DiscoverCard extends StatelessWidget {
  const DiscoverCard(
      {Key? key,
      required this.title,
      this.onTap,
      required this.subTitle,
      required this.image})
      : super(key: key);
  final String title;
  final String subTitle;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            image,
            width: 32.w,
            height: 32.w,
            fit: BoxFit.cover,
          ),
          10.w.spaceW(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title.appTextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              subTitle.appTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  fontColor: grey_969696)
            ],
          ),
        ],
      ),
    );
  }
}

class CommonTabBar extends StatelessWidget {
  const CommonTabBar({Key? key, required this.title, required this.index})
      : super(key: key);
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 24.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: borderPurpleColor),
          color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title
              .appTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)
              .paddingSymmetric(horizontal: 8.w),
          index == 0 ? Assets.icons.dropdownArrow.svg() : const SizedBox()
        ],
      ).paddingSymmetric(horizontal: 8.w, vertical: 4.w),
    );
  }
}

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.title,
    this.onTap,
    required this.color,
    required this.icon,
    this.widget,
    this.iconColor,
  }) : super(key: key);
  final String title;
  final String icon;
  final Widget? widget;
  final Color? iconColor;

  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: widget ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color: iconColor,
                height: 20.w,
                width: 20.w,
                fit: BoxFit.fill,
              ),
              4.w.spaceH(),
              title.appTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  fontColor: color)
            ],
          ),
    ));
  }
}

class AppDropDown extends StatelessWidget {
  const AppDropDown({Key? key, this.onChanged, required this.value})
      : super(key: key);
  final void Function(Gender?)? onChanged;
  final Gender value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: background_F5F5F5, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<Gender>(
                style: getTextStyle(),
                value: value,
                underline: Container(),
                hint: 'Gender'
                    .appTextStyle(
                      fontColor: grey_969696,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )
                    .paddingOnly(left: 8),
                borderRadius: BorderRadius.circular(16),
                icon: Container(),
                dropdownColor: Colors.white,
                items: Gender.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name).paddingAll(8),
                        ))
                    .toList(),
                onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
