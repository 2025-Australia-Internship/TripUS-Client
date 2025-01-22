import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';

class OnePolaroid extends StatefulWidget {
  const OnePolaroid({super.key});

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
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: grey02,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              width: 260,
              height: 300,
              color: grey01,
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
