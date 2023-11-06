import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/onboarding_screen/onboarding_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constant.dart';
import '../../gen/assets.gen.dart';
import '../screens/habit_module/create_new_habit.dart';

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

        64.w.spaceH(),
        title
            .appSwitzerTextStyle(
                fontColor: borderPurpleColor,
                fontWeight: FontWeight.w600,
                fontSize: 22.sp)
            .paddingSymmetric(horizontal: 46.w)
            .paddingOnly(bottom: 5.w),
        /*   subTitle
            .appSwitzerTextStyle(
                fontColor: borderPurpleColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                fontSize: 12.sp)
            .paddingSymmetric(horizontal: 24.w),*/
        22.w.spaceH(),
        subTitle
            .appSwitzerTextStyle(
                fontColor: borderPurpleColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                fontSize: 12.sp)
            .paddingSymmetric(horizontal: 24.w),
      ],
    );
  }
}

class ProfileBoxCard extends StatelessWidget {
  const ProfileBoxCard(
      {Key? key, required this.child, this.widget, this.margin})
      : super(key: key);
  final Widget child;
  final Widget? widget;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
                width: Get.width,
                margin: EdgeInsets.only(top: margin ?? 50.w),
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
    this.fontWeight,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;
  final double? height;
  final FontWeight? fontWeight;
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
          title.appSwitzerTextStyle(
              fontWeight: fontWeight ?? FontWeight.w600,
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
        title.appSwitzerTextStyle(
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
                            child: '${index + 1}'.appGradientTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: white_FFFFFF)))
                    : IconCard(
                        title: '${index + 1}',
                        isHome: true,
                      ))
      ],
    ).paddingOnly(right: 30.w);
  }
}

class AddImageCard extends StatelessWidget {
  const AddImageCard(
      {Key? key, this.onTap, this.height, this.padding, this.widget})
      : super(key: key);
  final void Function()? onTap;
  final double? height;
  final double? padding;
  final Widget? widget;
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
        child: widget ??
            Column(
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
    this.chipTitleColor,
  }) : super(key: key);
  final String title;
  final String notes;
  final String time;
  final bool? showIcon;
  final bool? isVoiceNote;
  final bool? isImage;
  final String image;
  final Widget? widget;
  final Color? chipTitleColor;

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
                title.appSwitzerTextStyle(
                    fontWeight: FontWeight.w600, fontSize: 17.sp),
                time.appSwitzerTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: borderPurpleColor.withOpacity(.8))
              ],
            ),
            const Spacer(),
            showIcon ?? true
                // ignore: deprecated_member_use_from_same_package
                ? Assets.icons.threeDote.svg(color: borderPurpleColor)
                : const SizedBox()
          ],
        ).paddingSymmetric(horizontal: 16.w),
        notes.isNotEmpty
            ? notes
                .appSwitzerTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: doteColor)
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
                    fontWeight: FontWeight.w500,
                    image: noteImageList[index],
                    titleColor: chipTitleColor ?? borderPurpleColor,
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
                    // gradient: LinearGradient(colors: [
                    //   const Color(0XFFD4E0DF).withOpacity(.5),
                    //   const Color(0XFFE0CECD).withOpacity(.5),
                    //   const Color(0XFFEDE3FF).withOpacity(.5),
                    // ]),
                    image: DecorationImage(
                        image: AssetImage(Assets.images.butCon.path)),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(12.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    'View history'.appSwitzerTextStyle(
                        fontColor: doteColor,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w600),
                    5.w.spaceW(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: doteColor,
                      size: 12.w,
                    )
                  ],
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

class CommonDivider extends StatelessWidget {
  const CommonDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Assets.icons.divider.svg(width: Get.width);
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
              child: title.appSwitzerTextStyle(
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
              child: value.appSwitzerTextStyle(
                  fontWeight: FontWeight.w600, fontSize: 12.sp),
            ),
          ),
          10.w.spaceW(),
          Expanded(
              child: title.appSwitzerTextStyle(
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  fontColor: borderPurpleColor.withOpacity(.7),
                  fontSize: 12.sp))
        ],
      ),
    );
  }
}

class FirstQueCard extends StatelessWidget {
  const FirstQueCard(
      {Key? key,
      required this.title,
      this.onTap,
      required this.icon,
      required this.isSelected})
      : super(key: key);
  final String title;
  final bool isSelected;
  final String icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: white_FFFFFF,
            border: Border.all(
                color: isSelected ? borderPurpleColor : white_FFFFFF)),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 32.w,
              height: 32.w,
              fit: BoxFit.fill,
            ),
            10.w.spaceW(),
            title.appSwitzerTextStyle(
                fontWeight: FontWeight.w400, fontSize: 12.sp)
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
              title.appSwitzerTextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14.sp),
              subTitle.appSwitzerTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  fontColor: doteColor)
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title
              .appSwitzerTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)
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
                // ignore: deprecated_member_use
                color: iconColor,
                height: 20.w,
                width: 20.w,
                fit: BoxFit.fill,
              ),
              4.w.spaceH(),
              title.appSwitzerTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  fontColor: color)
            ],
          ),
    ));
  }
}

class AppDropDown extends StatelessWidget {
  const AppDropDown({Key? key, this.onChanged, this.value}) : super(key: key);
  final void Function(Gender?)? onChanged;
  final Gender? value;
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
                    .appSwitzerTextStyle(
                      fontColor: doteColor.withOpacity(.6),
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
                          child: Text(
                            e.name,
                            style: const TextStyle(
                                fontFamily: 'Switzer',
                                fontWeight: FontWeight.w500,
                                color: borderPurpleColor),
                          ).paddingAll(8),
                        ))
                    .toList(),
                onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}

SizedBox commonCachedNetworkImage(
    {required String imageUrl,
    required double height,
    required double width,
    ColorFilter? colorFilter}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color: grey_C4C4C4,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: grey_D9D9D9.withOpacity(.5),
                  highlightColor: grey_C4C4C4.withOpacity(.5),
                  enabled: true,
                  child: Container(
                    height: 100.w,
                    width: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: grey_D9D9D9,
                      border: Border.all(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                ),
            errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 100.w,
                    width: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: grey_D9D9D9,
                      border: Border.all(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                ))),
  );
}
