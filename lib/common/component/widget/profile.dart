import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.size,
    this.image,
    required this.tap,
    required this.color,
    this.asset,
    this.file,
  });

  final Size size;
  final String? image;
  final VoidCallback? tap;
  final bool? asset;
  final Color color;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width / 3,
      width: size.width / 3,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        image: DecorationImage(
          image: asset == true ? FileImage(file!) : AssetImage(image!),
          fit: BoxFit.contain,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: 0,
            left: size.width / 3 - 20,
            child: Container(
              height: 30,
              width: 30, // Ensure it has equal width and height
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: IconButton(
                padding: EdgeInsets.zero, // Remove extra padding
                constraints: BoxConstraints(), // Prevent extra space
                onPressed: tap,

                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
