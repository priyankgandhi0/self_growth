import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constant.dart';
import '../../gen/assets.gen.dart';
import '../screens/habit_module/create_new_habit.dart';

class PageViewCard extends StatelessWidget {
  const PageViewCard({Key? key, required this.title, required this.subTitle})
      : super(key: key);
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 400.w.spaceH(),
        title
            .appTextStyle(
                fontColor: black_000000,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp)
            .paddingSymmetric(horizontal: 46.w)
            .paddingOnly(bottom: 5.w),
        subTitle
            .appTextStyle(
                fontColor: black_000000,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp)
            .paddingSymmetric(horizontal: 46.w),
      ],
    );
  }
}

class ProfileBoxCard extends StatelessWidget {
  const ProfileBoxCard({Key? key, required this.child, this.isImage})
      : super(key: key);
  final Widget child;
  final bool? isImage;
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
          child: isImage ?? true
              ? Assets.icons.profile
                  .svg(height: 100.w, width: 100.w, fit: BoxFit.contain)
              : Container(
                  height: 80.w,
                  width: 80.w,
                  decoration: const BoxDecoration(
                      color: grey_D9D9D9, shape: BoxShape.circle),
                ),
        ),
      ],
    );
  }
}

class ProfileDataCard extends StatelessWidget {
  const ProfileDataCard(
      {Key? key, required this.title, this.onTap, this.height, this.titleColor})
      : super(key: key);
  final String title;
  final void Function()? onTap;
  final double? height;
  final Color? titleColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: height ?? 32.w,
            height: height ?? 32.w,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: grey_D9D9D9),
          ),
          10.w.spaceW(),
          title.appTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              fontColor: titleColor ?? black_000000)
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
            fontColor: darkGrayColor.withOpacity(.8)),
        5.w.spaceH(),
        GestureDetector(
            onTap: onTap,
            child: selected
                ? Assets.icons.right.svg(
                    width: 32.w,
                    height: 32.w,
                    fit: BoxFit.contain,
                  )
                : IconCard(title: '${index + 1}'))
      ],
    ).paddingOnly(right: 30.w);
  }
}

class NoteCommonCard extends StatelessWidget {
  NoteCommonCard({
    Key? key,
    required this.title,
    this.notes = '',
    required this.time,
    this.showIcon,
    this.widget,
  }) : super(key: key);
  final String title;
  final String notes;
  final String time;
  final bool? showIcon;
  final Widget? widget;

  final List<String> noteList = ['Work', 'Family', 'Blessed'];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.w.spaceH(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48.w,
              width: 48.w,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: grey_D9D9D9),
            ),
            12.w.spaceW(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.appTextStyle(
                    fontWeight: FontWeight.w600, fontSize: 17.sp),
                time.appTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: darkGrayColor.withOpacity(.8))
              ],
            ),
            const Spacer(),
            showIcon ?? true ? Assets.icons.threeDote.svg() : SizedBox()
          ],
        ).paddingSymmetric(horizontal: 16.w),
        notes.isNotEmpty
            ? notes
                .appTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: darkGrayColor.withOpacity(.8))
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
                      border: Border.all(color: grey_D9D9D9)),
                  child: ProfileDataCard(
                    title: noteList[index],
                    height: 20.w,
                    titleColor: grey_969696,
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
      ],
    );
  }
}

class SelfDiscoveryCard extends StatelessWidget {
  const SelfDiscoveryCard(
      {Key? key, required this.title, this.onTap, this.size, this.color})
      : super(key: key);
  final String title;
  final double? size;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: size ?? 20.w,
            height: size ?? 20.w,
            decoration: BoxDecoration(
                color: grey_D9D9D9, borderRadius: BorderRadius.circular(4.r)),
          ),
          10.w.spaceW(),
          Expanded(
              child: title.appTextStyle(
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  fontColor: color ?? black_000000,
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
                color: boxGreyColor, borderRadius: BorderRadius.circular(4.r)),
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
  const FirstQueCard({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
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
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                  color: grey_D9D9D9, shape: BoxShape.circle),
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
      {Key? key, required this.title, this.onTap, required this.subTitle})
      : super(key: key);
  final String title;
  final String subTitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r), color: grey_D9D9D9),
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
          border: Border.all(color: grey_C4C4C4),
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
  const BottomBarWidget(
      {Key? key, required this.title, this.onTap, required this.color})
      : super(key: key);
  final String title;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20.w,
            width: 20.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: grey_D9D9D9,
            ),
          ),
          4.w.spaceH(),
          title.appTextStyle(
              fontWeight: FontWeight.w400, fontSize: 10.sp, fontColor: color)
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
