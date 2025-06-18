import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';

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

  // final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImageFromGallery() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     debugPrint('📷 선택된 이미지 경로: ${image.path}');
  //     // 이후 처리: 예를 들면 해당 landmark에 사진 저장 or 다른 페이지로 이동 등
  //   } else {
  //     debugPrint('❌ 이미지 선택이 취소됨');
  //   }
  // }

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
          center: LatLng(-37.8025, 144.9720),
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
