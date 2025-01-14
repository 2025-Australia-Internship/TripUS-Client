import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripUS',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF0050FF)), // 일반 텍스트
          bodyMedium: TextStyle(color: Colors.black), // 보조 텍스트
          titleLarge: TextStyle(
              color: Color(0xFF0050FF), fontWeight: FontWeight.bold), // 제목
        ),
        iconTheme: IconThemeData(color: Color(0xFFCDE0FF), size: 30),
      ),
      home: const HomePage(title: 'HOME'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageStatet();
}

class _HomePageStatet extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Text('Home Page'),
    Text('Map Page'),
    Text('Polaroid Page'),
    Text('My Page'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _pages[_selectedIndex],
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'LOGO',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            onPressed: () {
                              print('star button is clicked');
                            },
                            icon: Icon(Icons.account_circle),
                            iconSize: 35.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 123,
                      height: 144,
                      color: Colors.black12,
                      margin: EdgeInsets.only(top: 70),
                    ),
                    SizedBox(height: 40),
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
                      height: 58,
                      margin: EdgeInsets.only(top: 80),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(children: [
                        Text(
                          'Landmark',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          width: 30.0,
                          height: 30.0,
                          margin: EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                            color: Color(0xFFCDE0FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 30.0,
                          height: 30.0,
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFCDE0FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 30.0,
                          height: 30.0,
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFCDE0FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 30.0,
                          height: 30.0,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFCDE0FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ]),
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
                          Container(
                            height: 170,
                            color: Color(0xFFD9D9D9),
                            margin: EdgeInsets.only(top: 10),
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
