import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';
import 'package:tripus/pages/polaroid/many_polaroid.dart';
import 'package:tripus/widgets/bottom_navigation.dart';

class PolaroidPage extends StatelessWidget {
  const PolaroidPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mockItems = [
      {'date': '', 'type': 'camera'}, // 첫 번째는 항상 카메라
      {'date': '01.26', 'image': 'assets/sample1.png'},
      {'date': '01.25', 'image': 'assets/sample2.png'},
      {'date': '01.24', 'image': 'assets/sample3.png'},
      {'date': '01.23', 'image': 'assets/sample1.png'},
      {'date': '01.22', 'image': 'assets/sample2.png'},
      {'date': '01.21', 'image': 'assets/sample3.png'},
      {'date': '01.20', 'image': 'assets/sample1.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '폴라로이드',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 370,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85, // 정사각형 비율 보장
              children: mockItems.map((item) {
                if (item['type'] == 'camera') {
                  return _buildCameraBox(context);
                } else {
                  return _buildPolaroidItem(
                    context,
                    date: item['date'],
                    imagePath: item['image'],
                  );
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EditPolaroid()),
        );
      },
      child: Column(
        children: [
          // 날짜 공간을 빈 공간으로 확보 (다른 아이템과 정렬 맞추기)
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

  Widget _buildPolaroidItem(BuildContext context,
      {required String date, required String imagePath}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ManyPolaroid()),
        );
      },
      child: Column(
        children: [
          // 날짜를 위쪽에 가운데 정렬로 배치
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
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
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
