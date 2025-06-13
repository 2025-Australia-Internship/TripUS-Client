class RegisterUser {
  final String email;
  final String password;
  final String nickname;
  final String? profileImageBase64;

  RegisterUser({
    required this.email,
    required this.password,
    required this.nickname,
    this.profileImageBase64,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'nickname': nickname,
        if (profileImageBase64 != null) 'profile_image': profileImageBase64,
      };
}
