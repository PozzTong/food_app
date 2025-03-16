import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core.dart';

class LoadingIndicator extends StatelessWidget {
  final double strokeWidth;
  const LoadingIndicator({super.key, this.strokeWidth = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorResources.colorWhite,
          // boxShadow: MyUtils.getCardShadow(context)),
      ),
      child: const CircularProgressIndicator(
        color: ColorResources.primaryColor,
        strokeWidth: 3,
      ),
    );
  }
}
