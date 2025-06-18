import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class SmallPolaroid extends StatelessWidget {
  final String text;
  final Image image;
  final Color color;

  const SmallPolaroid({
    super.key,
    required this.text,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
            color: color,
          ),
        ),
        Positioned(
          top: 6,
          child: Column(
            children: [
              Image(
                image: image.image,
                fit: BoxFit.cover,
                width: 86,
                height: 110,
              ),
              SizedBox(height: 3),
              SizedBox(
                width: 86,
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: dark08,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
