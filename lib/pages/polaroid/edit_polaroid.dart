import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/polaroid.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/widgets/primary_button.dart';

class EditPolaroid extends StatefulWidget {
  final dynamic imageSource; // File or Uint8List

  const EditPolaroid({super.key, required this.imageSource});

  @override
  State<EditPolaroid> createState() => _EditPolaroidState();
}

class _EditPolaroidState extends State<EditPolaroid> {
  Color _color = Colors.white;
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void savePolaroid() {
    print('폴라로이드 저장: ${_captionController.text}, 색상: $_color');
    // TODO: 이미지 + 텍스트 + 색상 -> 서버 전송
  }

  Widget buildImage() {
    if (kIsWeb && widget.imageSource is Uint8List) {
      return Image.memory(widget.imageSource, fit: BoxFit.cover);
    } else if (!kIsWeb && widget.imageSource is File) {
      return Image.file(widget.imageSource, fit: BoxFit.cover);
    } else {
      return const Text('이미지를 불러올 수 없습니다');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: '폴라로이드'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 25),
              Polaroid(
                text: _captionController.text.isEmpty
                    ? '텍스트를 입력해주세요.'
                    : _captionController.text,
                image: buildImage(),
                color: _color,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorCircle(const Color(0xffFF6D6D)),
                    _buildColorCircle(const Color(0xffFFCB71)),
                    _buildColorCircle(const Color(0xffFDFF72)),
                    _buildColorCircle(const Color(0xff9BFF76)),
                    _buildColorCircle(const Color(0xff8DE8FF)),
                    _buildColorCircle(const Color(0xffCE7BFF)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 315,
                child: PrimaryButton(
                  text: '폴라로이드 제작하기',
                  backgroundColor: MainColor,
                  color: Colors.white,
                  onPressed: savePolaroid,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }

  Widget _buildColorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _color = (_color != color) ? color : Colors.white;
        });
      },
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: _color == color
            ? const Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}
