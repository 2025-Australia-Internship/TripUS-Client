import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';

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
              SizedBox(height: 30),
              Container(
                width: 300,
                height: 460,
                decoration: BoxDecoration(
                  color: _color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      spreadRadius: 3,
                      offset: Offset(3, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Container(
                        height: 300,
                        color: grey01,
                        child: Image.file(
                          widget.selectedImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _captionController,
                        decoration: InputDecoration(
                          hintText: 'Write your comment here',
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
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
              Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    // AI 분석 기능 구현
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
              SizedBox(height: 20),
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
}
