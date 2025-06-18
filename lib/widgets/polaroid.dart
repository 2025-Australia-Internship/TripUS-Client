import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class Polaroid extends StatelessWidget {
  final String text;
  final Widget image;
  final Color color;

  const Polaroid({
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
          width: 280,
          height: 430,
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: grey02,
                blurRadius: 5,
                spreadRadius: 3,
                offset: const Offset(2, 2),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          child: Column(
            children: [
              // 이미지를 Widget 그대로 사용
              SizedBox(
                width: 240,
                height: 300,
                child: ClipRRect(
                  child: image,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 235,
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff666666),
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
