import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:tripus/constants/colors.dart';
import 'package:tripus/main.dart';

class Base64ImageWidget extends StatelessWidget {
  final String base64String;
  final double width;
  final double height;
  final BoxFit fit;

  const Base64ImageWidget({
    Key? key,
    required this.base64String,
    this.width = 260.0,
    this.height = 300.0,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (base64String.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Icon(Icons.person, color: Colors.grey[400]),
      );
    }
    try {
      final bytes =
          base64.decode(base64String.replaceAll(RegExp(r'[\n\r\s]'), ''));

      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(bytes),
            fit: fit,
          ),
        ),
      );
    } catch (e) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Icon(Icons.error, color: Colors.grey[400]),
      );
    }
  }
}

class OnePolaroid extends StatefulWidget {
  final int polaroidId;

  const OnePolaroid({
    Key? key,
    required this.polaroidId,
    required String photoUrl,
    required String caption,
    required Color backgroundColor,
  }) : super(key: key);

  @override
  State<OnePolaroid> createState() => _OnePolaroidState();
}

class _OnePolaroidState extends State<OnePolaroid> {
  int? polaroidId; // State에서 관리하는 폴라로이드 ID
  String photoUrl = '';
  String caption = '';
  Color backgroundColor = Colors.white;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPolaroidId();
  }

  Future<void> fetchPolaroidId() async {
    final String apiUrl =
        '${dotenv.env['BASE_URL']}/polaroids/${widget.polaroidId}';

    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'jwt');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final fetchedPolaroidId = data['id']; // API에서 ID를 받아오기
      setState(() {
        polaroidId = fetchedPolaroidId;
      });
    } else {
      print('Failed to load polaroid IDs');
    }
  }

  Future<void> loadUserProfile() async {
    if (polaroidId == null) return; // polaroidId가 없으면 return

    try {
      final String apiUrl = '${dotenv.env['BASE_URL']}/polaroids/$polaroidId';

      const storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'jwt');

      if (accessToken == null) {
        print("access token not found");
        return;
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          photoUrl = data['photo_url'];
          caption = data['caption'];
          backgroundColor = Color(int.parse('0xff${data['backgroundColor']}'));
          isLoading = false;
        });
      } else {
        print('Failed to load polaroid: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (error) {
      print('Error fetching polaroid: $error');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Polaroid',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: dark08,
            icon: Icon(Icons.close_rounded),
            iconSize: 25,
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 460,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: grey02,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(height: 20),
                    Base64ImageWidget(
                      base64String: photoUrl,
                      width: 260,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    // 캡션 표시
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        caption,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
