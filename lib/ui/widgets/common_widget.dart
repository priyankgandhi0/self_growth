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
  const ProfileDataCard({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
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
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: grey_D9D9D9),
          ),
          10.w.spaceW(),
          title.appTextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)
        ],
      ),
    );
  }
}

class SelfDiscoveryCard extends StatelessWidget {
  const SelfDiscoveryCard({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
                color: grey_D9D9D9, borderRadius: BorderRadius.circular(4.r)),
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

class CommonSwitch extends StatefulWidget {
  const CommonSwitch({Key? key, this.onTap, required this.mainAxisAlignment})
      : super(key: key);
  final void Function()? onTap;
  final MainAxisAlignment mainAxisAlignment;

  @override
  State<CommonSwitch> createState() => _CommonSwitchState();
}

class _CommonSwitchState extends State<CommonSwitch> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          height: 16.w,
          width: 24.w,
          decoration: BoxDecoration(
              color: white_FFFFFF,
              border: Border.all(color: grey_D9D9D9),
              borderRadius: BorderRadius.circular(40.r)),
          child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: [
              Container(
                height: 12.w,
                width: 12.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: grey_D9D9D9.withOpacity(.6),
                    border: Border.all(color: greyBorderColor.withOpacity(.5))),
              )
            ],
          ).paddingSymmetric(horizontal: 2.w)),
    );
  }
}
