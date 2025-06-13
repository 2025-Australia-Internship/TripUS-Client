import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String _baseUrl = 'http://<YOUR_BACKEND_URL>';

  Future<Map<String, dynamic>> registerUser(
      String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    final data = json.decode(response.body);

    if (response.statusCode == 201) {
      return data; // 회원가입 성공
    } else {
      throw Exception(data['message'] ?? '회원가입 실패');
    }
  }
}
