import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/main.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';

import 'package:tripus/widgets/bottom_navigation.dart';

class ManyPolaroid extends StatefulWidget {
  const ManyPolaroid({super.key});

  @override
  State<ManyPolaroid> createState() => _ManyPolaroidState();
}

class _ManyPolaroidState extends State<ManyPolaroid> {
  String? _base64Image;
  File? _selectedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File imageFile = File(image.path);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      setState(() {
        _selectedImage = imageFile;
        _base64Image = base64Image;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditPolaroid(
            selectedImage: _selectedImage!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: 315,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [grey02, Color(0xff737373)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: dark08,
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 315,
              child: Row(
                children: [
                  Container(
                    width: 105,
                    height: 105,
                    color: grey02,
                  ),
                  Container(
                    width: 105,
                    height: 105,
                    color: grey03,
                  ),
                  Container(
                    width: 105,
                    height: 105,
                    color: grey01,
                    child: IconButton(
                      onPressed: pickImage,
                      icon: Icon(Icons.add),
                      iconSize: 25,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
