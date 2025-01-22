import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';
import 'package:tripus/pages/map/loding_AI.dart';

class EditPolaroid extends StatefulWidget {
  final File selectedImage;
  final String base64Image; // Base64로 인코딩된 이미지 데이터

  const EditPolaroid({
    Key? key,
    required this.selectedImage,
    required this.base64Image,
  }) : super(key: key);

  @override
  State<EditPolaroid> createState() => _EditPolaroidState();
}

class _EditPolaroidState extends State<EditPolaroid> {
  Color _color = Colors.white;
  TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Polaroid',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: 320,
                height: 450,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: _color,
                  boxShadow: [
                    BoxShadow(
                      color: grey02,
                      blurRadius: 5,
                      spreadRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 260,
                        height: 300,
                        color: grey01,
                        child: Image.file(
                          widget.selectedImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: TextField(
                        controller: _captionController,
                        decoration: InputDecoration(
                          hintText: 'Write your comment here',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorCircle(Color(0xffFF6D6D)),
                    _buildColorCircle(Color(0xffFFCB71)),
                    _buildColorCircle(Color(0xffFDFF72)),
                    _buildColorCircle(Color(0xff9BFF76)),
                    _buildColorCircle(Color(0xff8DE8FF)),
                    _buildColorCircle(Color(0xffCE7BFF)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 320,
                child: ElevatedButton(
                  onPressed: () async {
                    // TODO : AI 분석 기능 구현
                    bool isSuccess = await savePolaroid();

                    if (isSuccess) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LodingAiPage(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF246BFD),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Get AI Analyze',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
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
        radius: 20, // 크기를 줄임
        backgroundColor: color,
      ),
    );
  }

  Future<bool> savePolaroid() async {
    final apiUrl = "${dotenv.env['BASE_URL']}/polaroids";

    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'jwt');

    if (accessToken == null) {
      print("Access token not found");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed. Please log in again.')),
      );
      return false;
    }

    try {
      // 색상 값 변환
      String formattedColor =
          '#${_color.value.toRadixString(16).substring(2).toUpperCase()}';

      // 요청 데이터 생성
      final Map<String, dynamic> polaroidData = {
        'photo_url': widget.base64Image, // Base64 이미지 데이터
        'caption': _captionController.text,
        'color':
            '#${_color.value.toRadixString(16).substring(2).toUpperCase()}',
      };

      // 요청 데이터 확인
      print("Request Data: $polaroidData");

      // POST 요청
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken', // JWT 토큰
          'Content-Type': 'application/json',
        },
        body: jsonEncode(polaroidData),
      );

      if (response.statusCode == 201) {
        print('Polaroid saved successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Polaroid saved successfully!')),
        );
        return true;
      } else {
        print('Failed to save Polaroid: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save Polaroid.')),
        );
        return false;
      }
    } catch (error) {
      print('Error saving Polaroid: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while saving Polaroid.')),
      );
      return false;
    }
  }
}
