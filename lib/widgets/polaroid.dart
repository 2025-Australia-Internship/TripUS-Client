import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripus/constants/colors.dart';

class Polaroid extends StatelessWidget {
  final String text;
  final Image image;
  final Color color;
  final bool isPublic;

  const Polaroid({
    super.key,
    required this.text,
    required this.image,
    required this.color,
    this.isPublic = true,
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
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          child: Column(
            children: [
              Image(
                image: image.image,
                fit: BoxFit.cover,
                width: 240,
                height: 300,
              ),
              SizedBox(height: 10),
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
        Positioned(
          bottom: 20,
          right: 20,
          child: SvgPicture.asset(
            'assets/open_eye.svg',
            width: 26,
          ),
        ),
      ],
    );
  }
}
