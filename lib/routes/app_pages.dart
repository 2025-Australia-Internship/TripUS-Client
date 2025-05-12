import 'package:tripus/pages/home/home_page.dart';
import 'package:tripus/pages/join/signup_email_page.dart';
import 'package:tripus/pages/join/signup_password_page.dart';
import 'package:tripus/pages/join/signup_success.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/pages/join/login_page.dart';
import 'package:tripus/pages/join/auth_page.dart';

final routes = {
  AppRoutes.auth: (context) => const AuthPage(),
  AppRoutes.login: (context) => const LoginPage(),
  AppRoutes.signUpEmail: (context) => const SignupEmailPage(),
  AppRoutes.signUpPassword: (context) => const SignupPasswordPage(),
  AppRoutes.signupSuccess: (context) => SignupSuccessPage(),
  AppRoutes.home: (context) => const HomePage(),
};
