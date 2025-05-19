import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/constants/colors.dart';

import 'package:tripus/widgets/appbar.dart';
import 'package:tripus/widgets/active_button.dart';
import 'package:tripus/widgets/close_icon_button.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/status_message.dart';

import 'package:tripus/services/auth/signup_email_controller.dart';

class SignupEmailPage extends StatefulWidget {
  const SignupEmailPage({super.key});

  @override
  State<SignupEmailPage> createState() => _SignupEmailPageState();
}

class _SignupEmailPageState extends State<SignupEmailPage> {
  late final SignupEmailController _controller;

  String? _statusMessage;
  MessageType? _messageType;

  // 메서드 초기화
  @override
  void initState() {
    super.initState();
    _controller = SignupEmailController();
    _controller.init(
      () {
        setState(() {
          _statusMessage = '인증 시간이 만료되었습니다.';
          _messageType = MessageType.error;
        });
      },
      () => setState(() {
        _controller.timerText.value = _controller.getFormattedTime();
      }),
    );
  }

  // 컨트롤러 해제
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 이메일 입력하면 인증 코드 전송
  void _sendCode() {
    final email = _controller.emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _statusMessage = '이메일을 먼저 입력해주세요';
        _messageType = MessageType.error;
      });
      return;
    }

    _controller.sendCode();
    setState(() {
      _statusMessage = '인증 코드를 전송하였습니다';
      _messageType = MessageType.success;
    });
  }

  // 인증 코드 일치 여부
  void _checkCode(String input) {
    final result = _controller.verifyCode(input);
    setState(() {
      if (result) {
        _statusMessage = '이메일 인증이 완료되었습니다';
        _messageType = MessageType.success;
      } else {
        _statusMessage = '인증 코드가 일치하지 않습니다';
        _messageType = MessageType.error;
      }
    });
  }

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
                    // 인증 코드 전송 여부에 따라 UI 렌더링
                    ValueListenableBuilder<bool>(
                      valueListenable: _controller.isCodeSent,
                      // isCodeSent의 값이 isSent 변수에 전달
                      builder: (context, isSent, _) {
                        return Column(
                          children: [
                            CommonTextfield(
                              label: '이메일을 입력해주세요',
                              controller: _controller.emailController,
                              onSuffixPressed: _sendCode,
                              statusMessage: _statusMessage,
                              messageType: _messageType,
                              suffixText: '인증하기',
                            ),
                            if (isSent)
                              // 타이머 실시간 빌드
                              ValueListenableBuilder<String>(
                                valueListenable: _controller.timerText,
                                builder: (context, timer, _) {
                                  return CommonTextfield(
                                    label: '인증번호를 입력해주세요',
                                    controller: _controller.codeController,
                                    statusMessage: _statusMessage,
                                    messageType: _messageType,
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
              Spacer(),
              SizedBox(
                width: 315,
                child: ActiveButton(
                  text: '다음으로',
                  onPressed: _controller.isCodeVerified.value
                      ? () {
                          Navigator.pushNamed(
                              context, AppRoutes.signUpPassword);
                        }
                      : null,
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
