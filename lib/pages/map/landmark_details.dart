import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/models/landmark.dart';
import 'package:tripus/widgets/custom_appbar.dart';
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
  final _landmarkService = LandmarkService();

  @override
  void initState() {
    super.initState();
    loadLandmarkData();
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(landmarkData!.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 10),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    right: 30,
                    child: Image.asset(
                      landmarkData!.symbol,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 250,
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
                        children: [
                          Column(
                            children: const [
                              Icon(Icons.favorite, color: error, size: 24),
                              Text('123',
                                  style: TextStyle(color: error, fontSize: 10)),
                            ],
                          ),
                          const SizedBox(width: 7),
                          Column(
                            children: const [
                              Icon(Icons.bookmark_border,
                                  color: grey04, size: 24),
                              Text('567', style: TextStyle(fontSize: 10)),
                            ],
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
                  Text(
                    '2025.01.20',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: MainColor),
                  ),
                  const SizedBox(height: 8),
                  SmallPolaroid(
                    text: 'I love Austraila!',
                    image: Image.asset('assets/melbourne_museum.jpg'),
                    color: red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(initialIndex: 1),
    );
  }
}
