import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/constants/colors.dart';

import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/status_message.dart';
import 'package:tripus/widgets/active_button.dart';

import 'package:tripus/services/auth/signup_email_controller.dart';
import 'package:tripus/services/api_service.dart';

class SignupEmailPage extends StatefulWidget {
  const SignupEmailPage({super.key});

  @override
  State<SignupEmailPage> createState() => _SignupEmailPageState();
}

class _SignupEmailPageState extends State<SignupEmailPage> {
  late final SignupEmailController _controller;

  String? _emailStatusMessage;
  MessageType? _emailMessageType;

  String? _codeStatusMessage;
  MessageType? _codeMessageType;

  @override
  void initState() {
    super.initState();
    _controller = SignupEmailController();
    _controller.init(
      _onCodeExpired,
      _updateTimer,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 이메일 형식 검사
  bool _isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  void _onCodeExpired() {
    setState(() {
      _codeStatusMessage = '인증 시간이 만료되었습니다.';
      _codeMessageType = MessageType.error;
    });
  }

  void _updateTimer() {
    setState(() {
      _controller.timerText.value = _controller.getFormattedTime();
    });
  }

  // 이메일 중복 검사 + 인증 코드 전송
  void _sendCode() async {
    final email = _controller.emailController.text.trim();
    print('입력된 이메일: $email');

    setState(() {
      _emailStatusMessage = null;
      _emailMessageType = null;
      _codeStatusMessage = null;
      _codeMessageType = null;
    });

    if (email.isEmpty) {
      _setEmailError('이메일을 먼저 입력해주세요');
      return;
    }

    if (!_isValidEmail(email)) {
      _setEmailError('이메일 형식을 확인해주세요');
      return;
    }

    // 이메일 중복 검사
    try {
      final isDuplicate = await ApiService.checkEmailDuplicate(email);
      if (isDuplicate) {
        _controller.reset();
        _setEmailError('이미 가입된 이메일이에요');
        return;
      }
    } catch (e) {
      _controller.reset();
      print(e);
      _setEmailError('이메일 확인 중 에러가 발생했습니다.');
      return;
    }

    try {
      final code = await _controller.sendCode(); // 코드 받아오기

      setState(() {
        _emailStatusMessage = '인증 코드를 전송하였습니다';
        _emailMessageType = MessageType.success;
      });

      // 🔔 알림창으로 코드 보여주기
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('인증 코드'),
            content: Text('인증 코드: $code'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('이메일 중복 확인 실패: $e');
      _controller.reset();
      _setEmailError('중복 확인 중 오류가 발생했습니다');
    }
  }

  void _setEmailError(String message) {
    setState(() {
      _emailStatusMessage = message;
      _emailMessageType = MessageType.error;
    });
  }

  // 인증 코드 확인
  void _checkCode(String input) {
    final result = _controller.verifyCode(input);
    setState(() {
      if (result) {
        _codeStatusMessage = '이메일 인증이 완료되었습니다';
        _codeMessageType = MessageType.success;
      } else {
        _codeStatusMessage = '인증 코드가 일치하지 않습니다';
        _codeMessageType = MessageType.error;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: CustomAppBar(text: '회원가입'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: bodyHeight,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: light05,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('assets/join/profile_logo.svg'),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 315,
                child: Column(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: _controller.isCodeSent,
                      builder: (context, isSent, _) {
                        return Column(
                          children: [
                            CommonTextfield(
                              label: '이메일을 입력해주세요',
                              controller: _controller.emailController,
                              onSuffixPressed: _sendCode,
                              onChanged: (_) {
                                setState(() {
                                  _emailStatusMessage = null;
                                  _emailMessageType = null;
                                  _codeStatusMessage = null;
                                  _codeMessageType = null;
                                });
                              },
                              statusMessage: _emailStatusMessage,
                              messageType: _emailMessageType,
                              suffixText: '인증하기',
                            ),
                            if (isSent)
                              ValueListenableBuilder<String>(
                                valueListenable: _controller.timerText,
                                builder: (context, timer, _) {
                                  return CommonTextfield(
                                    label: '인증번호를 입력해주세요',
                                    controller: _controller.codeController,
                                    statusMessage: _codeStatusMessage,
                                    messageType: _codeMessageType,
                                    onChanged: _checkCode,
                                    suffixText: timer,
                                    enabled: true,
                                  );
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 315,
                child: ActiveButton(
                  text: '다음으로',
                  onPressed: _controller.isCodeVerified.value
                      ? () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.signUpPassword,
                            arguments: _controller.emailController.text.trim(),
                          );
                        }
                      : null,
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
