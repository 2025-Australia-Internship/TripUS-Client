import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';

class ManyPolaroid extends StatefulWidget {
  const ManyPolaroid({super.key});

  @override
  State<ManyPolaroid> createState() => _ManyPolaroidState();
}

class _ManyPolaroidState extends State<ManyPolaroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: 315,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [grey02, Color(0xff737373)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: dark08,
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 315,
              child: Row(
                children: [
                  Container(
                    width: 105,
                    height: 105,
                    color: grey02,
                  ),
                  Container(
                    width: 105,
                    height: 105,
                    color: grey03,
                  ),
                  Container(
                    width: 105,
                    height: 105,
                    color: grey01,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      iconSize: 25,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
