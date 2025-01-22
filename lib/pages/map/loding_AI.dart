import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/main.dart';
import 'package:tripus/colors.dart';
import 'package:tripus/pages/polaroid/one_polaroid.dart';

class LodingAiPage extends StatefulWidget {
  const LodingAiPage({super.key});

  @override
  State<LodingAiPage> createState() => _LodingAiPageState();
}

class _LodingAiPageState extends State<LodingAiPage> {
  String message = 'AI is checking the photo.'; // 초기 문구

  @override
  void initState() {
    super.initState();
    _startProcess();
  }

  void _startProcess() {
    // 3초 후에 문구를 변경
    Timer(Duration(seconds: 3), () {
      setState(() {
        message = 'Polaroid has been created.';
      });

      // 2초 후에 OnePolaroid 페이지로 이동
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnePolaroid()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/checking_mascot.png'),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 1),
    );
  }
}
