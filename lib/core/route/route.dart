import 'package:get/get.dart';

import '../../feature/feature.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String bioScreen = "/customer_bio";
  static const String dashboardScreen = "/dashboard_screen";
  static const String onboardScreen = "/onboard_screen";
  static const String bottomNav = "/bottom_navbar";
  static const String onChat = "/chat_on";
  static const String menuScreen = "/menu_screen";

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: bioScreen, page: () => CustomerBio()),
    GetPage(name: dashboardScreen, page: () => DashboardScreen()),
    GetPage(name: onboardScreen, page: () => OnboardScreens()),
    GetPage(name: bottomNav, page: () => BottomNavbar()),
    GetPage(name: onChat, page: () => ChatOn()),
    GetPage(
      name: menuScreen,
      page: () => MenuScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(
        milliseconds: 300,
      ),
    ),
  ];
}
