import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class Polaroid extends StatelessWidget {
  final Widget image;
  final Color color;
  final TextEditingController captionController;

  const Polaroid({
    super.key,
    required this.image,
    required this.color,
    required this.captionController,
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
              SizedBox(
                width: 240,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: image,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 235,
                child: TextField(
                  controller: captionController,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff666666),
                  ),
                  decoration: const InputDecoration(
                    hintText: '텍스트를 입력해주세요.',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
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
