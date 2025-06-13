import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/main.dart';
import 'package:tripus/pages/profile/profile_page.dart';

import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/primary_button.dart';
import 'package:tripus/widgets/profile.dart';
import 'package:tripus/widgets/profile_textfield.dart';

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
      appBar: CustomAppBar(
        text: '프로필 편집',
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            Profile(),
            SizedBox(height: 30),
            SizedBox(
              width: 315,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileTextfield(
                    label: '닉네임',
                    onSuffixPressed: () {
                      //TODO: 아이디 중복 확인
                    },
                    suffixText: '중복확인',
                  ),
                  SizedBox(height: 5),
                  ProfileTextfield(
                    label: '상태 메시지',
                    onSuffixPressed: () {
                      //TODO: 아이디 중복 확인
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
                width: 315,
                child: PrimaryButton(
                  text: '확인',
                  backgroundColor: MainColor,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ProfilePage(),
                      ),
                    );
                  },
                )),
            SizedBox(height: 20)
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 3),
    );
  }
}
