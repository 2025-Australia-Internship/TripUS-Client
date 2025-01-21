import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:tripus/colors.dart';
import 'package:tripus/pages/join/success_page.dart';
import 'package:tripus/pages/join/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Join',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 30),
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: light05,
                      shape: BoxShape.circle,
                      image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xffD9D9D9),
                      child: IconButton(
                        onPressed: _pickImage,
                        icon: Icon(Icons.camera_alt),
                        color: MainColor,
                        iconSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
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
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light08, width: 2.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light08, width: 2.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: IconButton(
                            onPressed: () =>
                                checkUsernameAndShow(_textController.text),
                            icon: SvgPicture.asset(
                              'assets/Check.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'E-mail',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light08, width: 2.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light08, width: 2.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: IconButton(
                            onPressed: () =>
                                checkEmailAndShow(_emailController.text),
                            icon: SvgPicture.asset(
                              'assets/Check.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light08, width: 2.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light08, width: 2.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Text(
                    //   'Check Password',
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(height: 5),
                    // TextFormField(
                    //   controller: _passwordController,
                    //   decoration: InputDecoration(
                    //     enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: light08, width: 2.5),
                    //         borderRadius: BorderRadius.circular(10)),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 170),
              Spacer(),
              SizedBox(
                width: 315,
                child: ElevatedButton(
                  onPressed: () => validateAndSignup(context),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: MainColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
    if (_textController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      showSnackBar(context, 'Please enter all fields.');
      return;
    }

    // TODO : 이미지 불러오기
    final apiUrl = "${dotenv.env['BASE_URL']}/auth/register";
    final Map<String, String> data = {
      "username": _textController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "profile_image": ""
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        if (context.mounted) {
          showSnackBar(context, "Registration successful!", isError: false);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SuccessPage()),
          );
        }
      } else {
        final responseData = jsonDecode(response.body);
        if (context.mounted) {
          showSnackBar(context, responseData['message'] ?? "Unknoewn error");
        }
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $error');
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
      showSnackBar(context, 'Please enter an email.');
      return;
    }

    bool isAvailable = await checkUserEmail(email);
    if (isAvailable) {
      showSnackBar(context, 'Email is available!', isError: false);
    } else {
      showSnackBar(context, 'Email is already in use.');
    }
  }

  void checkUsernameAndShow(String username) async {
    if (username.isEmpty) {
      showSnackBar(context, 'Please enter a username.');
      return;
    }

    bool isAvailable = await checkUsername(username);
    if (isAvailable) {
      showSnackBar(context, 'Username is available!', isError: false);
    } else {
      showSnackBar(context, 'Username is already in use.');
    }
  }

  File? _selectedImage; // 선택한 이미지를 저장할 변수

  final ImagePicker _picker = ImagePicker();

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
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
