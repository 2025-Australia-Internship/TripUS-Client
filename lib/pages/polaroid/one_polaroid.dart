import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/services/api_service.dart';
import 'package:tripus/utils/storage_helper.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/utils/color_helper.dart';

class SmartImage extends StatelessWidget {
  final String imageSource;
  final double width;
  final double height;

  const SmartImage({
    super.key,
    required this.imageSource,
    this.width = 240,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    if (imageSource.trim().startsWith('data:image/') ||
        RegExp(r'^[A-Za-z0-9+/=]+$').hasMatch(imageSource)) {
      // base64 문자열인 경우
      try {
        final bytes =
            base64.decode(imageSource.replaceAll(RegExp(r'[\n\r\s]'), ''));
        return Image.memory(bytes,
            width: width, height: height, fit: BoxFit.cover);
      } catch (e) {
        return _errorImage();
      }
    } else {
      // 에셋 경로나 URL일 경우
      return Image.asset(imageSource,
          width: width, height: height, fit: BoxFit.cover);
    }
  }

  Widget _errorImage() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Icon(Icons.error, color: Colors.grey),
    );
  }
}

class OnePolaroid extends StatefulWidget {
  final int polaroidId;

  const OnePolaroid({super.key, required this.polaroidId});

  @override
  State<OnePolaroid> createState() => _OnePolaroidState();
}

class _OnePolaroidState extends State<OnePolaroid> {
  Map<String, dynamic>? polaroid;
  String? _debugLog;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final polaroidId = args?['polaroidId'];

    if (polaroidId != null) {
      fetchPolaroid(polaroidId);
    } else {
      setState(() {
        _debugLog = '폴라로이드 ID가 없습니다.';
      });
    }
  }

  Future<void> fetchPolaroid(int id) async {
    try {
      final token = (await StorageHelper.getToken('accessToken'))!;
      final data = await ApiService.getPolaroidById(token, id);
      setState(() {
        polaroid = data;
      });
    } catch (e) {
      setState(() {
        _debugLog = '폴라로이드 불러오기 실패: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = polaroid;

    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        actionIcon: IconButton(
          icon: const Icon(Icons.close_rounded, color: dark08),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.manyPolaroid);
          },
        ),
      ),
      body: Center(
        child: p == null
            ? (_debugLog != null
                ? Text(_debugLog!, style: const TextStyle(color: Colors.red))
                : const CircularProgressIndicator())
            : Container(
                width: 280,
                height: 430,
                decoration: BoxDecoration(
                  color: hexToColor(polaroid!['color']),
                  boxShadow: const [
                    BoxShadow(
                      color: grey02,
                      blurRadius: 5,
                      spreadRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SmartImage(imageSource: p['photo_url']),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 240,
                      child: Text(
                        polaroid!['caption'] ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff666666),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
