import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripus/services/api_service.dart';
import 'package:tripus/widgets/status_message.dart';
import 'package:tripus/utils/storage_helper.dart';

class LoginController {
  String? debugLogMessage;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // ✅ ValueNotifier로 상태 관리
  final ValueNotifier<String?> emailStatusMessage = ValueNotifier(null);
  final ValueNotifier<MessageType?> emailMessageType = ValueNotifier(null);
  final ValueNotifier<String?> passwordStatusMessage = ValueNotifier(null);
  final ValueNotifier<MessageType?> passwordMessageType = ValueNotifier(null);

  void clearEmailError() {
    emailStatusMessage.value = null;
    emailMessageType.value = null;
  }

  void clearPasswordError() {
    passwordStatusMessage.value = null;
    passwordMessageType.value = null;
  }

  Future<bool> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    clearEmailError();
    clearPasswordError();

    if (email.isEmpty || password.isEmpty) {
      if (email.isEmpty) {
        emailStatusMessage.value = '이메일을 입력해주세요';
        emailMessageType.value = MessageType.error;
      }
      if (password.isEmpty) {
        passwordStatusMessage.value = '비밀번호를 입력해주세요';
        passwordMessageType.value = MessageType.error;
      }
      return false;
    }

    try {
      final result = await ApiService.login(email, password);
      await StorageHelper.saveToken('accessToken', result['access_token']);
      return true;
    } catch (e) {
      final error = e.toString();
      debugLogMessage = error;
      print('로그인 실패 에러: $error');

      if (error.contains('User not found')) {
        emailStatusMessage.value = '계정이 존재하지 않습니다.';
        emailMessageType.value = MessageType.error;
      } else if (error.contains('Password is incorrect')) {
        passwordStatusMessage.value = '비밀번호가 일치하지 않습니다.';
        passwordMessageType.value = MessageType.error;
      } else {
        passwordStatusMessage.value = '로그인에 실패했습니다.';
        passwordMessageType.value = MessageType.error;
      }
      return false;
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailStatusMessage.dispose();
    emailMessageType.dispose();
    passwordStatusMessage.dispose();
    passwordMessageType.dispose();
  }
}
