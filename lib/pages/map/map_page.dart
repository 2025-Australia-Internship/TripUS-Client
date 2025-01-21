import 'package:flutter/material.dart';
import 'package:tripus/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/pages/home/home_page.dart';
import 'package:tripus/pages/polaroid/polaroid.dart';
import 'package:tripus/pages/profile/profile.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: SvgPicture.asset('assets/map_icon.svg', color: MainColor),
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
                icon: SvgPicture.asset('assets/myPage_icon.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
