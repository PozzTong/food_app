import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';

class ChatOn extends StatefulWidget {
  const ChatOn({super.key});
  @override
  State<ChatOn> createState() => _ChatOnState();
}

class _ChatOnState extends State<ChatOn> {
  @override
  Widget build(BuildContext context) {
    String imagePath = 'assets/image/avatars.png';
    final String name = Get.arguments ?? 'Chat';
    return Scaffold(
      appBar: AppBar(
        leading: BackLead(),
        title: Row(
          children: [
            CircleAvatar(
              child: Image.asset(imagePath),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
              child: Center(child: Text("Hello"))),
          Text('Hello')
        ],
      ),
    );
  }
}
