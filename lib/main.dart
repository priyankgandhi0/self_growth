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
    return ScreenUtilInit(
      designSize: const Size(375, 843),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MediaQuery(
        data: const MediaQueryData(textScaleFactor: .9),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: background_EBEBEB,
            splashColor: grey_969696,
            useMaterial3: true,
          ),
          getPages: Routes.pages,
          initialRoute: Routes.personalInfoScreen,
        ),
      ),
    );
  }
}
