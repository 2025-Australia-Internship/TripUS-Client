import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/pages/home/landmarks.dart';
import 'package:tripus/pages/home/routes.dart';
import 'package:tripus/widgets/background_button.dart';

import 'package:tripus/widgets/bottom_navigation.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Padding(
          padding: EdgeInsets.only(left: 30),
          child: SizedBox(
            width: 39,
            height: 36,
            child: SvgPicture.asset(
              'assets/home/small_logo.svg',
            ),
          ),
        ),
        actions: [
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
                      'assets/home/friends.svg',
                      width: 20,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                BackgroundButton(
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
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset('assets/mascot.png'),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 180),
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
                            onDoubleTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RoutePage()),
                              );
                            },
                            child: Container(
                              height: 170,
                              margin: EdgeInsets.only(top: 10),
                              child: FlutterMap(
                                options: MapOptions(
                                  center: LatLng(-37.8136, 144.9631), // 멜버른
                                  zoom: 15.0,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c'], // OSM 기본 타일
                                  ),
                                ],
                              ),
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
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 133,
                                  child: Image.asset('assets/sample1.png'),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 131,
                                      height: 80,
                                      child: Image.asset('assets/sample2.png'),
                                    ),
                                    Container(
                                      width: 131,
                                      height: 80,
                                      color: grey03,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset('assets/sample3.png'),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.more_horiz,
                                                color: grey02),
                                            iconSize: 35,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
              if (selectedBackground != 'None')
                Positioned(
                  bottom: 650,
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
