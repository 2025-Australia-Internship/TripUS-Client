import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? selectedMarker;

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
                width: 100,
                height: 80,
                builder: (context) => GestureDetector(
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
                          top: -45,
                          left: 15,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    onPressed: () {},
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
                      // 마커 아이콘
                      Icon(
                        Icons.location_on,
                        color: light02,
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ),
              Marker(
                point: LatLng(-37.8211, 144.9784), // Melbourne Park
                builder: (context) => GestureDetector(
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
                          top: -60,
                          left: -5,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    onPressed: () {},
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
                      // 마커 아이콘
                      Icon(
                        Icons.location_on,
                        color: light02,
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ),
              Marker(
                point:
                    LatLng(-37.8225, 144.9689), // National Gallery of Victoria
                builder: (context) => GestureDetector(
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
                          top: -60,
                          left: -2,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    onPressed: () {},
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
                      // 마커 아이콘
                      Icon(
                        Icons.location_on,
                        color: light02,
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ),
              Marker(
                point: LatLng(-37.7747, 144.9980), // Melbourne Polytechnic
                builder: (context) => GestureDetector(
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
                          top: -60,
                          left: -2,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    onPressed: () {},
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
                      // 마커 아이콘
                      Icon(
                        Icons.location_on,
                        color: light02,
                        size: 50,
                      ),
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
