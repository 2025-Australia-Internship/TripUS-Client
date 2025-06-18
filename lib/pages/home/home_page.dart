import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/constants/colors.dart';

import 'package:tripus/widgets/background_button.dart';
import 'package:tripus/widgets/LandmarkBadgeBox.dart';
import 'package:tripus/widgets/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageStatet();
}

class _HomePageStatet extends State<HomePage> {
  String selectedBackground = 'None';

  @override
  void initState() {
    super.initState();
    _loadSelectedBackground(); // SharedPreferences에서 불러오기
  }

  Future<void> _loadSelectedBackground() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedBackground = prefs.getString('background') ?? 'None';
    });
  }

  Future<void> _updateSelectedBackground(String background) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('background', background);
    setState(() {
      selectedBackground = background;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: false, // true로 하면 아래로 당길 때 다시 나타남
            pinned: false, // false면 스크롤 시 완전히 사라짐
            //snap: false,
            expandedHeight: 70, // AppBar 높이 설정
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 10), // 상태바 고려
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width: 39,
                        height: 36,
                        child: SvgPicture.asset(
                          'assets/home/small_logo.svg',
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //   radius: 20,
                          //   backgroundColor: light08,
                          //   child: IconButton(
                          //     onPressed: () {
                          //       Navigator.pushNamed(context, AppRoutes.friend);
                          //     },
                          //     icon: SvgPicture.asset(
                          //       'assets/home/friends.svg',
                          //       width: 20,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: 10),
                          BackgroundButton(
                            onBackgroundSelected: (String background) {
                              _updateSelectedBackground(
                                  background); // 이제 상태+저장 둘 다 처리
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 220,
                        child: Image.asset('assets/home/mascot.png'),
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
                            LandmarkBadgeBox(),
                            // Container(
                            //   width: 315,
                            //   height: 245,
                            //   margin: EdgeInsets.only(top: 20),
                            //   padding: EdgeInsets.all(21),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(12.0),
                            //   ),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         "오늘의 핀",
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.w600,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       GestureDetector(
                            //         onDoubleTap: () {
                            //           Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) => RoutePage()),
                            //           );
                            //         },
                            //         child: Container(
                            //           height: 170,
                            //           margin: EdgeInsets.only(top: 10),
                            //           child: FlutterMap(
                            //             options: MapOptions(
                            //               center:
                            //                   LatLng(-37.8136, 144.9631), // 멜버른
                            //               zoom: 15.0,
                            //             ),
                            //             children: [
                            //               TileLayer(
                            //                 urlTemplate:
                            //                     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            //                 subdomains: [
                            //                   'a',
                            //                   'b',
                            //                   'c'
                            //                 ], // OSM 기본 타일
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              width: 315,
                              height: 245,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                              padding: EdgeInsets.all(21),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "오늘의 사진",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    height: 170,
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 133,
                                          child:
                                              Image.asset('assets/sample1.png'),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 131,
                                              height: 80,
                                              child: Image.asset(
                                                  'assets/sample2.png'),
                                            ),
                                            Container(
                                              width: 131,
                                              height: 80,
                                              color: grey03,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.asset(
                                                      'assets/sample3.png'),
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
                          bottom: 380,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/home/$selectedBackground.png',
                              width: 400,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 0),
    );
  }
}
