import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:tripus/constants/colors.dart';
import 'package:tripus/pages/home/home_page.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/pages/join/signup_success.dart';
import 'package:tripus/widgets/active_button.dart';
import 'package:tripus/widgets/close_icon_button.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/profile.dart';

import 'package:tripus/routes/app_routes.dart';

class SignupPasswordPage extends StatefulWidget {
  const SignupPasswordPage({super.key});

  @override
  State<SignupPasswordPage> createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _base64Image;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height; // AppBar 높이를 계산

    // 화면 전체 높이에서 AppBar와 SafeArea를 제외
    final bodyHeight = MediaQuery.of(context).size.height -
        appBarHeight -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: CustomAppBar(
        text: '회원가입',
        actionIcon: CloseIconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.signupSuccess);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: bodyHeight,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 40),
              Profile(
                width: 100,
                height: 100,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 315,
                child: Column(
                  children: [
                    CommonTextfield(
                      label: '닉네임을 입력해주세요',
                      controller: _textController,
                      onSuffixPressed: () {
                        //TODO: 아이디 중복 확인
                      },
                      suffixText: '중복확인',
                    ),
                    CommonTextfield(
                      label: '비밀번호를 입력해주세요',
                      controller: _passwordController,
                    ),
                    CommonTextfield(
                      label: '비밀번호를 다시 입력해주세요',
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: 315,
                child: ActiveButton(
                  text: '다음으로',
                  onPressed: () {
                    //TODO: 아이디 중복 확인 및 비밀번호 확인
                  },
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
