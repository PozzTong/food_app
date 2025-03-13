import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/common.dart';
import '../../feature/feature.dart';
import '../core.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(()=> LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(()=> SplashController(apiClient: Get.find(), localizationController: Get.find()));
  Get.lazyPut(() => CartController(apiClient: Get.find()));
  // Get.lazyPut(()=> ThemeController(sharedPreferences: Get.find()));

  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};
  return language;
}
