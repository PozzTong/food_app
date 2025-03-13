import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../feature.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final controller = Get.put(DashboardController(dashboardRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('My Profile'),
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
                    child: Container(
                      height: size.height / 6,
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/image/profile.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            right: 25,
                            child: Container(
                              height: 30,
                              width: 30, // Ensure it has equal width and height
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: IconButton(
                                padding:
                                    EdgeInsets.zero, // Remove extra padding
                                constraints:
                                    BoxConstraints(), // Prevent extra space
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('Your Name'),
                          subtitle: Text('Email'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
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
                    title: 'Favorit',
                    icon: Icons.favorite,
                    tap: () {},
                  ),
                  iconCard(
                    title: 'Downloads',
                    icon: Icons.file_open_outlined,
                    tap: () {},
                  ),
                  iconCard(
                    title: 'Language',
                    icon: Icons.language,
                    tap: () {},
                  ),
                  iconCard(
                    title: "Locations",
                    icon: Icons.pin_drop_outlined,
                    tap: () {},
                  ),
                  iconCard(
                    title: 'Subscription',
                    icon: Icons.subtitles_sharp,
                    tap: () {},
                  ),
                  iconCard(
                    title: 'Clear Cashe',
                    icon: Icons.delete,
                    tap: () {},
                  ),
                  iconCard(
                    title: 'Clear History',
                    icon: Icons.access_time_rounded,
                    tap: () {},
                  ),
                  iconCard(
                    title: "Log Out",
                    icon: Icons.logout_sharp,
                    tap: () {
                      const WarningAlertDialog().warningAlertDialog(
                        context,
                        () {
                          Get.back();
                          Get.find<DashboardController>().logout();
                        },
                        title: 'LocalStrings.logout.tr',
                        subTitle: 'LocalStrings.logoutSureWarningMSg.tr',
                      );
                    },
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
            leading: Icon(icon),
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
