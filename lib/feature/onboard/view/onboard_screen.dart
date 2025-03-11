import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/common/common.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../core/core.dart';

class OnboardScreens extends StatefulWidget {
  const OnboardScreens({super.key});
  @override
  State<OnboardScreens> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreens> {
  final introKey = GlobalKey<IntroductionScreenState>();
  var currentPageID = 0;
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      bodyPadding: EdgeInsets.only(
        top: Dimensions.space200,
      ),
      key: introKey,
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,
      skip: Icon(
        Icons.skip_next,
      ),
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Image.asset(
            'assets/image/code_clans_logo.png',
            height: Dimensions.space60,
          ),
        ),
      ),
      showSkipButton: false,
      dotsFlex: 1,
      showDoneButton: false,
      showBackButton: false,
      back: Icon(Icons.arrow_back),
      next: Icon(Icons.arrow_forward),
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(Dimensions.space15),
      controlsPadding: kIsWeb
          ? EdgeInsets.all(Dimensions.space12)
          : EdgeInsets.fromLTRB(
              Dimensions.space8,
              Dimensions.space3,
              Dimensions.space8,
              Dimensions.space10,
            ),
      dotsDecorator: DotsDecorator(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.space3,
            ),
          ),
        ),
        activeColor: ColorResources.primaryColor,
        size: Size(10.0, 5.0),
        color: ColorResources.hintColor,
        activeSize: Size(
          Dimensions.space20,
          Dimensions.space5,
        ),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.space3,
            ),
          ),
        ),
      ),
      onChange: (v) {
        debugPrint("Page Key $v");
        setState(() {
          currentPageID = v;
        });
      },
      pages: [
        PageViewModel(
            title: 'Hello Flutter',
            body: "Hello Flutter",
            image: Lottie.asset('assets/lottie/food.json')),
        PageViewModel(
            title: 'Hello Flutter',
            body: "Hello Flutter",
            image: Lottie.asset('assets/lottie/food.json')),
        PageViewModel(
            title: 'Hello Flutter',
            body: "Hello Flutter",
            image: Lottie.asset('assets/lottie/food.json')),
      ],
      globalFooter: Column(
        children: [
          RoundedButton(
            horizontalPadding: 8,
            text: 'text',
            cornerRadius: Dimensions.space10,
            press: () async {
              if (introKey.currentState!.getCurrentPage() + 1 ==
                  introKey.currentState!.getPagesLength()) {
                await Get.find<ApiClient>()
                    .sharedPreferences
                    .setBool(SharedPreferenceHelper.onboardKey, true)
                    .whenComplete(() {
                  Get.offAllNamed(RouteHelper.loginScreen);
                });
              } else {
                introKey.currentState!.next();
              }
            },
          ),
          SizedBox(
            height: Dimensions.space5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              height: 1,
              color: ColorResources.appBarColor,
            ),
          )
        ],
      ),
    );
  }
}
