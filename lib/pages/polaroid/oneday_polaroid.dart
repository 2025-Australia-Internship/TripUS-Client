import 'package:flutter/material.dart';
import 'package:tripus/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnedayPolaroid extends StatefulWidget {
  const OnedayPolaroid({super.key});

  @override
  State<OnedayPolaroid> createState() => _OnedayPolaroidState();
}

class _OnedayPolaroidState extends State<OnedayPolaroid> {
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
