import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../widget/search_bar.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final String name = Get.arguments ?? '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackLead(),
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBars(),
            Column(
              children: List.generate(20, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.all(8.0),
                          // padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // color: Colors.amber,
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/image/burger.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text('Original Salad'),
                            subtitle: Text('Lovy Food'),
                            subtitleTextStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '\$8',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
