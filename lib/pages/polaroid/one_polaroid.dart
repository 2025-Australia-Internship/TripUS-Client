import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';

class OnePolaroid extends StatefulWidget {
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
  State<OnePolaroid> createState() => _OnePolaroidState();
}

class _OnePolaroidState extends State<OnePolaroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Polaroid',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: dark08,
            icon: Icon(Icons.close_rounded),
            iconSize: 25,
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 460,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 이미지 표시
              Container(
                width: 260,
                height: 300,
                decoration: BoxDecoration(
                  color: grey01,
                  image: DecorationImage(
                    image: NetworkImage(widget.photoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // 캡션 표시
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.caption,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
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
