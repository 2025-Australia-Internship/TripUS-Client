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
import 'package:tripus/models/user_model.dart';
import 'package:tripus/services/api_service.dart';
import 'package:tripus/controllers/signup_email_controller.dart';

import 'package:tripus/widgets/status_message.dart';

class SignupPasswordPage extends StatefulWidget {
  const SignupPasswordPage({super.key});

  @override
  State<SignupPasswordPage> createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // 상태 메시지용 변수
  String? _nicknameStatus;
  MessageType? _nicknameType;
  String? _passwordStatus;
  MessageType? _passwordType;

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
                    // 닉네임 입력 & 중복확인
                    CommonTextfield(
                      label: '닉네임을 입력해주세요',
                      controller: _nicknameController,
                      suffixText: '중복확인',
                      onSuffixPressed: () async {
                        final nick = _nicknameController.text.trim();
                        if (nick.isEmpty) return;

                        try {
                          bool dup =
                              await ApiService.checkNicknameDuplicate(nick);
                          setState(() {
                            if (dup) {
                              _nicknameStatus = '이미 사용 중인 닉네임입니다.';
                              _nicknameType = MessageType.error;
                            } else {
                              _nicknameStatus = '사용 가능한 닉네임이에요!';
                              _nicknameType = MessageType.success;
                            }
                          });
                        } catch (e) {
                          setState(() {
                            _nicknameStatus = '서버에 연결할 수 없습니다.';
                            _nicknameType = MessageType.error;
                          });
                          // 디버그용
                          print('닉네임 중복 확인 에러: $e');
                        }
                      },
                      statusMessage: _nicknameStatus,
                      messageType: _nicknameType,
                    ),

                    // 비밀번호 입력
                    CommonTextfield(
                      label: '비밀번호를 입력해주세요',
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: (_) => _validatePasswords(),
                    ),

                    // 비밀번호 확인 입력
                    CommonTextfield(
                      label: '비밀번호를 다시 입력해주세요',
                      controller: _confirmPasswordController,
                      obscureText: true,
                      onChanged: (_) => _validatePasswords(),
                      statusMessage: _passwordStatus,
                      messageType: _passwordType,
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: 315,
                child: ActiveButton(
                  text: '다음으로',
                  onPressed: () async {
                    final nickname = _nicknameController.text.trim();
                    final password = _passwordController.text.trim();
                    final confirmPassword =
                        _confirmPasswordController.text.trim();

                    if (password != confirmPassword) {
                      // 비밀번호 불일치 에러 처리
                      return;
                    }

                    final user = RegisterUser(
                      email: SignupEmailController.verifiedEmail,
                      password: password,
                      nickname: nickname,
                      profileImageBase64: _base64Image,
                    );

                    try {
                      final result = await ApiService.register(user);
                      if (result['status'] == 201) {
                        Navigator.pushNamed(context, AppRoutes.signupSuccess);
                      }
                    } catch (e) {
                      print('회원가입 실패: $e');
                    }
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

  void _validatePasswords() {
    final pw = _passwordController.text;
    final cpw = _confirmPasswordController.text;

    setState(() {
      if (cpw.isEmpty) {
        _passwordStatus = null;
        _passwordType = null;
      } else if (pw == cpw) {
        _passwordStatus = '비밀번호가 일치합니다.';
        _passwordType = MessageType.success;
      } else {
        _passwordStatus = '비밀번호가 일치하지 않습니다.';
        _passwordType = MessageType.error;
      }
    });
  }
}
