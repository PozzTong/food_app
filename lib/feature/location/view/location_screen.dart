import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackLead(),
        title: Text('My Location'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(RouteHelper.createLocation);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(4),
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     bottom: BorderSide(color: ColorResources.colorBlack),
                      //   ),
                      // ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Card(
                                  color: Colors.pink.withOpacity(0.2),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      'Work',
                                      style: TextStyle(
                                        color: Colors.pink,
                                      ),
                                    ),
                                  )),
                              Text('Place Name')
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text('Mr.Name  Phone Number'),
                              ),
                              Icon(Icons.edit_note),
                              Icon(Icons.delete_outline_rounded)
                            ],
                          )
                        ],
                      ),
                    ),
                    if (index != 3)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(),
                      ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
