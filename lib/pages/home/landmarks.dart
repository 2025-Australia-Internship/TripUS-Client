import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';

class LandmarkPage extends StatelessWidget {
  LandmarkPage({super.key});

  // 이미지 데이터
  final List<LandmarkOption> landmarks = [
    LandmarkOption(name: 'Landmark 1', icon: 'assets/landmark1.png'),
    LandmarkOption(name: 'Landmark 2', icon: 'assets/landmark2.png'),
    LandmarkOption(name: 'Landmark 3', icon: 'assets/landmark3.png'),
    LandmarkOption(name: 'Landmark 4', icon: 'assets/landmark4.png'),
    LandmarkOption(name: 'Landmark 5', icon: 'assets/landmark5.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Landmark',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: dark08,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Wrap(
          spacing: 10, // 가로 간격
          runSpacing: 15, // 세로 간격
          alignment: WrapAlignment.center,
          children: landmarks.map((landmark) {
            return LandmarkCard(
              name: landmark.name,
              iconPath: landmark.icon,
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
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
            width: 65,
            height: 65,
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
