import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/follow_profile.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/widgets/bottom_navigation.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: '친구',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 315,
                height: 45,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MainColor, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MainColor, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: TextButton(
                      onPressed: () {},
                      child: Image.asset(
                        'assets/search.png',
                        width: 22,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 315,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '검색 기록이 없습니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
              SizedBox(
                width: 315,
                child: Divider(
                  thickness: 1,
                  height: 10,
                  color: light06,
                ),
              ),
              Container(
                width: 315,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '추천 친구',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              FollowProfile(
                name: 'Julie',
                image: Image.asset('assets/sample2.png'),
                message: '오늘도 좋은 하루!',
                initialFollow: false,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.friendHome);
                },
              ),
              FollowProfile(
                name: 'Julie',
                image: Image.asset('assets/sample2.png'),
                message: '오늘도 좋은 하루!',
                initialFollow: false,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.friendHome);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 0),
    );
  }
}
