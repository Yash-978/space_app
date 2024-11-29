
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modal/modal.dart';
import '../../../provider/provider.dart';


class PlanetDetailPage extends StatefulWidget {
  @override
  _PlanetDetailPageState createState() => _PlanetDetailPageState();
}

class _PlanetDetailPageState extends State<PlanetDetailPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();


    _rotationAnimation = Tween<double>(begin: 0, end: 6.28).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Planet planet = ModalRoute.of(context)!.settings.arguments as Planet;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
              _animationController.dispose();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'The ${planet.name}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'planetImage_${planet.id}',
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Image.asset(
                        planet.image,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  context.watch<PlanetProvider>().isFavorite(planet)
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<PlanetProvider>().toggleFavorite(planet);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'The ${planet.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              planet.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Distance from Sun : ${planet.distanceFromSun}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'Gravity : ${planet.gravity}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'Diameter : ${planet.diameter}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'Moons : ${planet.moons}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
