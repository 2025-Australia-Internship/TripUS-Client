import 'package:latlong2/latlong.dart';

class Landmark {
  final int id;
  final String name;
  final String coordinates;
  final String address;
  final String image;
  final String backgroundImage;
  final String symbol;
  final String description;

  Landmark({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.address,
    required this.image,
    required this.backgroundImage,
    required this.symbol,
    required this.description,
  });

  LatLng get location {
    final parts = coordinates.split(',');
    return LatLng(
      double.parse(parts[0].trim()),
      double.parse(parts[1].trim()),
    );
  }

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      id: json['id'] ?? 0, // ← 기본값 제공
      name: json['name'] ?? '',
      coordinates: json['coordinates'] ?? '0,0',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      symbol: json['symbol'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
