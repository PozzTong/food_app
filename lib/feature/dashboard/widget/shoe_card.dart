import 'package:flutter/material.dart';

class ShoeCard extends StatelessWidget {
  const ShoeCard({
    super.key,
    required this.ass,
    required this.title,
    required this.subtitle,
    required this.add,
    required this.fav,
    required this.addColor,
    required this.favColor,
  });
  final String ass;
  final String title;
  final String subtitle;
  final Function() add;
  final Function() fav;
  final Color addColor;
  final Color favColor;

  // final

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3 - 30,
      width: MediaQuery.of(context).size.width / 2,
      margin: EdgeInsets.only(top: 40),
      // padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -70,
            left: 50,
            right: 1,
            child: Image.asset(
              ass,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 5,
            left: 2,
            bottom: 6,
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              subtitleTextStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 18,
            child: GestureDetector(
              onTap: () => fav(),
              child: Container(
                height: 40,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                  color: Colors.blueAccent,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Icon(
                    Icons.favorite,
                    color: favColor,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 18,
            child: GestureDetector(
              onTap: () => add(),
              child: Container(
                height: 40,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  color: Colors.blueAccent,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Icon(
                    Icons.add,
                    color: addColor,
                    // size: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
