import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/core.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackLead(),
        title: Text('CheckOut'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.location);
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(5),
                          dashPattern: [
                            6,
                            3
                          ], // Dashes of length 6 and spaces of length 3
                          color: Colors.pink,
                          strokeWidth: 2,
                          child: Container(
                            alignment: Alignment.center,
                            height: size.width * 0.17,
                            width: size.width * 0.17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text('Place Name'),
                            subtitle: Text('Name & Phone Number'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            contentPadding: EdgeInsets.only(
                              right: 1,
                              left: 8,
                              top: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('  Delivery Time'),
                      Text('Instant(11:23) '),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('  Delivery Service'),
                      Text('Downstairs pick-up'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
