import 'dart:async';

import 'package:flutter/material.dart';
import 'package:space_app/view/screens/home/home_page.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4
    ), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const PlanetPage(),
      ));
    });
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff0E111A),
      // Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 0.15,
              width: w * 0.55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/space.jpg'),
                ),
              ),
            ),
            Text(
              'Space App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
