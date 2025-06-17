class RegisterUser {
  final String email;
  final String password;
  final String username;
  final String? profile_image;

  RegisterUser({
    required this.email,
    required this.password,
    required this.username,
    this.profile_image,
  });

  Map<String, dynamic> toJson() => {
        if (profile_image != null) 'profile_image': profile_image,
        'email': email,
        'password': password,
        'username': username,
      };
}
