import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Duration splashDuration = Duration(seconds: 3); // 3초 뒤 화면 전환

  @override
  void initState() {
    super.initState();
    Future.delayed(splashDuration, () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.auth);
      }
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
