import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackLead extends StatelessWidget {
  const BackLead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.pink.withOpacity(0.4),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
