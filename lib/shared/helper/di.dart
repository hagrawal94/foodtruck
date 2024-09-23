import 'package:departuretimes/modules/home/controllers/home_controller.dart';
import 'package:departuretimes/modules/home/services/food_truck_service.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../firebase_options.dart';

class DependencyInject {
  // get build mode from environment variable
  static const String buildMode =
      String.fromEnvironment('BUILD_MODE', defaultValue: 'dev');

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // initialize firebase, and app check
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: buildMode == 'dev'
          ? AndroidProvider.debug
          : AndroidProvider.playIntegrity,
      appleProvider:
          buildMode == 'dev' ? AppleProvider.debug : AppleProvider.deviceCheck,
    );
    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
    // set crashlytics to record flutter errors
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    // setup remote config
    await _setupRemoteConfig();
    // put the home controller in the dependency injector
    Get.lazyPut(() => HomeController());
    // put the food truck service in the dependency injector
    Get.lazyPut(() => FoodTruckService());
  }

  Future<void> _setupRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 60),
          minimumFetchInterval: const Duration(hours: 1)));
      await remoteConfig.fetch();
      await remoteConfig.activate();

      remoteConfig.getValue('${buildMode}_host');
    } catch (e) {
      debugPrint('Failed to initialize remote config: $e');

      Fluttertoast.showToast(
          msg: 'Something went wrong, please try again later');
    }

    // Register RemoteConfig instance to GetIt
    Get.put(remoteConfig);
  }
}
