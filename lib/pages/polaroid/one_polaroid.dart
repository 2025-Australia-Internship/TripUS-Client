import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/services/api_service.dart';
import 'package:tripus/utils/storage_helper.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/utils/color_helper.dart';

class Base64ImageWidget extends StatelessWidget {
  final String base64String;
  final double width;
  final double height;
  final BoxFit fit;

  const Base64ImageWidget({
    Key? key,
    required this.base64String,
    this.width = 260.0,
    this.height = 400.0,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (base64String.isEmpty) {
      return _errorBox();
    }

    // 만약 URL이면 network로 처리
    if (base64String.startsWith('http')) {
      return Image.network(
        base64String,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _errorBox(),
      );
    }

    try {
      final bytes = base64.decode(
        base64String.replaceAll(RegExp(r'data:image/[^;]+;base64,'), ''),
      );

      return Image.memory(
        bytes,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _errorBox(),
      );
    } catch (_) {
      return _errorBox();
    }
  }

  Widget _errorBox() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Icon(Icons.error, color: Colors.grey[400]),
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
        child: polaroid == null
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
                    Base64ImageWidget(
                      base64String: polaroid!['photo_url'],
                      width: 240,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
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
