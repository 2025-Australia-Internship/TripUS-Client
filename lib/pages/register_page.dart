import 'package:flutter/material.dart';
import 'package:tripus/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripus/pages/success_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Join',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 30),
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: light05,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xffD9D9D9),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.camera_alt),
                        color: MainColor,
                        iconSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 315,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nickname',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: light08, width: 2.5),
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/Check.svg',
                            ),
                          )),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'E-mail',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: light08, width: 2.5),
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/Check.svg',
                            ),
                          )),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light08, width: 2.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Check Password',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: light08, width: 2.5),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              SizedBox(
                width: 315,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SuccessPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: MainColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
