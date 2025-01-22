import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';

class LandmarkDetails extends StatefulWidget {
  final int id; // 전달받은 랜드마크 ID

  const LandmarkDetails({super.key, required this.id});

  @override
  State<LandmarkDetails> createState() => _LandmarkDetailsState();
}

class _LandmarkDetailsState extends State<LandmarkDetails> {
  Map<String, dynamic>? landmarkData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLandmarkData();
  }

  Future<void> fetchLandmarkData() async {
    final apiUrl = "${dotenv.env['BASE_URL']}/landmarks/${widget.id}";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        setState(() {
          landmarkData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load landmark data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // 로딩페이지
        ),
      );
    }

    if (landmarkData == null) {
      return Scaffold(
        body: Center(
          child: Text('Failed to load data'),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(landmarkData!['image']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: dark08,
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    right: 30,
                    child: Image(
                      image: AssetImage(landmarkData!['symbol']),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              landmarkData!['name'],
                              style: TextStyle(
                                color: MainColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              landmarkData!['address'],
                              style: TextStyle(
                                color: light05,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              landmarkData!['description'],
                              style: TextStyle(
                                color: dark06,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.favorite,
                                    color: error,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  '123',
                                  style: TextStyle(
                                    color: error,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 7),
                          SizedBox(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.bookmark_border,
                                    color: grey04,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  '567',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 2, height: 1, color: grey03),
                  SizedBox(height: 10),
                  Text(
                    'My memories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  // SizedBox(height: 13),
                  // Text(
                  //   '2024.12.25',
                  //   style: TextStyle(
                  //       color: MainColor,
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   width: 90,
                  //   height: 140,
                  //   color: grey02,
                  //   padding: EdgeInsets.all(10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         width: 70,
                  //         height: 95,
                  //         color: grey01,
                  //         margin: EdgeInsets.only(bottom: 5),
                  //       ),
                  //       Text(
                  //         'Today, I am happy:)',
                  //         style: TextStyle(
                  //             fontSize: 5, fontWeight: FontWeight.w400),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 1),
    );
  }
}
