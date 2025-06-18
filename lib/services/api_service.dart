import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripus/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _baseUrl = dotenv.env['BASE_URL']!;

  // 이메일 중복 확인
  static Future<bool> checkEmailDuplicate(String email) async {
    final uri = Uri.parse('$_baseUrl/api/auth/check-email?email=$email');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['isDuplicate'] == true;
    } else {
      print('에러 응답: ${response.statusCode} - ${response.body}');
      throw Exception('이메일 중복 확인 실패');
    }
  }

  // 닉네임 중복 확인
  static Future<bool> checkUsernameDuplicate(String username) async {
    final uri =
        Uri.parse('$_baseUrl/api/auth/check-username?username=$username');
    print('닉네임 중복 확인 호출 URL: $uri');

    final response = await http.get(uri);

    print('응답 코드: ${response.statusCode}');
    print('응답 바디: ${response.body}');

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['isDuplicate'] == true;
    } else {
      throw Exception('중복 확인 실패');
    }
  }

  // 회원가입
  static Future<Map<String, dynamic>> register(RegisterUser user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    print(response);

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  // 로그인
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final uri = Uri.parse('$_baseUrl/api/auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('응답 코드: ${response.statusCode}');
    print('응답 바디: ${response.body}');

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (body['access_token'] == null) {
        throw Exception('No access token returned');
      }
      return body;
    } else {
      throw Exception(body['message'] ?? '로그인 실패');
    }
  }
}
