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
              title:
                  (title ?? 'Alert').appTextStyle(textAlign: TextAlign.start),
              content: (description ?? 'Description').appTextStyle(
                  textAlign: TextAlign.start,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
              actionsPadding: const EdgeInsetsDirectional.only(end: 8),
              actions: <Widget>[
                TextButton(
                    child: Text(textConfirm ?? 'OK'),
                    onPressed: () {
                      onConfirm.call();
                    }),
                Visibility(
                  visible: isCancel!,
                  child: TextButton(
                      child: Text(textCancel ?? 'Exit'),
                      onPressed: () {
                        // exit(0);
                        onCancel.call();
                      }),
                )
              ],
            )
          : CupertinoAlertDialog(
              title: (title ?? 'Alert').appTextStyle(),
              content: (description ?? 'Description')
                  .appTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: () {
                    onCancel.call();
                  },
                  child: Text(
                    textCancel ?? 'Exit',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    onConfirm.call();
                  },
                  child: Text(
                    textConfirm ?? 'OK',
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                ),
              ],
            ),
    );
  }
}
