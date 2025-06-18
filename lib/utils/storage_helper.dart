import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universal_html/html.dart' as html;

class StorageHelper {
  static final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage();

  static Future<void> saveToken(String key, String value) async {
    if (kIsWeb) {
      html.window.localStorage[key] = value;
    } else {
      await _secureStorage.write(key: key, value: value);
    }
  }

  static Future<String?> getToken(String key) async {
    if (kIsWeb) {
      return html.window.localStorage[key];
    } else {
      return await _secureStorage.read(key: key);
    }
  }

  static Future<void> deleteToken(String key) async {
    if (kIsWeb) {
      html.window.localStorage.remove(key);
    } else {
      await _secureStorage.delete(key: key);
    }
  }
}
