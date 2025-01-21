import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripus/colors.dart';

import 'package:tripus/pages/join/choose_page.dart';

import 'package:tripus/pages/home/home_page.dart';
import 'package:tripus/pages/map/map_page.dart';
import 'package:tripus/pages/polaroid/polaroid.dart';
import 'package:tripus/pages/profile/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      theme: ThemeData(
        primaryColor: MainColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Pretendard',
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // 3초 뒤 화면 전환
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChoosePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: MainColor,
        child: SvgPicture.asset(
          'assets/Logo.svg',
          width: 300,
        ),
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  final int initialIndex;

  const BottomNavigation({
    Key? key,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MapPage(),
    PolaroidPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // 초기 인덱스 설정
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 85,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIcon(context, 0, 'assets/home_icon.svg'),
            _buildIcon(context, 1, 'assets/map_icon.svg'),
            _buildIcon(context, 2, 'assets/polaroid_icon.svg'),
            _buildIcon(context, 3, 'assets/myPage_icon.svg'),
          ],
        ),
      ),
    );
  }

  IconButton _buildIcon(BuildContext context, int index, String iconPath) {
    return IconButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => _pages[index]),
        );
      },
      icon: SvgPicture.asset(
        iconPath,
        color: _selectedIndex == index ? MainColor : grey02,
      ),
    );
  }
}
