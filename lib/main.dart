import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:self_growth/core/constants/app_colors.dart';

import 'config/routes/router.dart';
import 'core/utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preferences.init();
  await preferences.putAppDeviceInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isLogin = preferences.getBool(SharedPreference.IS_LOG_IN) ?? false;
    return ScreenUtilInit(
      designSize: const Size(375, 843),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: .9,
          viewInsets: MediaQuery.of(context).viewInsets,
        ),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: background_EBEBEB,
            splashColor: grey_969696,
            timePickerTheme: TimePickerThemeData(
                helpTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600, fontFamily: 'Switzer'),
                dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.selected)
                        ? white_FFFFFF
                        : borderPurpleColor),
                dayPeriodColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.selected)
                        ? doteColor
                        : Colors.transparent),
                dialHandColor: borderPurpleColor,
                dialTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600, fontFamily: 'Switzer'),
                dialBackgroundColor: doteColor,
                hourMinuteTextColor: borderPurpleColor,
                hourMinuteColor: doteColor,
                dialTextColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.selected)
                        ? white_FFFFFF
                        : borderPurpleColor)
                // dayPeriodBorderSide: BorderSide.none,
                ),
            useMaterial3: true,
          ),
          getPages: Routes.pages,
          initialRoute:
              isLogin ? Routes.bottomNavigationScreen : Routes.onboarding,
        ),
      ),
    );
  }
}
