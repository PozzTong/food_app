import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Text('data'),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
