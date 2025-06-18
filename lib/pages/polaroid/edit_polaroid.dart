import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/pages/map/loding_AI.dart';
import 'package:tripus/pages/polaroid/one_polaroid.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/polaroid.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/widgets/primary_button.dart';

class EditPolaroid extends StatefulWidget {
  final File selectedImage;

  const EditPolaroid({
    Key? key,
    required this.selectedImage,
  }) : super(key: key);

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

  Future<void> savePolaroid() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'jwt');

    if (accessToken == null) {
      print("Access token not found");
      return;
    }

    try {
      final String base64Image =
          base64Encode(await widget.selectedImage.readAsBytes());

      final Map<String, dynamic> polaroidData = {
        'photo_url': base64Image,
        'caption': _captionController.text,
        'color': '#${_color.value.toRadixString(16).padLeft(8, '0')}',
      };

      final response = await http.post(
        Uri.parse("${dotenv.env['BASE_URL']}/polaroids"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(polaroidData),
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final int polaroidId = responseBody['id'];

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LodingAiPage(
              photoUrl: base64Image,
              caption: _captionController.text,
              backgroundColor: _color,
              onComplete: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnePolaroid(
                      polaroidId: polaroidId,
                      photoUrl: base64Image,
                      caption: _captionController.text,
                      backgroundColor: _color,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        print('Failed to save Polaroid: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save Polaroid.')),
        );
      }
    } catch (error) {
      print('Error saving Polaroid: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred while saving Polaroid.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: '폴라로이드',
      ),
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
                image: Image.file(widget.selectedImage),
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
