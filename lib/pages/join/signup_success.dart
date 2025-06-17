import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/widgets/primary_button.dart';

class SignupSuccessPage extends StatelessWidget {
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
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/join/speech_bubble.svg'),
                Positioned(
                    top: 32,
                    child: Text(
                      '회원가입 성공!',
                      style: TextStyle(
                        color: dark08,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ))
              ],
            ),
            SizedBox(height: 20),
            SvgPicture.asset('assets/mascot.svg'),
            Spacer(),
            SizedBox(
              width: 315,
              child: PrimaryButton(
                text: '돌아가기',
                backgroundColor: MainColor,
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.auth);
                },
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
