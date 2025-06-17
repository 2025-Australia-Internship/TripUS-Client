import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/widgets/custom_appbar.dart';
import 'package:tripus/widgets/close_icon_button.dart';
import 'package:tripus/widgets/common_textfield.dart';
import 'package:tripus/widgets/status_message.dart';
import 'package:tripus/widgets/active_button.dart';

import 'package:tripus/services/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController _controller;

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
        actionIcon: CloseIconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
        ),
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
                    CommonTextfield(
                      label: '이메일을 입력해주세요',
                      controller: _controller.emailController,
                      statusMessage: _controller.emailStatusMessage,
                      messageType: _controller.emailMessageType,
                      onChanged: (_) => _controller.clearEmailError(),
                    ),
                    const SizedBox(height: 20),
                    CommonTextfield(
                      label: '비밀번호를 입력해주세요',
                      controller: _controller.passwordController,
                      statusMessage: _controller.passwordStatusMessage,
                      messageType: _controller.passwordMessageType,
                      obscureText: true,
                      onChanged: (_) => _controller.clearPasswordError(),
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
                      setState(() {}); // 상태 메시지 갱신
                    }
                  },
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
