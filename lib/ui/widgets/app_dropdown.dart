// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:self_growth/core/constants/app_colors.dart';
// import 'package:self_growth/core/utils/extentions.dart';
//
// class AppDropDown extends StatelessWidget {
//   const AppDropDown({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: background_F5F5F5, borderRadius: BorderRadius.circular(8)),
//       child: Row(
//         children: [
//           Expanded(
//             child: DropdownButton<T>(
//               style: getTextStyle(),
//               value: ctrl.gender,
//               underline: Container(),
//               hint: 'Gender'
//                   .appTextStyle(
//                     fontColor: grey_969696,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   )
//                   .paddingOnly(left: 8),
//               borderRadius: BorderRadius.circular(16),
//               icon: Container(),
//               dropdownColor: Colors.white,
//               items: Gender.values
//                   .map((e) => DropdownMenuItem(
//                         value: e,
//                         child: Text(e.name).paddingAll(8),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 ctrl.gender = value;
//                 ctrl.update();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
