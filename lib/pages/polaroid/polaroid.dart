import 'package:flutter/material.dart';
import 'package:tripus/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/pages/polaroid/oneday_polaroid.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';

class PolaroidPage extends StatefulWidget {
  const PolaroidPage({super.key});

  @override
  State<PolaroidPage> createState() => _PolaroidPageState();
}

class _PolaroidPageState extends State<PolaroidPage> {
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
          children: [
            SizedBox(height: 30),
            Text(
              'My Polaroids',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '          ',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Today',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '01.18',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          color: gray04,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const EditPolaroid(),
                              ),
                            );
                          },
                          icon: Icon(Icons.camera_alt),
                          iconSize: 35,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnedayPolaroid()),
                          );
                        },
                        child: Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            color: gray04,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnedayPolaroid()),
                          );
                        },
                        child: Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            color: gray04,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
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
