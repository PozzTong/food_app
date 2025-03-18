import 'package:flutter/material.dart';
import '/core/service/di_service.dart' as services;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/common.dart';
import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedpreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedpreferences);
  Map<String, Map<String, String>> languages = await services.init();
  // HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp(
    languages: languages,
  ));
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizeController) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        defaultTransition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 200),
        navigatorKey: Get.key,
        getPages: RouteHelper().routes, //to subport getx
        initialRoute: RouteHelper.splashScreen,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        locale: localizeController.locale,
        translations: Messages(languages: languages),
        fallbackLocale: Locale(
          localizeController.locale.languageCode,
          localizeController.locale.countryCode,
        ),
      );
    });
  }
}
