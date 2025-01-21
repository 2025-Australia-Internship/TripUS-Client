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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
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
                              CustomButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(top: 40),
                          child: Image.asset('assets/mascot.png'),
                        ),
                        Positioned(
                          bottom: -50,
                          child: Image.asset(
                            'assets/forest.png',
                            width: 396,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
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
                      margin: EdgeInsets.only(top: 90),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text(
                              'Landmark',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/badge01.svg',
                            width: 35,
                          ),
                          SizedBox(width: 5),
                          SvgPicture.asset(
                            'assets/badge02.svg',
                            width: 35,
                          ),
                          SizedBox(width: 5),
                          SvgPicture.asset(
                            'assets/badge03.svg',
                            width: 35,
                          ),
                          SizedBox(width: 5),
                          SvgPicture.asset(
                            'assets/badge01.svg',
                            width: 35,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LandmarkPage(),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 85,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage(),
                    ),
                  );
                },
                icon:
                    SvgPicture.asset('assets/home_icon.svg', color: MainColor),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const MapPage(),
                    ),
                  );
                },
                icon: SvgPicture.asset('assets/map_icon.svg'),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const PolaroidPage(),
                    ),
                  );
                },
                icon: SvgPicture.asset('assets/polaroid_icon.svg'),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const ProfilePage(),
                    ),
                  );
                },
                icon: SvgPicture.asset('assets/myPage_icon.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 팝업창 구현
class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

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
              return Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: 315,
                  height: 445,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 90),
                              child: Text(
                                'Background',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: grey02,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Landmark',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
