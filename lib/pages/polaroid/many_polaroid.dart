import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/widgets/bottom_navigation.dart';

class ManyPolaroid extends StatefulWidget {
  final String? selectedDate;

  const ManyPolaroid({super.key, this.selectedDate});

  @override
  State<ManyPolaroid> createState() => _ManyPolaroidState();
}

class _ManyPolaroidState extends State<ManyPolaroid> {
  final List<String> dummyPolaroids = [
    'assets/sample1.png',
    'assets/sample2.png',
    'assets/sample3.png',
    'assets/sample1.png',
  ];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        Navigator.pushNamed(context, AppRoutes.editPolaroid, arguments: bytes);
      } else {
        final file = File(picked.path);
        Navigator.pushNamed(context, AppRoutes.editPolaroid, arguments: file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayDate =
        widget.selectedDate ?? DateFormat('MM.dd').format(DateTime.now());

    final polaroidWidgets = dummyPolaroids.map((path) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/one_polaroid_page', arguments: {
            'photoUrl': '', // base64 string 또는 API 연동 필요
            'caption': '설명 텍스트',
            'backgroundColor': 'ffffffff',
          });
        },
        child: Container(
          width: 105,
          height: 105,
          decoration: BoxDecoration(
            color: grey02,
            image: DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }).toList();

    polaroidWidgets.add(
      GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: 105,
          height: 105,
          decoration: const BoxDecoration(
            color: grey01,
          ),
          child: const Icon(Icons.add, size: 30, color: dark08),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              width: 315,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [grey02, Color(0xff737373)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/polaroid_page');
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: dark08,
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 20,
                    child: Text(
                      displayDate,
                      style: const TextStyle(
                        fontSize: 20,
                        color: dark08,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 315,
              child: Wrap(
                children: polaroidWidgets,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
