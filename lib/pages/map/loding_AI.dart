import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/main.dart';
import 'package:tripus/colors.dart';
import 'package:tripus/pages/join/choose_page.dart';

class LodingAiPage extends StatefulWidget {
  const LodingAiPage({super.key});

  @override
  State<LodingAiPage> createState() => _LodingAiPageState();
}

class _LodingAiPageState extends State<LodingAiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/checking_mascot.png'),
            Text(
              'AI is checking the photo',
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
