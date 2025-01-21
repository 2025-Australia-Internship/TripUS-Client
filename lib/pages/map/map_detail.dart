import 'package:flutter/material.dart';
import 'package:tripus/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapDetail extends StatefulWidget {
  const MapDetail({super.key});

  @override
  State<MapDetail> createState() => _MapDetailState();
}

class _MapDetailState extends State<MapDetail> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/melbourne_polytechnic.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    right: 30,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: grey02,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Melbourne Polytechnic',
                              style: TextStyle(
                                color: MainColor,
                                fontFamily: 'Pretendard',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Australia, Melbourne 77 St Georges Rd, Preston VIC 3072',
                              style: TextStyle(
                                color: light05,
                                fontFamily: 'Pretendard',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Information of this landmarkInformation of this landmarkInformation of this landmarkInformation of this landmarkInformation of this landmarkInformation of this landmarkInformation of this landmarkInformation of this landmarkInformation of this landmarkInformation of this landmark',
                              style: TextStyle(
                                color: dark06,
                                fontFamily: 'Pretendard',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.favorite,
                                    color: Color(0xffFF5555),
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  '1,234',
                                  style: TextStyle(
                                    color: Color(0xffFF5555),
                                    fontFamily: 'Pretendard',
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 7),
                          SizedBox(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.bookmark_border,
                                    color: grey04,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  '567',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 2, height: 1, color: grey03),
                  SizedBox(height: 10),
                  Text(
                    'My memories',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 13),
                  Text(
                    '2024.12.25',
                    style: TextStyle(
                        color: MainColor,
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 90,
                    height: 140,
                    color: grey02,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 95,
                          color: grey01,
                          margin: EdgeInsets.only(bottom: 5),
                        ),
                        Text(
                          'Today, I am happy:)',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 5,
                              fontWeight: FontWeight.w400),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home_icon.svg',
              width: 24,
              height: 24,
              color:
                  _selectedIndex == 0 ? Color(0xFF0050FF) : Color(0xFFD9D9D9),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/map_icon.svg',
              width: 24,
              height: 24,
              color:
                  _selectedIndex == 1 ? Color(0xFF0050FF) : Color(0xFFD9D9D9),
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/polaroid_icon.svg',
              width: 24,
              height: 24,
              color:
                  _selectedIndex == 2 ? Color(0xFF0050FF) : Color(0xFFD9D9D9),
            ),
            label: 'Polaroid',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/myPage_icon.svg',
              width: 24,
              height: 24,
              color:
                  _selectedIndex == 3 ? Color(0xFF0050FF) : Color(0xFFD9D9D9),
            ),
            label: 'My page',
          ),
        ],
      ),
    );
  }
}
