import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/models/landmark.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/services/landmark/landmark_service.dart';
import 'package:tripus/widgets/small_polaroid.dart';

class LandmarkDetails extends StatefulWidget {
  final int id;

  const LandmarkDetails({super.key, required this.id});

  @override
  State<LandmarkDetails> createState() => _LandmarkDetailsState();
}

class _LandmarkDetailsState extends State<LandmarkDetails> {
  Landmark? landmarkData;
  bool isLoading = true;

  bool isLiked = false;
  bool isBookmarked = false;
  int likeCount = 123;

  final _landmarkService = LandmarkService();

  final Map<String, List<Widget>> mockPolaroids = {
    '2024.12.25': [
      SmallPolaroid(
        text: '호주 박물관 앞',
        image: Image.asset('assets/sample1.png'),
        color: red,
      ),
      SmallPolaroid(
        text: '공원에서 산책',
        image: Image.asset('assets/sample2.png'),
        color: blue,
      ),
    ],
    '2025.01.08': [
      SmallPolaroid(
        text: '나무 아래에서',
        image: Image.asset('assets/sample3.png'),
        color: yellow,
      ),
      SmallPolaroid(
        text: '도서관 앞에서',
        image: Image.asset('assets/sample1.png'),
        color: green,
      ),
      SmallPolaroid(
        text: '카페 안에서',
        image: Image.asset('assets/sample2.png'),
        color: purple,
      ),
      SmallPolaroid(
        text: '카페 안에서',
        image: Image.asset('assets/sample2.png'),
        color: purple,
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    loadLandmarkData();
    _loadStatus();
  }

  Future<void> loadLandmarkData() async {
    try {
      final result = await _landmarkService.getLandmarkById(widget.id);
      setState(() {
        landmarkData = result;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading landmark: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = prefs.getBool('like_${widget.id}') ?? false;
      isBookmarked = prefs.getBool('bookmark_${widget.id}') ?? false;
    });
  }

  Future<void> _saveStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('like_${widget.id}', isLiked);
    await prefs.setBool('bookmark_${widget.id}', isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (landmarkData == null) {
      return const Scaffold(
        body: Center(child: Text('Failed to load data')),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top image
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(landmarkData!.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 10,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  right: 40,
                  child: Image.asset(landmarkData!.symbol),
                ),
              ],
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text content
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 260,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              landmarkData!.name,
                              style: const TextStyle(
                                color: MainColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              landmarkData!.address,
                              style: const TextStyle(
                                color: light05,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              landmarkData!.description,
                              style: const TextStyle(
                                color: dark06,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: isLiked ? error : grey04,
                                size: 22,
                              ),
                              Text(
                                '$likeCount',
                                style: TextStyle(
                                  color: isLiked ? error : grey04,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isBookmarked = !isBookmarked;
                              });
                              _saveStatus();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10), // ← 간격 조절
                              child: Icon(
                                isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: isBookmarked ? MainColor : grey04,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(thickness: 2, color: grey03),
                  const SizedBox(height: 10),
                  const Text(
                    'My memories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),

                  ...mockPolaroids.entries.map((entry) {
                    final date = entry.key;
                    final items = entry.value.take(3).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: MainColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          children: items,
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 1),
    );
  }
}
