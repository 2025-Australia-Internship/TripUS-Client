import 'package:flutter/material.dart';
import 'package:tripus/models/user_model.dart';
import 'package:tripus/services/api_service.dart';

class SignupEmailController {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final ValueNotifier<bool> isCodeSent = ValueNotifier(false);
  final ValueNotifier<bool> isCodeVerified = ValueNotifier(false);
  final ValueNotifier<String> timerText = ValueNotifier('03:00');

  // 실제 인증은 테스트용으로 구현 (임의 코드 전송)
  String _sentCode = '';

  void init(VoidCallback onTimeout, VoidCallback onTick) {
    _sentCode = '123456';
    isCodeSent.value = true;
    isCodeVerified.value = false;
    // 타이머는 생략하거나 추가 구현 가능
  }

  void sendCode() {
    _sentCode = '123456';
    isCodeSent.value = true;
  }

  bool verifyCode(String input) {
    isCodeVerified.value = input == _sentCode;
    return isCodeVerified.value;
  }

  void dispose() {
    emailController.dispose();
    codeController.dispose();
  }

  // ✅ 임시 저장값 공유 목적 변수
  static String verifiedEmail = '';
}
