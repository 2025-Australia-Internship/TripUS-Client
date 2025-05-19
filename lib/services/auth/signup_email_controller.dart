import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'auth_timer.dart';

class SignupEmailController {
  final emailController = TextEditingController();
  final codeController = TextEditingController();

  final AuthService _authService = AuthService();
  late final AuthTimer _authTimer;

  // ValueNotifier : 값의 변화를 감지하고 자동으로 알림
  final ValueNotifier<bool> isCodeSent = ValueNotifier(false);
  final ValueNotifier<bool> isCodeVerified = ValueNotifier(false); // 인증코드 확인
  final ValueNotifier<String> timerText = ValueNotifier('3:00');

  void init(VoidCallback onTimeout, VoidCallback onTick) {
    _authTimer = AuthTimer(
      onTimeout: () {
        reset();
        onTimeout();
      },
      onTick: (_) => onTick(), // 시간 갱신
    );
  }

  void reset() {
    _authTimer.cancel();
    _authService.resetCode();
    isCodeSent.value = false;
    timerText.value = '0:00';
  }

  void sendCode() {
    _authService.sendVerificationCode(); // 인증코드 생성
    _authTimer.start(); // 타이머 실시
    isCodeSent.value = true;
    isCodeVerified.value = false;
  }

  // 인증 코드 비교
  bool verifyCode(String input) {
    final isVerified = _authService.verifyCode(input);
    if (isVerified) {
      _authTimer.cancel();
      isCodeVerified.value = true;
    } else {
      isCodeVerified.value = false;
    }
    return isVerified;
  }

  // 리소스 해제
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    _authTimer.cancel();
  }

  String getFormattedTime() => _authTimer.formatTime();
}
