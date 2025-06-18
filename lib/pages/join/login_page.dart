import 'package:flutter/material.dart';

import 'package:tripus/routes/app_routes.dart';

import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/active_button.dart';

import 'package:tripus/services/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController _controller;
  String? _debugLog;

  @override
  void initState() {
    super.initState();
    _controller = LoginController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: CustomAppBar(
        text: '로그인',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: bodyHeight,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                width: 315,
                child: Column(
                  children: [
                    ValueListenableBuilder<String?>(
                      valueListenable: _controller.emailStatusMessage,
                      builder: (_, message, __) {
                        return CommonTextfield(
                          label: '이메일을 입력해주세요',
                          controller: _controller.emailController,
                          statusMessage: message,
                          messageType: _controller.emailMessageType.value,
                          onChanged: (_) => _controller.clearEmailError(),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder<String?>(
                      valueListenable: _controller.passwordStatusMessage,
                      builder: (_, message, __) {
                        return CommonTextfield(
                          label: '비밀번호를 입력해주세요',
                          controller: _controller.passwordController,
                          statusMessage: message,
                          messageType: _controller.passwordMessageType.value,
                          obscureText: true,
                          onChanged: (_) => _controller.clearPasswordError(),
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
                  text: '로그인',
                  onPressed: () async {
                    final success = await _controller.login();
                    if (success && context.mounted) {
                      Navigator.pushNamed(context, AppRoutes.home);
                    } else {
                      setState(() {
                        _debugLog = '로그인 실패: ${_controller.debugLogMessage}';
                      }); // 상태 메시지 갱신
                    }
                  },
                ),
              ),
              if (_debugLog != null)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _debugLog!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
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
