import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripus/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  // 폴라로이드 전체 조회
  static Future<List<dynamic>> getUserPolaroids(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/polaroids'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('폴라로이드 불러오기 실패: ${response.statusCode}');
    }
  }

  // 폴라로이드 조회
  static Future<Map<String, dynamic>> getPolaroidById(
      String token, int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/polaroids/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('폴라로이드 조회 실패: ${response.statusCode}');
    }
  }

  // 폴라로이드 생성
  static Future<int> createPolaroid({
    required String token,
    required String photoUrl,
    required String caption,
    required String color,
    required bool isOpened,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/polaroids'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'photo_url': photoUrl,
        'caption': caption,
        'color': color,
        'is_opened': isOpened,
      }),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return json['id']; // 생성된 폴라로이드 ID
    } else {
      throw Exception('폴라로이드 생성 실패');
    }
  }
}
