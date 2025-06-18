import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripus/constants/colors.dart';

class Profile extends StatefulWidget {
  final int width;
  final int height;
  final void Function(String base64Image)? onImageSelected;

  const Profile({
    super.key,
    this.width = 100,
    this.height = 100,
    this.onImageSelected,
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
      final bytes = await pickedFile.readAsBytes(); // 바이트 읽기
      final base64Image = base64Encode(bytes); // base64 인코딩

      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      if (widget.onImageSelected != null) {
        widget.onImageSelected!(base64Image); // 콜백 실행
      }
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
