
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../core/core.dart';

// class ThemeController extends GetxController implements GetxService{
//   final SharedPreferences sharedPreferences;
//   bool _darkTheme= false;
//   bool get darkTheme=>_darkTheme;
//   ThemeController ({required this.sharedPreferences}){
//  _loadCurrentTheme();   
//   }

//   void _loadCurrentTheme () {
//     _darkTheme= sharedPreferences.getBool(SharedPreferenceHelper.theme)??false;
//     update();
//   }

//   void changeTheme (){
//     _darkTheme =!_darkTheme;
//     sharedPreferences.setBool('theme',_darkTheme);
//     if(_darkTheme){
//       Get.changeTheme(dark);
//     }else{
//       Get.changeTheme(light);
//     }

//     update();
//   }


// }