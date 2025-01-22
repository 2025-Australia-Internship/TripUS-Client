import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';
import 'package:tripus/pages/map/landmark_details.dart';
import 'package:tripus/pages/polaroid/edit_polaroid.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? selectedMarker;
  String? _base64Image;
  File? _selectedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File imageFile = File(image.path);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      setState(() {
        _selectedImage = imageFile;
        _base64Image = base64Image;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditPolaroid(
            selectedImage: _selectedImage!,
            base64Image: _base64Image!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-37.7970, 144.9820),
          zoom: 13.6,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'], // OSM 기본 타일
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-37.8033, 144.9714), // Melbourne Museum
                width: 350,
                height: 80,
                builder: (context) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      selectedMarker = selectedMarker == "Melbourne Museum"
                          ? null
                          : "Melbourne Museum";
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // 정보 박스
                      if (selectedMarker == "Melbourne Museum")
                        Positioned(
                          top: -50,
                          right: 0,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LandmarkDetails(id: 1),
                                ),
                              );
                            },
                            child: Container(
                              width: 230,
                              height: 78,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: grey01,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey03,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Melbourne Museum",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "11 Nicholson St",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: light08,
                                    child: IconButton(
                                      onPressed: () {
                                        pickImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: light04,
                                      ),
                                      iconSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      //마커 아이콘
                      Icon(Icons.location_pin, color: light02, size: 50),
                    ],
                  ),
                ),
              ),
              Marker(
                point: LatLng(-37.8211, 144.9784), // Melbourne Park
                width: 300,
                height: 80,
                builder: (context) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      selectedMarker = selectedMarker == "Melbourne Park"
                          ? null
                          : "Melbourne Park";
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // 정보 박스
                      if (selectedMarker == "Melbourne Park")
                        Positioned(
                          top: -50,
                          right: 0,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LandmarkDetails(id: 2),
                                ),
                              );
                            },
                            child: Container(
                              width: 210,
                              height: 78,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: grey01,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey03,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Melbourne Park",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Olympic Blvd",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: light08,
                                    child: IconButton(
                                      onPressed: () {
                                        pickImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: light04,
                                      ),
                                      iconSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      //마커 아이콘
                      Icon(Icons.location_pin, color: light02, size: 50),
                    ],
                  ),
                ),
              ),
              Marker(
                point:
                    LatLng(-37.8225, 144.9689), // National Gallery of Victoria
                width: 500,
                height: 80,
                builder: (context) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      selectedMarker =
                          selectedMarker == "National Gallery of Victoria"
                              ? null
                              : "National Gallery of Victoria";
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // 정보 박스
                      if (selectedMarker == "National Gallery of Victoria")
                        Positioned(
                          top: -50,
                          right: 0,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LandmarkDetails(id: 3),
                                ),
                              );
                            },
                            child: Container(
                              width: 290,
                              height: 78,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: grey01,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey03,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "National Gallery of Victoria",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "180 St Kilda Rd",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: light08,
                                    child: IconButton(
                                      onPressed: () {
                                        pickImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: light04,
                                      ),
                                      iconSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      // 마커 아이콘
                      Icon(Icons.location_on, color: light02, size: 50),
                    ],
                  ),
                ),
              ),
              Marker(
                point: LatLng(-37.7747, 144.9980), // Melbourne Polytechnic
                width: 400,
                height: 80,
                builder: (context) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      selectedMarker = selectedMarker == "Melbourne Polytechnic"
                          ? null
                          : "Melbourne Polytechnic";
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // 정보 박스
                      if (selectedMarker == "Melbourne Polytechnic")
                        Positioned(
                          top: -50,
                          right: 0,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LandmarkDetails(id: 4),
                                ),
                              );
                            },
                            child: Container(
                              width: 250,
                              height: 78,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: grey01,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey03,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Melbourne Polytechnic",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "77 St Georges Rd",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: light08,
                                    child: IconButton(
                                      onPressed: () {
                                        pickImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: light04,
                                      ),
                                      iconSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      // 마커 아이콘
                      Icon(Icons.location_on, color: light02, size: 50),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 1),
    );
  }
}
