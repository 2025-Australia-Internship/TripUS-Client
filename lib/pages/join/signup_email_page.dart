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
import 'package:tripus/pages/join/signup_success.dart';
import 'package:tripus/widgets/active_button.dart';
import 'package:tripus/widgets/close_icon_button.dart';
import 'package:tripus/widgets/appbar.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/primary_button.dart';

import 'package:tripus/routes/app_routes.dart';

class SignupEmailPage extends StatefulWidget {
  const SignupEmailPage({super.key});

  @override
  State<SignupEmailPage> createState() => _SignupEmailPageState();
}

class _SignupEmailPageState extends State<SignupEmailPage> {
  bool _isCodeSent = false; // 인증번호 전송 여부
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
            Navigator.pushNamed(context, AppRoutes.signUpPassword);
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
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: light05,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/join/profile_logo.svg',
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 315,
                child: Column(
                  children: [
                    CommonTextfield(
                      label: '이메일을 입력해주세요',
                      controller: _emailController,
                      onSuffixPressed: () {
                        //TODO: 이메일 인증 로직
                        //verifyEmail(_emailController.text);
                      },
                      suffixText: '인증하기',
                    )
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: 315,
                child: ActiveButton(
                  text: '다음으로',
                  onPressed: () {
                    //TODO: 이메일 인증 후 활성화
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

  Future<void> validateAndSignup(BuildContext context) async {
    // if (_textController.text.isEmpty ||
    //     _emailController.text.isEmpty ||
    //     _passwordController.text.isEmpty) {
    //   showSnackBar(context, 'Please enter all fields.');
    //   return;
    // }

    final apiUrl = "${dotenv.env['BASE_URL']}/auth/register";
    final Map<String, dynamic> data = {
      // "username": _textController.text,
      // "email": _emailController.text,
      // "password": _passwordController.text,
      // "profile_image": _base64Image
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        if (context.mounted) {
          // showSnackBar(context, "Registration successful!", isError: false);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignupSuccessPage()),
          );
        }
      } else {
        final responseData = jsonDecode(response.body);
        if (context.mounted) {
          // showSnackBar(context, responseData['message'] ?? "Unknoewn error");
        }
      }
    } catch (error) {
      print('Error during registration: $error');
      if (context.mounted) {
        // showSnackBar(context, 'Error: $error');
      }
    }
  }

  // 중복 체크
  Future<bool> checkUserEmail(String email) async {
    final apiUrl = "${dotenv.env['BASE_URL']}/auth/check-email";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 201) {
        final responsData = jsonDecode(response.body);
        return responsData['isAvailable'] ?? false;
      } else {
        throw new Exception("Failed to check email");
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> checkUsername(String username) async {
    final apiUrl = "${dotenv.env['BASE_URL']}/auth/check-username";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({"username": username}),
      );

      if (response.statusCode == 201) {
        final responsData = jsonDecode(response.body);
        return responsData['isAvailable'] ?? false;
      } else {
        throw new Exception("Failed to check username");
      }
    } catch (error) {
      print("error $error");
      return false;
    }
  }

  void checkEmailAndShow(String email) async {
    if (email.isEmpty) {
      // showSnackBar(context, 'Please enter an email.');
      return;
    }

    bool isAvailable = await checkUserEmail(email);
    if (isAvailable) {
      //showSnackBar(context, 'Email is available!', isError: false);
    } else {
      //showSnackBar(context, 'Email is already in use.');
    }
  }

  void checkUsernameAndShow(String username) async {
    if (username.isEmpty) {
      //showSnackBar(context, 'Please enter a username.');
      return;
    }

    bool isAvailable = await checkUsername(username);
    if (isAvailable) {
      //showSnackBar(context, 'Username is available!', isError: false);
    } else {
      //showSnackBar(context, 'Username is already in use.');
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File imageFile = File(image.path);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      //   setState(() {
      //     _selectedImage = imageFile;
      //     _base64Image = base64Image;
      //   });
      // }
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
}
