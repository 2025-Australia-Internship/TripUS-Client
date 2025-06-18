import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/models/landmark.dart';

class LandmarkMarker extends StatelessWidget {
  final Landmark landmark;
  final bool isSelected;
  final VoidCallback onTap;

  const LandmarkMarker({
    super.key,
    required this.landmark,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (isSelected)
            Positioned(
              bottom: 50,
              left: 0,
              child: GestureDetector(
                // ✅ 전체 박스를 감싸는 GestureDetector
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/landmark_detail_page',
                    arguments: landmark.id,
                  );
                },
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: grey01,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: grey03,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        landmark.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: dark08,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        landmark.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6E6E6E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const Icon(Icons.location_pin, color: light02, size: 50),
        ],
      ),
    );
  }
}
