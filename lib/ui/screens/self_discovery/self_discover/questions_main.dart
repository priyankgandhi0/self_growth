import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/self_discovery/self_discover/questionas_screen.dart';
import 'package:self_growth/ui/screens/self_discovery/self_discover/self_discovery_con.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/common_widget.dart';

class FirstQuestionScreen extends StatelessWidget {
  FirstQuestionScreen({Key? key}) : super(key: key);
  final SelfDiscoveryCon selfDiscoveryCon = Get.put(SelfDiscoveryCon());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelfDiscoveryCon>(builder: (ctrl) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ctrl.isQueAns == 0
            ? GestureDetector(
                onTap: () {
                  ctrl.isQueAns = 1;
                },
                // splashFactory: NoSplash.splashFactory,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    'Maybe later'.appTextStyle(
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.end,
                        fontSize: 14.sp),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14.sp,
                    )
                  ],
                ),
              ).paddingOnly(right: 20.w)
            : const SizedBox(),
        backgroundColor: background_EBEBEB,
        body: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ctrl.isQueAns == 0
                  ? QuestionOneScreen(
                      ctrl: ctrl,
                    )
                  : ctrl.isQueAns == 1
                      ? QuestionTwoScreen(
                          ctrl: ctrl,
                        )
                      : QuestionThirdScreen(
                          ctrl: ctrl,
                        ),
              Container(
                height: 70.w,
                color: background_EBEBEB,
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            if (ctrl.isQueAns == 0) {
                              Get.back();
                            } else if (ctrl.isQueAns == 1) {
                              ctrl.isQueAns = 0;
                            } else {
                              ctrl.isQueAns = 1;
                            }
                          },
                          child: Assets.icons.backArrow.svg().paddingSymmetric(
                              horizontal: 16.w, vertical: 10.w),
                        ),
                        SizedBox(
                          width: Get.width - 110.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: StepProgressIndicator(
                              totalSteps: 4,
                              currentStep: ctrl.isQueAns == 0
                                  ? 1
                                  : ctrl.isQueAns == 1
                                      ? 2
                                      : 4,
                              size: 8.h,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              padding: 0,
                              selectedColor: grey_969696,
                              unselectedColor: grey_D9D9D9,
                              roundedEdges: Radius.circular(10.r),
                            ),
                          ),
                        ),
                        10.w.spaceW(),
                        '6/15'.appTextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14.sp)
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: (ctrl.isQueAns == 0
                              ? 'Screening'
                              : ctrl.isQueAns == 1
                                  ? 'Understanding'
                                  : 'Taking Over')
                          .appTextStyle(
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp),
                    ).paddingSymmetric(horizontal: 20.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
