import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../feature.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key, required this.homeModel});
  final DashboardModel homeModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: CachedNetworkImage(
                    imageUrl: homeModel.staff!.profileImage!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: Dimensions.space20),
                SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${homeModel.staff?.firstName ?? ''} ${homeModel.staff?.lastName ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: mediumLarge,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Get.toNamed(RouteHelper.profileScreen);
                          },
                          child: Text(
                            LocalStrings.viewProfile.tr,
                            style: semiBoldLarge.copyWith(
                                color: Theme.of(context).secondaryHeaderColor,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
