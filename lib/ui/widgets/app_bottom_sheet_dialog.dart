import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.sp),
            topRight: Radius.circular(16.sp),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [child],
            ),
          ),
        ),
      );
    },
  );
}
