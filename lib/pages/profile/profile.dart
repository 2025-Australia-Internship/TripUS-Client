import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tripus/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:tripus/pages/profile/edit_profile.dart';

import 'package:tripus/pages/home/home_page.dart';
import 'package:tripus/pages/map/map_page.dart';
import 'package:tripus/pages/polaroid/polaroid.dart';

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page Content'),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageStatet();
}

class _ProfilePageStatet extends State<ProfilePage> {
  double _height = 65.00;
  String username = '';
  String email = '';
  String profileImage = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final String apiUrl = '${dotenv.env['BASE_URL']}/user/info';

      const storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'jwt');

      if (accessToken == null) {
        print("access token not found");
        return;
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          username = data['username'];
          email = data['email'];
          profileImage = data['profile_image'];
          isLoading = false;
        });
      } else {
        print('Failed to load profile : ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (error) {
      print('Error loading profile : $error');
      setState(() => isLoading = false);
    }
  }

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
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: profileImage.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(profileImage),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style: TextStyle(
                                    color: dark04,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  email,
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
                icon: SvgPicture.asset('assets/home_icon.svg'),
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
                icon: SvgPicture.asset('assets/myPage_icon.svg',
                    color: MainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
