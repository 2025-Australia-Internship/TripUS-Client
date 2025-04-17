import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/main.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/pages/polaroid/one_polaroid.dart';

class LodingAiPage extends StatefulWidget {
  final String photoUrl;
  final String caption;
  final Color backgroundColor;
  final VoidCallback onComplete;

  const LodingAiPage({
    Key? key,
    required this.photoUrl,
    required this.caption,
    required this.backgroundColor,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<LodingAiPage> createState() => _LodingAiPageState();
}

class _LodingAiPageState extends State<LodingAiPage> {
  String message = 'AI is checking the photo.';

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

      // 2초 후에 onComplete 콜백 호출
      Timer(Duration(seconds: 2), widget.onComplete);
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
    );
  }
}
