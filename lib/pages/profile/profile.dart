import 'package:flutter/material.dart';
import 'package:tripus/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/pages/profile/edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageStatet();
}

class _ProfilePageStatet extends State<ProfilePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  double _height = 65.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
              ),
              Container(
                width: 315,
                height: 96,
                margin: EdgeInsets.only(top: 30, bottom: 15),
                decoration: BoxDecoration(
                  color: light08,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AU-COS',
                            style: TextStyle(
                              color: dark04,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'example@example.com',
                            style: TextStyle(
                              color: Color(0xff909EB4),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const EditProfilePage(),
                          ),
                        );
                      },
                      icon: SvgPicture.asset('assets/edit_profile.svg'),
                    ),
                  ],
                ),
              ),
              Container(
                width: 315,
                height: _height,
                padding: EdgeInsets.only(left: 20, top: 7),
                decoration: BoxDecoration(
                  color: light09,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/bookmark.svg',
                                color: dark04,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Bookmark',
                                style: TextStyle(
                                  color: dark04,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (_height != 355) {
                                  _height = 355;
                                } else {
                                  _height = 65;
                                }
                              });
                            },
                            icon: Icon(Icons.keyboard_arrow_down_rounded))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 315,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 15, bottom: 30),
                decoration: BoxDecoration(
                  color: light09,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: dark04,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Language',
                          style: TextStyle(
                            color: dark04,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 17),
                    Divider(thickness: 1, height: 1, color: light05),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '한국어',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '로그아웃',
                style: TextStyle(
                  color: Color(0xffFF5555),
                  fontFamily: 'Pretendard',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
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
