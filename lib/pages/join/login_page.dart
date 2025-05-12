import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tripus/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:tripus/pages/home/home_page.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/widgets/appbar.dart';
import 'package:tripus/widgets/close_icon_button.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/active_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 안전하게 토큰을 저장하기 위한
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height; // AppBar 높이를 계산

    // 화면 전체 높이에서 AppBar와 SafeArea를 제외
    final bodyHeight = MediaQuery.of(context).size.height -
        appBarHeight -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: CustomAppBar(
        text: '로그인',
        actionIcon: CloseIconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.home);
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
              SizedBox(
                width: 315,
                child: Column(
                  children: [
                    CommonTextfield(
                      label: '이메일을 입력해주세요',
                      controller: _emailController,
                    ),
                    SizedBox(height: 20),
                    CommonTextfield(
                      label: '비밀번호를 입력해주세요',
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: 315,
                child: ActiveButton(
                  text: '로그인',
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

  Future<void> login(BuildContext context) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showSnackBar(context, 'Please enter all fields.');
      return;
    }

    final String apiUrl = '${dotenv.env['BASE_URL']}/auth/login';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        await storage.write(key: 'jwt', value: responseData['access_token']);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        final responseData = jsonDecode(response.body);
        final errorMessage =
            responseData['message'] ?? 'Failed to login. Please try again.';
        showSnackBar(context, errorMessage);
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  // TODO : 나중에 색 수정하기
  void showSnackBar(BuildContext context, String message,
      {bool isError = true}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: isError ? Color(0xffFA7A7A) : Color(0xff4CAF50),
      duration: Duration(seconds: 30),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
