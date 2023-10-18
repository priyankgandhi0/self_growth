import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';

class AppProgressBar extends StatelessWidget {
  final bool showBlurBack;

  const AppProgressBar({Key? key, this.showBlurBack = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: SizedBox(
        width: double.infinity,
        height: Get.height,
        // color: Colors.white.withOpacity(0.5),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: showBlurBack ? 3 : 0, sigmaY: showBlurBack ? 3 : 0),
          child: const Center(
            child: CircularProgressIndicator(
              color: background_F5F5F5,
            ),
          ),
        ),
      ),
    );
  }
}
