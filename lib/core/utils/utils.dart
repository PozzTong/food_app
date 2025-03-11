// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:food_app/common/common.dart';
// import 'package:food_app/core/core.dart';
// import 'package:get/get.dart';

// class MyUtils {
//   static splashScreenUtils(bool isDark) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         // statusBarColor: ColorResources.getScreenBgColor(),
//         statusBarBrightness: Brightness.light,
//         // systemNavigationBarColor: ColorResources.getScreenBgColor(),
//         systemNavigationBarIconBrightness: Brightness.light,
//       ),
//     );
//   }

//   static void allScreensUtils(bool isDark) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: ColorResources.getPrimaryColor(),
//         statusBarIconBrightness: Brightness.light,
//         // systemNavigationBarColor: ColorResources.getScreenBgColor(),
//         systemNavigationBarIconBrightness: Brightness.light,
//       ),
//     );
//   }

//   static dynamic getShadow() {
//     return [
//       BoxShadow(
//         blurRadius: 15,
//         offset: Offset(0, 25),
//         color: Colors.grey.shade500.withValues(alpha: 0.6),
//         spreadRadius: -35,
//       ),
//     ];
//   }

//   static dynamic getBottomSheetShadow(){
//     return [
//       BoxShadow(
//         // color: Get.find<ThemeController>().darkTheme
//         // ?Colors.black87.withValues(alpha: 0.3)
//         // :Colors.grey.shade400.withValues(alpha: 0.3),
//         spreadRadius: 1,
//         blurRadius: 4,
//         offset: Offset(0,3),
//       )
//     ];
//   }

//   static dynamic getCardShadow(BuildContext context){
//     return [
//       BoxShadow(
//         // color: Get.find<ThemeController>().darkTheme
//         //     ? Theme.of(context).shadowColor.withValues(alpha: 0.10)
//         //     : Colors.grey.shade400.withValues(alpha: 0.30),
//         spreadRadius: 1,
//         blurRadius: 4,
//         offset: const Offset(0, 3),
//       ),
//     ];
//   }

//   Color projectStatusColor(String state) {
//     Color color = ColorResources.blueColor;
//     switch (state) {
//       case '1':
//         color = ColorResources.darkColor;
//         break;
//       case '2':
//         color = ColorResources.blueColor;
//         break;
//       case '3':
//         color = ColorResources.yellowColor;
//         break;
//       case '4':
//         color = ColorResources.greenColor;
//         break;
//       case '5':
//         color = ColorResources.redColor;
//         break;
//     }
//     return color;
//   }

//   Color invoiceStatusColor(String state) {
//     Color color = ColorResources.blueColor;
//     switch (state) {
//       case '1':
//         color = ColorResources.redColor;
//         break;
//       case '2':
//         color = ColorResources.greenColor;
//         break;
//       case '3':
//         color = ColorResources.yellowColor;
//         break;
//       case '4':
//         color = ColorResources.yellowColor;
//         break;
//       case '5':
//         color = ColorResources.redColor;
//         break;
//       case '6':
//         color = ColorResources.darkColor;
//         break;
//     }
//     return color;
//   }

//   Color estimateStatusColor(String state) {
//     Color color = ColorResources.blueColor;
//     switch (state) {
//       case '1':
//         color = ColorResources.darkColor;
//         break;
//       case '2':
//         color = ColorResources.blueColor;
//         break;
//       case '3':
//         color = ColorResources.redColor;
//         break;
//       case '4':
//         color = ColorResources.greenColor;
//         break;
//       case '5':
//         color = ColorResources.yellowColor;
//         break;
//     }
//     return color;
//   }

//   Color contractStatusColor(String state) {
//     Color color = ColorResources.blueColor;
//     switch (state) {
//       case '0':
//         color = ColorResources.blueColor;
//         break;
//       case '1':
//         color = ColorResources.greenColor;
//         break;
//       case '2':
//         color = ColorResources.redColor;
//         break;
//       case '3':
//         color = ColorResources.yellowColor;
//         break;
//       case '4':
//         color = ColorResources.darkColor;
//         break;
//     }
//     return color;
//   }
// }
