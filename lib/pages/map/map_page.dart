import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:tripus/models/landmark.dart';
import 'package:tripus/widgets/landmark_marker.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/services/landmark/landmark_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? selectedMarker;
  List<Landmark> landmarks = [];

  @override
  void initState() {
    super.initState();
    loadLandmarks();
  }

  Future<void> loadLandmarks() async {
    final data = await LandmarkService().loadLandmarks();
    setState(() {
      landmarks = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-37.7980, 144.9850),
          zoom: 13.6,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: landmarks.map((landmark) {
              return Marker(
                point: landmark.location,
                width: 350,
                height: 80,
                builder: (context) => LandmarkMarker(
                  landmark: landmark,
                  isSelected: selectedMarker == landmark.name,
                  onTap: () {
                    setState(() {
                      selectedMarker = selectedMarker == landmark.name
                          ? null
                          : landmark.name;
                    });
                  },
                  onCameraTap: () {
                    // 하드코딩 상태로 아무 동작 없이 남김
                    debugPrint('🧷 카메라 버튼 눌림 - 실제 이미지 선택 없음');
                  },
                ),
              );
            }).toList(),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 1),
    );
  }
}
