import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripUS',
      home: const HomePage(title: 'LOGO'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageStatet();
}

class _HomePageStatet extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGO'),
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          )
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: 123,
              height: 144,
              color: Colors.blueGrey,
              margin: EdgeInsets.fromLTRB(0, 100, 0, 90),
            ),
            Container(
              width: 315,
              height: 58,
              color: Colors.blueGrey,
            ),
            Container(
              width: 315,
              height: 245,
              color: Colors.blueGrey,
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            ),
            Container(
              width: 315,
              height: 245,
              color: Colors.blueGrey,
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
