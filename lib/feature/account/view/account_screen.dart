import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';
import '../../feature.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final controller = Get.put(DashboardController(dashboardRepo: Get.find()));
  // late final DashboardModel homeModel;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(LocalStrings.profile.tr),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: GetBuilder<DashboardController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ProfileImage(
                      size: size,
                      image: 'assets/image/profile.png',
                      tap: () {},
                      color: Colors.amber,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            '${controller.homeModel.staff!.firstName ?? ''} ${controller.homeModel.staff!.lastName ?? ''}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            controller.homeModel.staff!.email ?? '',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed(RouteHelper.editProfile);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  iconCard(
                    title: 'Favorite',
                    icon: Icons.favorite,
                    tap: () {},
                    color: null,
                  ),
                  iconCard(
                    title: LocalStrings.downloading.tr,
                    icon: FontAwesomeIcons.download,
                    tap: () {},
                    color: null,
                  ),
                  iconCard(
                    title: LocalStrings.language.tr,
                    icon: FontAwesomeIcons.language,
                    tap: () {
                      final apiClient =
                          Get.put(ApiClient(sharedPreferences: Get.find()));
                      SharedPreferences pref = apiClient.sharedPreferences;
                      String language = pref.getString(SharedPreferenceHelper
                              .languageListKey) ?? // to save on shared preference
                          '';
                      String countryCode =
                          pref.getString(SharedPreferenceHelper.countryCode) ??
                              'US';
                      String languageCode =
                          pref.getString(SharedPreferenceHelper.languageCode) ??
                              'en';
                      Locale local = Locale(languageCode, countryCode);
                      CustomBottomSheet(
                        child: LanguageBottomSheetScreen(
                          languageList: language,
                          selectedLocal: local,
                        ),
                      ).customBottomSheet(context);
                    },
                    color: null,
                  ),
                  iconCard(
                    title: "Locations",
                    icon: FontAwesomeIcons.mapLocation,
                    tap: () {
                      Get.toNamed(RouteHelper.location);
                    },
                    color: null,
                  ),
                  iconCard(
                    title: 'Subscription',
                    icon: Icons.subtitles_sharp,
                    tap: () {},
                    color: null,
                  ),
                  iconCard(
                    title: 'Clear Cashe',
                    icon: Icons.delete_outline_rounded,
                    tap: () {},
                    color: null,
                  ),
                  iconCard(
                    title: 'Clear History',
                    icon: Icons.access_time_rounded,
                    tap: () {},
                    color: null,
                  ),
                  iconCard(
                    title: LocalStrings.logout.tr,
                    icon: Icons.logout_sharp,
                    tap: () {
                      const WarningAlertDialog().warningAlertDialog(
                        context,
                        () {
                          Get.back();
                          Get.find<DashboardController>().logout();
                        },
                        title: LocalStrings.logout.tr,
                        subTitle: LocalStrings.logoutSureWarningMSg.tr,
                      );
                    },
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget iconCard({
    required String title,
    required IconData icon,
    required Function tap,
    required Color? color,
  }) {
    return GestureDetector(
      onTap: () => tap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            contentPadding: EdgeInsets.only(right: 8, left: 16),
            leading: Icon(
              icon,
              color: color,
            ),
            title: Text(title),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ),
      ),
    );
  }
}
