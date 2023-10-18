import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/gen/assets.gen.dart';

Future<Object?> appCustomBottomSheet({
  required BuildContext context,
  required Widget child,
  bool? isDismissible,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible ?? true,
    context: context,
    useSafeArea: true,
    elevation: 0,
    isScrollControlled: true,
    builder: (BuildContext context1) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.sp),
            topRight: Radius.circular(30.sp),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                15.w.spaceH(),
                Assets.icons.addTo.svg(
                  width: 50.w,
                  height: 4.h,
                ),
                child
              ],
            ),
          ),
        ),
      );
    },
  );
}
