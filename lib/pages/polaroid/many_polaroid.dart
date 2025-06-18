import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/services/api_service.dart';
import 'package:tripus/utils/storage_helper.dart';
import 'package:tripus/widgets/bottom_navigation.dart';

Widget _buildPolaroidImage(String source) {
  final isBase64 = source.startsWith('data:image/') ||
      (source.length > 100 && !source.contains('/')); // 에셋이 아님을 보다 명확히 체크

  if (isBase64) {
    try {
      final base64Str =
          source.replaceAll(RegExp(r'^data:image/[^;]+;base64,'), '');
      final bytes = base64.decode(base64Str);
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          bytes,
          width: 105,
          height: 105,
          fit: BoxFit.cover,
        ),
      );
    } catch (e) {
      return _errorBox();
    }
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        source,
        width: 105,
        height: 105,
        fit: BoxFit.cover,
      ),
    );
  }
}

Widget _errorBox() {
  return Container(
    width: 105,
    height: 105,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Icon(Icons.error, color: Colors.grey),
  );
}

class ManyPolaroid extends StatefulWidget {
  final String? selectedDate;

  const ManyPolaroid({super.key, this.selectedDate});

  @override
  State<ManyPolaroid> createState() => _ManyPolaroidState();
}

class _ManyPolaroidState extends State<ManyPolaroid> {
  List<Map<String, dynamic>> allPolaroids = [];
  String? selectedDate;
  String? _debugLog;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // arguments에서 date 받아오기
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final argDate = args?['selectedDate'] as String?;

    setState(() {
      selectedDate = argDate ??
          widget.selectedDate ??
          DateFormat('yyyy-MM-dd').format(DateTime.now());
    });

    _fetchPolaroids();
  }

  @override
  void initState() {
    super.initState();
    selectedDate =
        widget.selectedDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fetchPolaroids();
  }

  Future<void> _fetchPolaroids() async {
    try {
      final token = (await StorageHelper.getToken('accessToken'))!;
      final result = await ApiService.getMyPolaroids(token);
      setState(() {
        allPolaroids = List<Map<String, dynamic>>.from(result);
      });
    } catch (e) {
      setState(() {
        _debugLog = '불러오기 실패: $e';
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        Navigator.pushNamed(context, AppRoutes.editPolaroid, arguments: bytes);
      } else {
        final file = File(picked.path);
        Navigator.pushNamed(context, AppRoutes.editPolaroid, arguments: file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayDate =
        DateFormat('MM.dd').format(DateTime.parse(selectedDate!));

    final filtered = allPolaroids.where((e) {
      try {
        final createdAt = DateTime.parse(e['created_at']);
        return DateFormat('yyyy-MM-dd').format(createdAt) == selectedDate;
      } catch (_) {
        return false;
      }
    }).toList();

    final latest = allPolaroids.isNotEmpty ? allPolaroids.last : null;

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 315,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [grey02, Color(0xff737373)],
                  ),
                ),
                child: Stack(
                  children: [
                    if (latest != null)
                      Positioned.fill(
                        child: ClipRRect(
                          child: Opacity(
                            opacity: 0.3,
                            child: _buildPolaroidImage(latest['photo_url']),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.polaroid);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        color: dark08,
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 20,
                      child: Text(
                        displayDate,
                        style: const TextStyle(fontSize: 20, color: dark08),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 315,
                child: Wrap(
                  children: [
                    for (var item in filtered)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.onePolaroid,
                            arguments: {'polaroidId': item['id']},
                          );
                        },
                        child: _buildPolaroidImage(item['photo_url']),
                      ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 105,
                        height: 105,
                        decoration: const BoxDecoration(
                          color: grey01,
                        ),
                        child: const Icon(Icons.add, size: 30, color: dark08),
                      ),
                    ),
                  ],
                ),
              ),
              if (_debugLog != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(_debugLog!,
                      style: const TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
