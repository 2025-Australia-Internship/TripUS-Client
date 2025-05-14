import 'dart:math';

class AuthService {
  String? _generatedCode;

  // 임의 코드 생성
  String sendVerificationCode() {
    final code = (100000 + Random().nextInt(900000)).toString();
    _generatedCode = code;
    print('발급된 인증코드: $code'); // 임시 코드 콘솔 출력
    return code;
  }

  // 인증 코드 비교
  bool verifyCode(String input) {
    return _generatedCode != null && _generatedCode == input;
  }

  // 코드 리셋
  void resetCode() {
    _generatedCode = null;
  }

  // 코드가 존재하는지 확인
  bool get hasValidCode => _generatedCode != null;
}
