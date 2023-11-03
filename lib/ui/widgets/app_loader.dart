import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: Get.height,
        color: Colors.white.withOpacity(0.5),
        child: const Center(
            child: CircularProgressIndicator(
          color: borderPinkColor,
        )));
  }
}
