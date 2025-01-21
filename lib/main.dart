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

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 85,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIcon(context, 'assets/home_icon.svg', const HomePage()),
            _buildIcon(context, 'assets/map_icon.svg', const MapPage()),
            _buildIcon(
                context, 'assets/polaroid_icon.svg', const PolaroidPage()),
            _buildIcon(context, 'assets/myPage_icon.svg', const ProfilePage()),
          ],
        ),
      ),
    );
  }

  IconButton _buildIcon(BuildContext context, String iconPath, Widget page) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => page),
        );
      },
      icon: SvgPicture.asset(
        iconPath,
        color: MainColor,
      ),
    );
  }
}
