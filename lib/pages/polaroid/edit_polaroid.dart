import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tripus/colors.dart';
import 'package:tripus/main.dart';

class EditPolaroid extends StatefulWidget {
  const EditPolaroid({super.key});

  @override
  State<EditPolaroid> createState() => _EditPolaroidState();
}

class _EditPolaroidState extends State<EditPolaroid> {
  Color _color = Colors.white;

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              width: 300,
              height: 460,
              decoration: BoxDecoration(
                color: _color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    spreadRadius: 3,
                    offset: Offset(3, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 100),
                child: Container(
                  color: grey01,
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_color != Color(0xffFF6D6D)) {
                            _color = Color(0xffFF6D6D);
                          } else {
                            _color = Colors.white;
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffFF6D6D),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_color != Color(0xffFFCB71)) {
                            _color = Color(0xffFFCB71);
                          } else {
                            _color = Colors.white;
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffFFCB71),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_color != Color(0xffFDFF72)) {
                            _color = Color(0xffFDFF72);
                          } else {
                            _color = Colors.white;
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffFDFF72),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_color != Color(0xff9BFF76)) {
                            _color = Color(0xff9BFF76);
                          } else {
                            _color = Colors.white;
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff9BFF76),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_color != Color(0xff8DE8FF)) {
                            _color = Color(0xff8DE8FF);
                          } else {
                            _color = Colors.white;
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff8DE8FF),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_color != Color(0xffCE7BFF)) {
                            _color = Color(0xffCE7BFF);
                          } else {
                            _color = Colors.white;
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffCE7BFF),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
