import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/profile_Box.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/widgets/small_polaroid.dart';

List<Widget> buildBadgeImages(List<String> assetPaths) {
  return assetPaths
      .map((path) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset(path, width: 35),
          ))
      .toList();
}

class FriendHomePage extends StatefulWidget {
  const FriendHomePage({super.key});

  @override
  State<FriendHomePage> createState() => _FriendHomePageState();
}

class _FriendHomePageState extends State<FriendHomePage> {
  bool isFollow = false;

  void toggleFollow() {
    setState(() {
      isFollow = !isFollow;
    });
  }

  @override
  Widget build(BuildContext context) {
    final badgeImages = [
      'assets/badge01.png',
      'assets/badge02.png',
      'assets/badge03.png',
      'assets/badge04.png',
    ];

    return Scaffold(
      appBar: CustomAppBar(
        text: '친구',
      ),
      body: Center(
        child: Column(
          children: [
            ProfileBox(
              name: 'Julie',
              image: Image.asset('assets/sample2.png'),
              message: '오늘도 좋은 하루!',
            ),
            Container(
              width: 315,
              margin: EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                onPressed: toggleFollow,
                style: TextButton.styleFrom(
                  backgroundColor: isFollow ? Colors.white : MainColor,
                  side: BorderSide(color: MainColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                ),
                child: Text(
                  isFollow ? '팔로우' : '팔로잉',
                  style: TextStyle(
                    color: isFollow ? dark08 : Colors.white,
                  ),
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
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: buildBadgeImages(badgeImages),
              ),
            ),
            Text(
              '2025.01.20',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: dark08),
            ),
            const SizedBox(height: 8),
            SmallPolaroid(
              text: 'I love Austraila!',
              image: Image.asset('assets/melbourne_museum.jpg'),
              color: red,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 0),
    );
  }
}
