import 'package:flutter/material.dart';
import 'package:food_app/core/core.dart';
import 'package:get/get.dart';

// import '../../../common/common.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});
  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    // Get.put(DashboardRepo(apiClient: Get.find()));
    // final controller = Get.put(DashboardController(dashboardRepo: Get.find()));
    // controller.isLoading = true;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // controller.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            Column(
              children: List.generate(10, (index) {
                String name='Mr.Yakusa';
                return GestureDetector(
                  onTap: () => Get.toNamed(
                    RouteHelper.onChat,arguments: name
                  ),
                  child: Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 30,
                            child: Image.asset(
                              'assets/image/avatars.png',
                              height: 100,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(name),
                            subtitle: Text("I'll be there in two mins."),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                // margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('9'),
                                ),
                              ),
                              Text(
                                '20.00',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
