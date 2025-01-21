import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/pages/home/landmarks.dart';
import 'package:tripus/pages/home/routes.dart';

import 'package:tripus/main.dart';
import 'package:tripus/pages/map/map_page.dart';
import 'package:tripus/pages/polaroid/polaroid.dart';
import 'package:tripus/pages/profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageStatet();
}

class _HomePageStatet extends State<HomePage> {
  String selectedBackground = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: SvgPicture.asset('assets/small_logo.svg'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: light08,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'assets/friends.svg',
                                    width: 20,
                                  ),
                                  color: MainColor,
                                ),
                              ),
                              SizedBox(width: 10),
                              CustomButton(
                                onBackgroundSelected: (String background) {
                                  setState(() {
                                    selectedBackground = background;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(top: 50),
                      child: Image.asset('assets/mascot.png'),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 280),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Color(0xFF9DC1FF)],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 315,
                      height: 60,
                      margin: EdgeInsets.only(top: 80),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Padding(
                            padding: EdgeInsets.only(right: 18),
                            child: Text(
                              'Landmark',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/badge01.png',
                            width: 35,
                          ),
                          SizedBox(width: 5),
                          Image.asset(
                            'assets/badge02.png',
                            width: 35,
                          ),
                          SizedBox(width: 5),
                          Image.asset(
                            'assets/badge03.png',
                            width: 35,
                          ),
                          SizedBox(width: 5),
                          Image.asset(
                            'assets/badge04.png',
                            width: 35,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LandmarkPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                            ),
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 315,
                      height: 245,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Pins",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RoutePage()),
                              );
                            },
                            child: Container(
                              height: 170,
                              color: Color(0xFFD9D9D9),
                              margin: EdgeInsets.only(top: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 315,
                      height: 245,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Picture",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            height: 170,
                            color: Color(0xFFD9D9D9),
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (selectedBackground != 'None') // 선택된 배경이 None이 아닐 때만 표시
                Positioned(
                  top: 160,
                  child: Image.asset(
                    'assets/$selectedBackground.png', // 선택된 배경 경로
                    width: 400,
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 0),
    );
  }
}

// 팝업창 구현
class CustomButton extends StatelessWidget {
  final Function(String) onBackgroundSelected;

  const CustomButton({super.key, required this.onBackgroundSelected});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: light08,
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackgroundSelectionDialog(
                onBackgroundSelected: onBackgroundSelected,
              );
            },
          );
        },
        icon: SvgPicture.asset(
          'assets/edit.svg',
          width: 20,
        ),
      ),
    );
  }
}

class BackgroundSelectionDialog extends StatefulWidget {
  final Function(String) onBackgroundSelected;

  const BackgroundSelectionDialog(
      {super.key, required this.onBackgroundSelected});

  @override
  State<BackgroundSelectionDialog> createState() =>
      _BackgroundSelectionDialogState();
}

class _BackgroundSelectionDialogState extends State<BackgroundSelectionDialog> {
  String? selectedBackground;

  final List<BackgroundOption> backgrounds = [
    BackgroundOption(name: 'None', icon: 'assets/none_icon.png'),
    BackgroundOption(name: 'Forest', icon: 'assets/forest_icon.png'),
    BackgroundOption(name: 'Flower', icon: 'assets/flower_icon.png'),
    BackgroundOption(name: 'Spring', icon: 'assets/spring_icon.png'),
    BackgroundOption(name: 'Stars', icon: 'assets/stars_icon.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 315,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 48),
                  Text(
                    'Background',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Wrap(
                spacing: 5,
                runSpacing: 10,
                children: backgrounds
                    .map((background) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBackground = background.name;
                            });
                            widget.onBackgroundSelected(background.name);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 90,
                            height: 115,
                            decoration: BoxDecoration(
                              color: selectedBackground == background.name
                                  ? grey01
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Image.asset(
                                  background.icon,
                                  width: 65,
                                  height: 65,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  background.name,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundOption {
  final String name;
  final String icon;

  BackgroundOption({
    required this.name,
    required this.icon,
  });
}
