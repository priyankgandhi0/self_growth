import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: white_FFFFFF, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
          ),
          12.spaceH(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Drinking Water'
                  .appTextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              8.spaceH(),
              'Drinking Water'.appTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontColor: black_000000.withOpacity(0.5)),
              Wrap(
                runSpacing: 5.0,
                spacing: 5.0,
                children: [
                  Chip(
                    backgroundColor: background_F5F5F5,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: const Text("Popular"),
                    // color: MaterialStatePropertyAll<Color>(background_F5F5F5),
                  ),
                  Chip(
                    backgroundColor: background_F5F5F5,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: const Text("Popular"),
                    // color: MaterialStatePropertyAll<Color>(background_F5F5F5),
                  ),
                  Chip(
                    backgroundColor: background_F5F5F5,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: const Text("Popular"),
                    // color: MaterialStatePropertyAll<Color>(background_F5F5F5),
                  ),
                  Chip(
                    backgroundColor: background_F5F5F5,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: const Text("Popular"),
                    // color: MaterialStatePropertyAll<Color>(background_F5F5F5),
                  ),
                  Chip(
                    backgroundColor: background_F5F5F5,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: const Text("Popular"),
                    // color: MaterialStatePropertyAll<Color>(background_F5F5F5),
                  ),
                ],
              )
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 12),
    );
  }
}
