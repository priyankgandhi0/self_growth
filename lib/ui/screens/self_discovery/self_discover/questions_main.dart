import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/screens/self_discovery/self_discover/questionas_screen.dart';
import 'package:self_growth/ui/screens/self_discovery/self_discover/self_discovery_con.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../../gen/assets.gen.dart';

class FirstQuestionScreen extends StatefulWidget {
  const FirstQuestionScreen({Key? key}) : super(key: key);

  @override
  State<FirstQuestionScreen> createState() => _FirstQuestionScreenState();
}

class _FirstQuestionScreenState extends State<FirstQuestionScreen> {
  final SelfDiscoveryCon selfDiscoveryCon = Get.put(SelfDiscoveryCon());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selfDiscoveryCon.index = 1;
      selfDiscoveryCon.isQueAns = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelfDiscoveryCon>(builder: (ctrl) {
      return Scaffold(
        /* floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          visible: ctrl.isQueAns == 0,
          child: GestureDetector(
            onTap: () {

              ctrl.update();
            },
            // splashFactory: NoSplash.splashFactory,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                'Maybe later'.appSwitzerTextStyle(
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.end,
                    fontSize: 14.sp),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14.sp,
                )
              ],
            ),
          ).paddingOnly(right: 20.w, bottom: 24.w),
        ),*/
        backgroundColor: background_EBEBEB,
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.images.backGroundImage.path),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  16.w.spaceH(),
                  Row(
                    children: [
                      InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          if (ctrl.isQueAns == 1) {
                            ctrl.isQueAns = 0;
                          } else if (ctrl.isQueAns == 2) {
                            ctrl.isQueAns = 1;
                          } else {
                            if (ctrl.index != 1) {
                              ctrl.index--;
                            } else {
                              Get.back();
                            }
                          }
                          ctrl.update();
                        },
                        child: Assets.icons.backArrow
                            .svg()
                            .paddingSymmetric(horizontal: 16.w, vertical: 2.w),
                      ),
                      SizedBox(
                        width: Get.width - 110.w,
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: StepProgressIndicator(
                            totalSteps: 20,
                            currentStep: ctrl.index,
                            customStep: (index, color, size) {
                              return Container(
                                color: doteColor,
                                child: Container(
                                  width: size,
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(
                                              (index == ctrl.index - 1)
                                                  ? 10.r
                                                  : 0))),
                                ),
                              );
                            },
                            size: 8.h,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            padding: 0,
                            selectedColor: borderPurpleColor,
                            unselectedColor: doteColor,
                            roundedEdges: Radius.circular(10.r),
                          ),
                        ),
                      ),
                      10.w.spaceW(),
                      '${ctrl.index}/20'.appSwitzerTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          fontColor: borderPurpleColor),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: (ctrl.isQueAns == 0
                            ? 'Screening'
                            : ctrl.isQueAns == 1
                                ? 'Understanding'
                                : 'Taking Over')
                        .appSwitzerTextStyle(
                            textAlign: TextAlign.end,
                            fontColor: borderPurpleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                  ).paddingSymmetric(horizontal: 20.w),
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
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
