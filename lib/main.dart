import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tripus/constants/theme.dart';
import 'package:tripus/pages/SplashScreen.dart';

Future<void> main() async {
  // 비동기 실행
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false, // 디버그 배너 제거
      title: 'TripUS',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
