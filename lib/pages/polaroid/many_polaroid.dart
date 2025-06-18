import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/widgets/bottom_navigation.dart';

class ManyPolaroid extends StatelessWidget {
  const ManyPolaroid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: 315,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [grey02, Color(0xff737373)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: dark08,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 315,
              child: Row(
                children: [
                  Container(
                    width: 105,
                    height: 105,
                    color: grey02,
                  ),
                  Container(
                    width: 105,
                    height: 105,
                    color: grey03,
                  ),
                  Container(
                    width: 105,
                    height: 105,
                    color: grey01,
                    child: const Icon(Icons.add, size: 25),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(initialIndex: 2),
    );
  }
}
