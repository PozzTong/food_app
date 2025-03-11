import 'package:flutter/material.dart';
import 'package:food_app/common/component/text/will_pop_widget.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';
import '../../feature.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AuthRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<LoginController>(
            builder: (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      // image: DecorationImage(
                      //     alignment: Alignment.topCenter,
                      //     image: AssetImage(
                      //       'assets/image/login.png',
                      //     ),
                      //     fit: BoxFit.cover,
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 80.0, bottom: 50.0),
                          child: Center(
                            child: Image.asset(
                              'assets/image/code_clans_logo.png',
                              // color: Colors.white,
                              height: 80,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: Dimensions.space30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign In to your account",
                                  style: TextStyle(
                                      fontSize: Dimensions.fontMediumLarge),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  labelText: 'Email',
                                  controller: controller.emailController,
                                  onChanged: (value) {},
                                  focusNode: controller.emailFocusNode,
                                  nextFocus: controller.passwordFocusNode,
                                  textInputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return LocalStrings.fieldErrorMsg.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: Dimensions.space20),
                                CustomTextField(
                                  labelText: LocalStrings.password.tr,
                                  controller: controller.passwordController,
                                  focusNode: controller.passwordFocusNode,
                                  onChanged: (value) {},
                                  isShowSuffixIcon: true,
                                  isPassword: true,
                                  textInputType: TextInputType.text,
                                  inputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return LocalStrings.fieldErrorMsg.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.space20,
                                      top: Dimensions.space20),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Dimensions.defaultRadius,
                                              ),
                                            ),
                                            activeColor: Colors.black,
                                            checkColor: Colors.green,
                                            value: controller.remember,
                                            side: WidgetStateBorderSide
                                                .resolveWith(
                                              (states) => BorderSide(
                                                  width: 1.0,
                                                  color: controller.remember
                                                      ? ColorResources
                                                          .getTextFieldEnableBorder()
                                                      : ColorResources
                                                          .getTextFieldDisableBorder()),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                controller.changeRememberMe();
                                              });
                                            }),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Remember Me',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color!
                                                .withValues(alpha: 0.5)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                controller.isSubmitLoading
                                    ? Container()
                                    : RoundedButton(
                                        text: LocalStrings.signIn.tr,
                                        press: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.loginUser();
                                          }
                                        })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
