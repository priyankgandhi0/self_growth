import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

Future<Object?> appDialog(
    {required Widget contentWidget, bool isAnimated = false}) {
  return Get.dialog(DialogWithBackdrop(
    contentWidget: contentWidget,
    isAnimated: isAnimated,
  ));
}

class DialogWithBackdrop extends StatefulWidget {
  final bool showCloseButton;
  final Widget contentWidget;
  final bool alignParentRight;
  final bool isAnimated;

  const DialogWithBackdrop({
    Key? key,
    required this.contentWidget,
    this.showCloseButton = true,
    this.alignParentRight = true,
    this.isAnimated = false,
  }) : super(key: key);

  @override
  State<DialogWithBackdrop> createState() => _DialogWithBackdropState();
}

class _DialogWithBackdropState extends State<DialogWithBackdrop> {
  @override
  void initState() {
    super.initState();

    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const blurSigma = 2.0;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Builder(
          builder: (context) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurSigma,
                sigmaY: blurSigma,
              ),
              child: Dialog(
                backgroundColor: Colors.white,
                elevation: 0.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        widget.contentWidget,
                        if (widget.showCloseButton)
                          widget.alignParentRight
                              ? Positioned(
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (widget.isAnimated) {}
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: grey_C4C4C4,
                                      size: 25.sp,
                                    ),
                                  ),
                                )
                              : Positioned(
                                  left: 0,
                                  child: IconButton(
                                    onPressed: Navigator.of(context).pop,
                                    icon: Icon(
                                      Icons.close,
                                      color: grey_C4C4C4,
                                      size: 25.sp,
                                    ),
                                  ),
                                ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class OpenBottomDialog extends StatelessWidget {
  const OpenBottomDialog({
    Key? key,
    required this.context,
    required this.child,
    this.onTap,
  }) : super(key: key);
  final BuildContext context;
  final Widget child;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: doteColor.withOpacity(.4),
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // height: Get.height - padding,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.r))),
              child: child.paddingAll(20.w),
            ),
            100.w.spaceH(),
          ],
        ),
      ),
    );
  }
}

openBottomDialogBox(
    {required BuildContext context,
    required Widget child,
    required double padding}) {
  return showDialog(
    context: context,
    barrierColor: borderPurpleColor.withOpacity(.5),
    builder: (BuildContext context) {
      return AlertDialog(
          insetPadding: EdgeInsets.only(top: Get.height - padding),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                child: child.paddingAll(20.w),
              ),
            ],
          ));
    },
  );
}

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? textCancel;
  final String? textConfirm;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final bool? isCancel;

  const CustomDialog({
    super.key,
    required this.title,
    required this.description,
    this.textCancel,
    this.textConfirm,
    required this.onCancel,
    required this.onConfirm,
    this.isCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Platform.isAndroid
          ? AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              contentPadding:
                  const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
              titlePadding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 8),
              title: (title ?? 'Alert').appTextStyle(
                  textAlign: TextAlign.start, fontWeight: FontWeight.w800),
              content: (description ?? 'Description').appTextStyle(
                  textAlign: TextAlign.start,
                  fontFamily: 'Switzer',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400),
              actionsPadding: const EdgeInsetsDirectional.only(end: 8),
              actions: <Widget>[
                Visibility(
                  visible: isCancel!,
                  child: TextButton(
                      child: Text(
                        textCancel ?? 'Exit',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: borderPurpleColor,
                            fontFamily: 'Switzer'),
                      ),
                      onPressed: () {
                        // exit(0);
                        onCancel.call();
                      }),
                ),
                TextButton(
                    child: Text(
                      textConfirm ?? 'OK',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: borderPurpleColor,
                          fontSize: 18.sp,
                          fontFamily: 'Switzer'),
                    ),
                    onPressed: () {
                      onConfirm.call();
                    }),
              ],
            )
          : CupertinoAlertDialog(
              title: (title ?? 'Alert')
                  .appSwitzerTextStyle(fontWeight: FontWeight.w600),
              content: (description ?? 'Description').appTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Switzer'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: () {
                    onCancel.call();
                  },
                  child: Text(
                    textCancel ?? 'Exit',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: borderPurpleColor,
                        fontFamily: 'Switzer'),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    onConfirm.call();
                  },
                  child: Text(
                    textConfirm ?? 'OK',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: borderPurpleColor,
                        fontFamily: 'Switzer'),
                  ),
                ),
              ],
            ),
    );
  }
}

Future<DateTime> pickDateDialog({required BuildContext context}) {
  return showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: borderPurpleColor,
                hintColor: borderPurpleColor,
                colorScheme:
                    const ColorScheme.light(primary: borderPurpleColor),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      foregroundColor: borderPurpleColor // button text color
                      ),
                ),
              ),
              child: child!,
            );
          },
          lastDate:
              DateTime(2024)) //what will be the up to supported date in picker
      .then((pickedDate) {
    if (pickedDate != null) {
      return pickedDate;
    } else {
      return DateTime.now();
    }
  });
}

Future<TimeOfDay> pickedTime(BuildContext context) async {
  TimeOfDay? pickedTime = await showTimePicker(
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          shadowColor: Colors.transparent,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: borderPurpleColor,
                  fontFamily: 'Switzer'),
              foregroundColor: Colors.black,
            ),
          ),
        ),
        child: child!,
      );
    },
    context: context,
  );
  if (pickedTime != null) {
  } else {
    debugPrint("Time is not selected");
  }
  return pickedTime!;
}

void openColorPickerDialog(
    {String title = '',
    required Widget content,
    bool isShowButton = true,
    required BuildContext context,
    Function()? onSubmit}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(18.0),
        title: title.appSwitzerTextStyle(
            fontColor: borderPurpleColor,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp),
        content: content,
        actions: isShowButton
            ? [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: 'CANCEL'.appSwitzerTextStyle(
                      fontColor: borderPurpleColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: onSubmit,
                  child: 'SUBMIT'.appSwitzerTextStyle(
                      fontColor: borderPurpleColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              ]
            : [],
      );
    },
  );
}
