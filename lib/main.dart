// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:space_app/view/screens/home/home_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       getPages: [
//         GetPage(name: '/', page: () => HomePage()),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:space_app/provider/provider.dart';
import 'package:space_app/view/screens/favourite/favorite_page.dart';
import 'package:space_app/view/screens/home/home_page.dart';
import 'package:space_app/view/screens/planet_detail/planet_detail.dart';
import 'package:space_app/view/screens/splash_screen/splash_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlanetProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Solar System Planets',
        routes: {
          '/': (context) => const SplashPage(),
          '/planet': (context) => const PlanetPage(),
          '/favorites': (context) => FavoritesPage(),
          '/planetDetail': (context) => PlanetDetailPage(),
        },
      ),
    );
  }
}