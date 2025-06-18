import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/polaroid.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/widgets/primary_button.dart';

class EditPolaroid extends StatefulWidget {
  const EditPolaroid({super.key});

  @override
  State<EditPolaroid> createState() => _EditPolaroidState();
}

class _EditPolaroidState extends State<EditPolaroid> {
  Color _color = Colors.white;
  bool _isPublic = true;
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void savePolaroid() {
    // 실제 저장 로직 제거 → 디버깅용 메시지 출력 또는 테스트용 dummy 처리
    print('하드코딩된 폴라로이드 저장: ${_captionController.text}, 공개 여부: $_isPublic');
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
                image: Image.asset('assets/sample1.png'), // 하드코딩 이미지
                color: _color,
                isPublic: _isPublic,
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
      ),
    );
  }
}
