import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/utils/storage_helper.dart';
import 'package:tripus/services/api_service.dart';

import 'package:tripus/widgets/bottom_navigation.dart';

class PolaroidPage extends StatefulWidget {
  const PolaroidPage({super.key});

  @override
  State<PolaroidPage> createState() => _PolaroidPageState();
}

class _PolaroidPageState extends State<PolaroidPage> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchPolaroids();
  }

  ImageProvider resolveImage(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return AssetImage(imageUrl); // asset 경로일 경우
    } else if (imageUrl.startsWith('data:image')) {
      final base64Str = imageUrl.split(',').last;
      final bytes = base64Decode(base64Str);
      return MemoryImage(bytes);
    } else {
      return NetworkImage(imageUrl);
    }
  }

  Future<void> fetchPolaroids() async {
    try {
      final token = (await StorageHelper.getToken('accessToken'))!;
      final polaroids = await ApiService.getUserPolaroids(token);
      final grouped = groupByDate(polaroids);

      final todayDate = DateTime.now().toIso8601String().substring(0, 10);

      final newItems = <Map<String, dynamic>>[
        {'type': 'camera'},
      ];

      if (grouped.isEmpty || !grouped.containsKey(todayDate)) {
        newItems.add({'type': 'today'});
      }

      newItems.addAll(grouped.entries.map((entry) => {
            'type': 'polaroid',
            'date': entry.key.substring(5), // MM-DD
            'image': entry.value['photo_url'],
          }));

      setState(() {
        items = newItems;
      });
    } catch (e) {
      // fallback items in case of error
      setState(() {
        items = [
          {'type': 'camera'},
          {'type': 'today'},
        ];
      });
    }
  }

  Map<String, Map<String, dynamic>> groupByDate(List polaroids) {
    final Map<String, Map<String, dynamic>> result = {};
    for (final item in polaroids) {
      final createdAt = item['created_at'];
      if (createdAt == null || createdAt is! String) continue;

      final date = createdAt.substring(0, 10);
      if (!result.containsKey(date)) {
        result[date] = item;
      }
    }
    return result;
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('폴라로이드',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 370,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: items.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                    children: items.map((item) {
                      switch (item['type']) {
                        case 'camera':
                          return _buildCameraBox(context);
                        case 'today':
                          return _buildTodayGrayBox();
                        case 'polaroid':
                          return _buildPolaroidItem(
                            context,
                            date: item['date'],
                            imagePath: item['image'],
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    }).toList(),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }

  Widget _buildCameraBox(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: grey04,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.camera_alt, size: 35, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayGrayBox() {
    return Column(
      children: [
        SizedBox(
          height: 18,
          child: Center(
            child: Text(
              'Today',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: dark08,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: grey04,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPolaroidItem(BuildContext context,
      {required String date, required String imagePath}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.manyPolaroid,
          arguments: {'selectedDate': '2025-$date'},
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 18,
            child: Center(
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: dark08,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: resolveImage(imagePath),
                  fit: BoxFit.cover,
                  onError: (e, s) => debugPrint('이미지 로딩 실패: $e'),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
