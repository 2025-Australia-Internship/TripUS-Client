import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripus/services/api_service.dart';
import 'package:tripus/widgets/status_message.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? emailStatusMessage;
  MessageType? emailMessageType;
  String? passwordStatusMessage;
  MessageType? passwordMessageType;

  void clearEmailError() {
    emailStatusMessage = null;
    emailMessageType = null;
  }

  void clearPasswordError() {
    passwordStatusMessage = null;
    passwordMessageType = null;
  }

  Future<bool> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    clearEmailError();
    clearPasswordError();

    if (email.isEmpty || password.isEmpty) {
      if (email.isEmpty) {
        emailStatusMessage = '이메일을 입력해주세요';
        emailMessageType = MessageType.error;
      }
      if (password.isEmpty) {
        passwordStatusMessage = '비밀번호를 입력해주세요';
        passwordMessageType = MessageType.error;
      }
      return false;
    }

    try {
      final result = await ApiService.login(email, password);
      await _storage.write(key: 'jwt', value: result['access_token']);
      return true;
    } catch (e) {
      final error = e.toString();
      if (error.contains('User not found')) {
        emailStatusMessage = '계정이 존재하지 않습니다.';
        emailMessageType = MessageType.error;
      } else if (error.contains('Password is incorrect')) {
        passwordStatusMessage = '비밀번호가 일치하지 않습니다.';
        passwordMessageType = MessageType.error;
      } else {
        passwordStatusMessage = '로그인에 실패했습니다.';
        passwordMessageType = MessageType.error;
      }
      return false;
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
