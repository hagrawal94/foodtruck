import 'package:departuretimes/modules/home/screens/home_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/home';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
  ];
}
