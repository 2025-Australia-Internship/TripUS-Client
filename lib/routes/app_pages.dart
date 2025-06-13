import 'package:flutter/material.dart';
import 'package:tripus/pages/home/friend_page.dart';
import 'package:tripus/pages/home/friend_Home_page.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';
import 'package:tripus/pages/polaroid/one_polaroid.dart';
import 'package:tripus/pages/profile/edit_profile.dart';
import 'package:tripus/pages/profile/profile_page.dart';
import 'package:tripus/routes/app_routes.dart';
import 'package:tripus/pages/join/auth_page.dart';
import 'package:tripus/pages/join/login_page.dart';
import 'package:tripus/pages/join/signup_email_page.dart';
import 'package:tripus/pages/join/signup_password_page.dart';
import 'package:tripus/pages/join/signup_success.dart';
import 'package:tripus/pages/home/home_page.dart';
import 'package:tripus/pages/home/landmark_badge.dart';
import 'package:tripus/pages/map/map_page.dart';
import 'package:tripus/pages/map/landmark_details.dart';

final routes = {
  AppRoutes.auth: (context) => const AuthPage(),
  AppRoutes.login: (context) => const LoginPage(),
  AppRoutes.signUpEmail: (context) => const SignupEmailPage(),
  AppRoutes.signUpPassword: (context) => const SignupPasswordPage(),
  AppRoutes.signupSuccess: (context) => SignupSuccessPage(),
  AppRoutes.home: (context) => const HomePage(),
  AppRoutes.landmark: (context) => LandmarkPage(),
  AppRoutes.map: (context) => MapPage(),
  AppRoutes.landmarkDetails: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    return LandmarkDetails(id: args);
  },
  AppRoutes.friend: (context) => FriendPage(),
  AppRoutes.friendHome: (context) => FriendHomePage(),
  AppRoutes.profile: (context) => ProfilePage(),
  AppRoutes.editProfile: (context) => EditProfilePage(),
  //AppRoutes.editPolaroid: (context) => const EditPolaroid(selectedImage: selectedImage, base64Image: base64Image),
  //AppRoutes.onePolaroid: (context) => const OnePolaroid(polaroidId: polaroidId, photoUrl: photoUrl, caption: caption, backgroundColor: backgroundColor),
};
