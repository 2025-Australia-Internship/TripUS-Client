import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tripus/models/landmark.dart';

class LandmarkService {
  /// 전체 랜드마크 목록 불러오기
  Future<List<Landmark>> loadLandmarks() async {
    final String jsonString =
        await rootBundle.loadString('assets/landmarks.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => Landmark.fromJson(e)).toList();
  }

  /// ID로 랜드마크 하나 가져오기
  Future<Landmark?> getLandmarkById(int id) async {
    final List<Landmark> landmarks = await loadLandmarks();
    try {
      return landmarks.firstWhere((landmark) => landmark.id == id);
    } catch (_) {
      return null;
    }
  }
}
