import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tripus/models/landmark.dart';
import 'package:tripus/widgets/landmark_marker.dart';
import 'package:tripus/widgets/bottom_navigation.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';
import 'package:tripus/services/landmark/landmark_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  File? _selectedImage;
  String? selectedMarker;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        _selectedImage = imageFile;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPolaroid(
            selectedImage: imageFile,
            base64Image: base64Image,
          ),
        ),
      );
    }
  }

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
            subdomains: ['a', 'b', 'c'], // OSM 기본 타일
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
                  onCameraTap: pickImage,
                ),
              );
            }).toList(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(initialIndex: 1),
    );
  }
}
