import 'package:flutter/material.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/main.dart';

class LandmarkPage extends StatelessWidget {
  LandmarkPage({super.key});

  // 이미지 데이터
  final List<LandmarkOption> landmarks = [
    LandmarkOption(name: 'Melbourne Polytechnic', icon: 'assets/badge01.png'),
    LandmarkOption(name: 'Melbourne museum', icon: 'assets/badge02.png'),
    LandmarkOption(name: 'Melbourne Park', icon: 'assets/badge03.png'),
    LandmarkOption(name: 'Landmark', icon: 'assets/badge04.png'),
    LandmarkOption(
        name: 'National Gallery of Victoria', icon: 'assets/badge05.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Landmark',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: dark08,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(
        heightFactor: 1.1,
        child: Wrap(
          spacing: 30,
          runSpacing: 30,
          alignment: WrapAlignment.start,
          children: landmarks.map((landmark) {
            return LandmarkCard(
              name: landmark.name,
              iconPath: landmark.icon,
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 0),
    );
  }
}

class LandmarkOption {
  final String name;
  final String icon;

  LandmarkOption({
    required this.name,
    required this.icon,
  });
}

class LandmarkCard extends StatelessWidget {
  final String name;
  final String iconPath;

  const LandmarkCard({
    Key? key,
    required this.name,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // 카드 폭
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 85,
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
