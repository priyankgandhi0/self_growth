import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  AppContainer(
      {Key? key,
      BorderRadiusGeometry? borderRadius,
      double? height,
      double? width})
      : super(key: key);
  BorderRadiusGeometry? borderRadius;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        color: Colors.white,
      ),
    );
  }
}
