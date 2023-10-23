import 'package:flutter/material.dart';
import 'package:self_growth/core/constants/app_colors.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChange,
  });
  final bool value;
  final Function(bool) onChange;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!value);
      },
      child: Container(
          width: 24,
          height: 16,
          padding: const EdgeInsets.symmetric(horizontal: 0.5),
          decoration: BoxDecoration(
              color: textPinkColor.withOpacity(value ? 0.5 : 0.0),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  width: 1, color: borderPurpleColor.withOpacity(0.5))),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: value ? borderPurpleColor : activeColor,
                shape: BoxShape.circle,
                border: Border.all(color: black_000000.withOpacity(0.2)),
              ),
            ),
          )),
    );
  }
}
