import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';

import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/widgets/custom_appbar.dart';

class Base64ImageWidget extends StatelessWidget {
  final String base64String;
  final double width;
  final double height;
  final BoxFit fit;

  const Base64ImageWidget({
    Key? key,
    required this.base64String,
    this.width = 260.0,
    this.height = 400.0,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (base64String.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Icon(Icons.person, color: Colors.grey[400]),
      );
    }
    try {
      final bytes =
          base64.decode(base64String.replaceAll(RegExp(r'[\n\r\s]'), ''));

      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(bytes),
            fit: fit,
          ),
        ),
      );
    } catch (e) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Icon(Icons.error, color: Colors.grey[400]),
      );
    }
  }
}

class OnePolaroid extends StatelessWidget {
  final String photoUrl;
  final String caption;
  final Color backgroundColor;

  const OnePolaroid({
    Key? key,
    required this.photoUrl,
    required this.caption,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        actionIcon: IconButton(
          icon: const Icon(Icons.close_rounded, color: dark08),
          onPressed: () {
            Navigator.pushNamed(context, '/many_polaroid_page');
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 280,
          height: 430,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: grey02,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Base64ImageWidget(
                base64String: photoUrl,
                width: 240,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 240,
                child: Text(
                  caption,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff666666),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
