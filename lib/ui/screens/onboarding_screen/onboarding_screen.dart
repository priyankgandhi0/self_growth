import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/utils/extentions.dart';
import 'package:self_growth/generated/assets.dart';
import 'package:self_growth/ui/widgets/app_button.dart';
import 'package:self_growth/ui/widgets/login_popup.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/app_bottom_sheet_dialog.dart';
import '../../widgets/app_title_bar.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/file_picker_utils.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  final OnBoardingController onBoardingController =
      Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (ctrl) {
      return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: ctrl.initialPage == 0,
              child: RoundAppButton(
                title: getStartedText,
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
              ).paddingOnly(left: 46.w, right: 46.w, bottom: 16.w),
            ),
            RoundAppButton(
              title: ctrl.initialPage == ctrl.pageController.initialPage
                  ? loginText
                  : nextText,
              color: ctrl.initialPage == 0 ? lightGrayColor : grey_969696,
              textColor: ctrl.initialPage == 0 ? darkGrayColor : white_FFFFFF,
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
                } else {
                  appCustomBottomSheet(
                      context: context,
                      child: LoginPopup(
                        onLogin: (login) {
                          Get.toNamed(Routes.bottomNavigationScreen);
                        },
                        onForgotPassword: () {},
                      ));
                }
              },
            ).paddingSymmetric(horizontal: 46.w),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
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
                  title: englishText,
                  width: 80.w,
                  onTap: () {},
                ),
              ).paddingOnly(top: 7.w),
              GestureDetector(
                onTap: () {
                  PickFile()
                      .openImageChooser(context: context, onImageChose: () {});
                },
                child: Container(
                  height: 250.w,
                  width: Get.width,
                  margin: EdgeInsets.only(top: 50.w),
                  decoration: BoxDecoration(
                      color: background_F5F5F5,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: grey_969696.withOpacity(0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.iconsImage),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 47.w),
              ),
              20.w.spaceH(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: ctrl.initialPage == 0 ? 120.h : 140.h,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ctrl.initialPage = value;
                  },
                  controller: ctrl.pageController,
                  children: const <Widget>[
                    PageViewCard(title: firstScreenTextText, subTitle: ''),
                    PageViewCard(title: whyUsText, subTitle: secondScreenText),
                    PageViewCard(
                        title: andHowIsThatText, subTitle: thirdScreenText)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => CircleAvatar(
                            radius: 3.r,
                            backgroundColor: ctrl.initialPage == index
                                ? grey_969696
                                : doteColor,
                          ).paddingSymmetric(horizontal: 1.w)),
                ),
              ),
            ],
          ),
        ),
      );
    });
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
