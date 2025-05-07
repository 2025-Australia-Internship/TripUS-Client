import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/widgets/primary_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SvgPicture.asset(
              'assets/Logo.svg',
              width: 215,
              color: MainColor,
            ),
            Spacer(),
            SizedBox(
                width: 315,
                child: PrimaryButton(
                  text: '로그인',
                  backgroundColor: MainColor,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                )),
            SizedBox(height: 15),
            SizedBox(
                width: 315,
                child: PrimaryButton(
                  text: '회원가입',
                  backgroundColor: grey01,
                  color: MainColor,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                )),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
