import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripus/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  static Future<bool> checkNicknameDuplicate(String nickname) async {
    final uri = Uri.parse('$_baseUrl/users/check-nickname?nickname=$nickname');
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

  static Future<Map<String, dynamic>> register(RegisterUser user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }
}
