import 'package:flutter/material.dart';
import 'package:tripus/routes/app_routes.dart';

import 'package:tripus/pages/join/auth_page.dart';
import 'package:tripus/pages/join/login_page.dart';
import 'package:tripus/pages/join/signup_email_page.dart';
import 'package:tripus/pages/join/signup_password_page.dart';
import 'package:tripus/pages/join/signup_success.dart';

import 'package:tripus/pages/home/home_page.dart';
import 'package:tripus/pages/home/landmark_badge.dart';
import 'package:tripus/pages/home/friend_page.dart';
import 'package:tripus/pages/home/friend_Home_page.dart';

import 'package:tripus/pages/map/map_page.dart';
import 'package:tripus/pages/map/landmark_details.dart';
import 'package:tripus/pages/map/loding_AI.dart';
import 'package:tripus/pages/map/picture_AI.dart';

import 'package:tripus/pages/polaroid/polaroid_page.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';
import 'package:tripus/pages/polaroid/many_polaroid.dart';
import 'package:tripus/pages/polaroid/one_polaroid.dart';

import 'package:tripus/pages/profile/edit_profile.dart';
import 'package:tripus/pages/profile/profile_page.dart';
import 'package:universal_html/js.dart';

final routes = {
  AppRoutes.auth: (context) => const AuthPage(),
  AppRoutes.login: (context) => const LoginPage(),
  AppRoutes.signUpEmail: (context) => const SignupEmailPage(),
  AppRoutes.signUpPassword: (context) => const SignupPasswordPage(),
  AppRoutes.signupSuccess: (context) => SignupSuccessPage(),
  //
  AppRoutes.home: (context) => const HomePage(),
  AppRoutes.landmark: (context) => LandmarkPage(),
  AppRoutes.friend: (context) => FriendPage(),
  AppRoutes.friendHome: (context) => FriendHomePage(),
  //
  AppRoutes.map: (context) => MapPage(),
  AppRoutes.landmarkDetails: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    return LandmarkDetails(id: args);
  },
  //
  AppRoutes.polaroid: (context) => const PolaroidPage(),
  AppRoutes.editPolaroid: (context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return EditPolaroid(imageSource: args); // File or Uint8List
  },
  AppRoutes.manyPolaroid: (context) => const ManyPolaroid(),
  AppRoutes.onePolaroid: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return OnePolaroid(
      photoUrl: args['photoUrl'],
      caption: args['caption'],
      backgroundColor: Color(int.parse('0x${args['backgroundColor']}')),
    );
  },
  //
  AppRoutes.profile: (context) => ProfilePage(),
  AppRoutes.editProfile: (context) => EditProfilePage(),
};
