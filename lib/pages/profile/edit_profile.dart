import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/main.dart';
import 'package:tripus/pages/profile/profile_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageStatet();
}

class _EditProfilePageStatet extends State<EditProfilePage> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: light05,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.camera_alt),
                color: MainColor,
                iconSize: 30,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 315,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nickname',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: dark04,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: light09,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: light09),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/Check.svg',
                            width: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Comment',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: dark04,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: light09,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: light09),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: 315,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const ProfilePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: MainColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 3),
    );
  }
}
