import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/main.dart';
import 'package:tripus/pages/polaroid/many_polaroid.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';

import 'package:tripus/widgets/bottom_navigation.dart';

class PolaroidPage extends StatefulWidget {
  const PolaroidPage({super.key});

  @override
  State<PolaroidPage> createState() => _PolaroidPageState();
}

class _PolaroidPageState extends State<PolaroidPage> {
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
            base64Image: _base64Image!,
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
        title: Text(
          'My Polaroids',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '          ',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Today',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '01.18',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          color: grey04,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: pickImage,
                          icon: Icon(Icons.camera_alt),
                          iconSize: 35,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManyPolaroid()),
                          );
                        },
                        child: Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            color: grey04,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ManyPolaroid()),
                          );
                        },
                        child: Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            color: grey04,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
