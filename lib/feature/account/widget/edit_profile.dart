import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/common.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackLead(),
        title: Text('Edit Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.done,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ProfileImage(
                size: size,
                asset: _image != null,
                image: 'assets/image/profile.png',
                file: _image,
                tap: () => _pickImage(),
                color: Colors.amber,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(text: 'Name'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: CustomTextField(
                      labelText: '',
                      hintText: 'Name',
                      // controller: controller.emailController,
                      onChanged: (value) {},
                      // focusNode: controller.emailFocusNode,
                      // nextFocus: controller.passwordFocusNode,
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                    ),
                  ),
                  text(text: 'Email Address'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextField(
                      hintText: 'Email Address',
                      textInputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {},
                    ),
                  ),
                  text(text: 'User Name'),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: CustomTextField(
                      onChanged: (value) {},
                      hintText: 'User Name',
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                    ),
                  ),
                  text(text: 'Phone Number'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextField(
                      hintText: '+855',
                      inputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                      onChanged: (value) {},
                    ),
                  ),
                  text(text: 'Password'),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: CustomTextField(
                      hintText: 'Password',
                      textInputType: TextInputType.multiline,
                      inputAction: TextInputAction.next,
                      isPassword: true,
                      isShowSuffixIcon: true,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget text({
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        top: 4,
        bottom: 4,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
