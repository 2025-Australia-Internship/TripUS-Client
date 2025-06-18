import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PolaroidImage extends StatelessWidget {
  final dynamic imageSource; // File (모바일) or Uint8List (웹)

  const PolaroidImage({super.key, required this.imageSource});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && imageSource is Uint8List) {
      return Image.memory(imageSource, fit: BoxFit.cover);
    } else if (!kIsWeb && imageSource is File) {
      return Image.file(imageSource, fit: BoxFit.cover);
    } else {
      return const Text('이미지 형식 오류');
    }
  }
}
