import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripus/constants/colors.dart';

class Profile extends StatefulWidget {
  final int width;
  final int height;

  const Profile({
    super.key,
    this.width = 100,
    this.height = 100,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: widget.width.toDouble(),
          height: widget.height.toDouble(),
          decoration: BoxDecoration(
            color: light05,
            shape: BoxShape.circle,
            image: _selectedImage != null
                ? DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        Positioned(
          bottom: -1,
          right: -3,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: grey02,
            child: IconButton(
              onPressed: pickImage,
              icon: Icon(Icons.camera_alt),
              color: MainColor,
              iconSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
