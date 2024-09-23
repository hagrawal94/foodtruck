import 'package:departuretimes/shared/constants/color.dart';
import 'package:departuretimes/shared/helper/di.dart';
import 'package:departuretimes/shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  // initialize firebase, crashlytics, remote config, and put controller in the dependency injector
  await DependencyInject().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteColor,
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: AppColors.blackColor),
          backgroundColor: AppColors.whiteColor,
          elevation: 0.5,
          centerTitle: true,
        ),
      ),
      enableLog: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
      title: 'Food Trucks'.tr,
    );
  }
}
