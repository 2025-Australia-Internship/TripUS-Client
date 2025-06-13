import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class ProfileBox extends StatelessWidget {
  final String name;
  final Image image;
  final String message;

  const ProfileBox({
    super.key,
    required this.name,
    required this.image,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipOval(
                    child: Image(
                      image: image.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6e6e6e),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
