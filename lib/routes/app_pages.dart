import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/pages/join/login_page.dart';
import 'package:tripus/pages/join/auth_page.dart';

final routes = {
  AppRoutes.auth: (context) => const AuthPage(),
  AppRoutes.login: (context) => const LoginPage(),
};
