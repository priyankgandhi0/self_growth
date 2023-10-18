import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:self_growth/core/utils/extentions.dart';

class TitleBar extends StatelessWidget {
  TitleBar(
      {Key? key,
      required this.title,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w500,
      this.isCenter = false})
      : super(key: key);
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isCenter;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.close),
        if (!isCenter) const Spacer(),
        Expanded(
          child: title.appTextStyle(),
        ),
      ],
    ).paddingSymmetric(horizontal: 20, vertical: 16);
  }
}
