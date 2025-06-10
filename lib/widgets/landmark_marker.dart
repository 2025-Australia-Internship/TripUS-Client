import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/models/landmark.dart';

class LandmarkMarker extends StatelessWidget {
  final Landmark landmark;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onCameraTap;

  const LandmarkMarker({
    super.key,
    required this.landmark,
    required this.isSelected,
    required this.onTap,
    required this.onCameraTap,
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
              top: -55,
              right: -40,
              child: Container(
                width: 250,
                height: 90,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/landmark_detail_page',
                          arguments: landmark.id,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            landmark.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: dark08,
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: Text(
                              landmark.address,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff6E6E6E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: light08,
                      child: IconButton(
                        onPressed: onCameraTap,
                        icon: const Icon(Icons.camera_alt, color: light04),
                        iconSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const Icon(Icons.location_pin, color: light02, size: 50),
        ],
      ),
    );
  }
}
