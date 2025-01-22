import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';
import 'package:tripus/pages/polaroid/many_polaroid.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';
import 'package:tripus/pages/polaroid/one_polaroid.dart';

class PolaroidPage extends StatefulWidget {
  const PolaroidPage({super.key});

  @override
  State<PolaroidPage> createState() => _PolaroidPageState();
}

class _PolaroidPageState extends State<PolaroidPage> {
  final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImage() async {
  //   try {
  //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //     if (image != null) {
  //       // 이미지가 선택되면 EditPolaroid 페이지로 이동
  //       if (mounted) {
  //         // context 사용 전에 위젯이 여전히 트리에 마운트되어 있는지 확인
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (BuildContext context) => EditPolaroid(
  //               selectedImage: File(image.path), // EditPolaroid에 선택된 이미지 전달
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     print('이미지 선택 중 오류 발생: $e');
  //   }
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              'My Polaroids',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
                          //onPressed: _pickImage,
                          onPressed: () {},
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
                                builder: (context) => OnePolaroid()),
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
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
