import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/common/common.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../feature.dart';

class LoginController extends GetxController {
  AuthRepo loginRepo;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  String? email;
  String? password;
  bool remember = false, isSubmitLoading = false;
  LoginController({required this.loginRepo});

  Future<void> checkAndGotoNextStep(LoginModel responseModel) async {
    if (remember) {
      await loginRepo.apiClient.sharedPreferences.setBool(
        SharedPreferenceHelper.rememberMeKey,
        true,
      );
    } else {
      await loginRepo.apiClient.sharedPreferences.setBool(
        SharedPreferenceHelper.rememberMeKey,
        false,
      );
    }

    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userIdKey,
      responseModel.data?.staffId.toString() ?? '-1',
    );

    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.accessTokenKey,
      responseModel.data?.accessToken.toString() ?? '',
    );

    Get.offAndToNamed(RouteHelper.bottomNav);

    if (remember) {
      changeRememberMe();
    }
  }

  void loginUser() async {
    isSubmitLoading = true;
    update();

    ResponseModel responseModel = await loginRepo.loginUser(
      emailController.text.toString(),
      passwordController.text.toString(),
    );
    if (responseModel.status) {
      LoginModel loginModel =
          LoginModel.fromJson(jsonDecode(responseModel.responseJson));
      checkAndGotoNextStep(loginModel);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isSubmitLoading = false;
    update();
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearText() {
    passwordController.text = "";
    emailController.text = "";
    if (remember) {
      remember = false;
    }
    update();
  }
}
