import 'package:flutter/material.dart';

import 'package:tripus/routes/app_routes.dart';

import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/profile.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/status_message.dart';
import 'package:tripus/widgets/active_button.dart';

import 'package:tripus/models/user_model.dart';
import 'package:tripus/services/api_service.dart';

class SignupPasswordPage extends StatefulWidget {
  const SignupPasswordPage({super.key});

  @override
  State<SignupPasswordPage> createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // 상태 메시지용 변수
  String? _usernameStatus;
  MessageType? _usernameType;
  String? _passwordStatus;
  MessageType? _passwordType;

  String? _base64Image;
  late final String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    email = args is String ? args : '';
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

  Future<void> _checkUsernameDuplicate() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) return;

    try {
      final isDuplicate = await ApiService.checkUsernameDuplicate(username);
      setState(() {
        _usernameStatus = isDuplicate ? '이미 사용 중인 닉네임입니다.' : '사용 가능한 닉네임이에요!';
        _usernameType = isDuplicate ? MessageType.error : MessageType.success;
      });
    } catch (e) {
      setState(() {
        _usernameStatus = '서버에 연결할 수 없습니다.';
        _usernameType = MessageType.error;
      });
      print('닉네임 중복 확인 에러: $e');
    }
  }

  Future<void> _register() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) return;

    print('base64: $_base64Image');
    final user = RegisterUser(
      email: email,
      password: password,
      username: username,
      profile_image: _base64Image,
    );

    try {
      final result = await ApiService.register(user);
      if (result['status'] == 201) {
        Navigator.pushNamed(context, AppRoutes.signupSuccess);
      }
    } catch (e) {
      print('회원가입 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: CustomAppBar(
        text: '회원가입',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: bodyHeight,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Profile(
                width: 100,
                height: 100,
                onImageSelected: (base64) {
                  setState(() {
                    _base64Image = base64;
                  });
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 315,
                child: Column(
                  children: [
                    // 닉네임 입력 & 중복확인
                    CommonTextfield(
                      label: '닉네임을 입력해주세요',
                      controller: _usernameController,
                      suffixText: '중복확인',
                      onSuffixPressed: _checkUsernameDuplicate,
                      statusMessage: _usernameStatus,
                      messageType: _usernameType,
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
              const Spacer(),
              SizedBox(
                width: 315,
                child: ActiveButton(
                  text: '회원가입',
                  onPressed: _register,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
