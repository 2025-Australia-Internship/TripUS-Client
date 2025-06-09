import 'package:flutter/material.dart';
import 'package:tripus/routes/app_routes.dart';

List<Widget> buildBadgeImages(List<String> assetPaths) {
  return assetPaths
      .map((path) => Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Image.asset(path, width: 35),
          ))
      .toList();
}

class LandmarkBadgeBox extends StatelessWidget {
  const LandmarkBadgeBox({super.key});

  @override
  Widget build(BuildContext context) {
    final badgeImages = [
      'assets/badge01.png',
      'assets/badge02.png',
      'assets/badge03.png',
      'assets/badge04.png',
    ];

    return Container(
      width: 315,
      height: 60,
      margin: const EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          const SizedBox(width: 21),
          const Padding(
            padding: EdgeInsets.only(right: 28),
            child: Text(
              '랜드마크',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          ...buildBadgeImages(badgeImages),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.landmark);
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
