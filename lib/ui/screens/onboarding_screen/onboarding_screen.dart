import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/ui/widgets/app_button.dart';
import 'package:self_growth/ui/widgets/login_popup.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../../languages/all_strings.dart';
import '../../widgets/app_bottom_sheet_dialog.dart';
import '../../widgets/app_title_bar.dart';
import '../../widgets/common_widget.dart';
import '../auth/auth_controller.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  final OnBoardingController onBoardingController =
      Get.put(OnBoardingController());

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        onBoardingController.pageController.animateToPage(
          onBoardingController.initialPage - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
        // onBoardingController.update();
        return Future.value(false);
      },
      child: GetBuilder<OnBoardingController>(builder: (ctrl) {
        return Stack(
          children: [
            Scaffold(
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundAppButton(
                    title: LanguageGlobalVar.getStartedText.tr,
                    onTap: () {
                      if (ctrl.initialPage == 2) {
                        Get.toNamed(Routes.personalInfoScreen);
                      } else {
                        ctrl.pageController.animateToPage(
                          ctrl.initialPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      }
                    },
                  ).paddingOnly(left: 24.w, right: 24.w, bottom: 16.w),
                  /*ctrl.initialPage == 0
                      ? */
                  RoundGradientAppButton(
                    title: LanguageGlobalVar.loginText.tr,
                    textColor: borderPurpleColor,
                    onTap: () {
                      appCustomBottomSheet(
                          context: context,
                          child: LoginPopup(
                            onLogin: () {
                              authController.userLogin();
                            },
                            onForgotPassword: () {
                              Get.toNamed(Routes.forgetPasswordScreen);
                            },
                          ));
                    },
                  ).paddingSymmetric(horizontal: 24.w)
                  /*: RoundAppButton(
                          title: nextText,
                          textColor: borderPurpleColor,
                          onTap: () {
                            if (ctrl.initialPage != 0) {
                              if (ctrl.initialPage == 2) {
                                Get.toNamed(Routes.personalInfoScreen);
                              } else {
                                ctrl.pageController.animateToPage(
                                  ctrl.initialPage + 1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              }
                            }
                          },
                        ).paddingSymmetric(horizontal: 46.w),*/
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: SafeArea(
                child: Column(
                  children: [
                    WithOutTitleAppBar(
                      onTap: () {
                        ctrl.pageController.animateToPage(
                          ctrl.initialPage - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                        ctrl.update();
                      },
                      showBackButton: ctrl.initialPage != 0,
                      suffixWidget: BorderButton(
                        title: LanguageGlobalVar.englishText.tr,
                        buttonColor: Colors.transparent,
                        width: 80.w,
                        onTap: () {},
                      ),
                    ).paddingOnly(top: 7.w),
                    60.w.spaceH(),
                    Stack(
                      children: [
                        SizedBox(
                          height: 400.w,
                          child: PageView(
                            onPageChanged: (value) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              ctrl.initialPage = value;
                            },
                            controller: ctrl.pageController,
                            children: <Widget>[
                              PageViewCard(
                                  ctrl: ctrl,
                                  image: Assets.images.onBording1.image(
                                      fit: BoxFit.contain,
                                      height: 230.w,
                                      width: 230.w),
                                  title: LanguageGlobalVar.learn.tr,
                                  subTitle:
                                  LanguageGlobalVar.learnDec1.tr,
                                  subTitle1:
                                  LanguageGlobalVar.learnDec2.tr),
                              PageViewCard(
                                  ctrl: ctrl,
                                  image: Assets.images.onBording2.image(
                                      fit: BoxFit.contain,
                                      height: 230.w,
                                      width: 230.w),
                                  title: LanguageGlobalVar.control.tr,
                                  subTitle: LanguageGlobalVar.secondScreenText.tr,
                                  subTitle1:
                                  LanguageGlobalVar.controlDec.tr),
                              PageViewCard(
                                  ctrl: ctrl,
                                  image: Assets.images.onBording3.image(
                                      fit: BoxFit.contain,
                                      height: 230.w,
                                      width: 230.w),
                                  title: LanguageGlobalVar.track.tr,
                                  subTitle1: '',
                                  subTitle: LanguageGlobalVar.thirdScreenText.tr)
                            ],
                          ),
                        ),
                        Positioned(
                          top: 260.w,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  3,
                                  (index) => CircleAvatar(
                                        radius: 4.r,
                                        backgroundColor:
                                            ctrl.initialPage == index
                                                ? borderPurpleColor
                                                : doteColor,
                                      ).paddingSymmetric(horizontal: 2.w)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ExpandablePageView extends StatefulWidget {
  final List<Widget> children;

  const ExpandablePageView({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    _heights = widget.children.map((e) => 0.0).toList();
    super.initState();
    _pageController = PageController()
      ..addListener(() {
        final newPage = _pageController.page?.round() ?? 0;
        if (_currentPage != newPage) {
          setState(() => _currentPage = newPage);
        }
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        controller: _pageController,
        children: _sizeReportingChildren
            .asMap() //
            .map((index, child) => MapEntry(index, child))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            //needed, so that parent won't impose its constraints on the children, thus skewing the measurement results.
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) =>
                  setState(() => _heights[index] = size.height),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    Key? key,
    required this.child,
    required this.onSizeChange,
  }) : super(key: key);

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }

  void _notifySize() {
    if (!mounted) {
      return;
    }
    final size = context.size;
    if (_oldSize != size && size != null) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}
