import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modal/modal.dart';
import '../../../provider/provider.dart';

class PlanetPage extends StatefulWidget {
  const PlanetPage({super.key});

  @override
  _PlanetPageState createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _rotationAnimation =
        Tween<double>(begin: 0, end: 6.28).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.only(top: 18.0, left: 15),
          child: Text(
            'Outer Space',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 15),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/favorites');
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                )),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF000000),
          // image: DecorationImage(
          //   fit: BoxFit.fill,
          //   image: AssetImage('assets/images/spaceBg.jpg'),
          // ),
        ),
        child: Provider.of<PlanetProvider>(context).planetModel == null
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white70),
              )
            : Consumer<PlanetProvider>(
                builder: (context, provider, child) {
                  List<Planet> planets = provider.planetModel!.planets;
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28, top: 15),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF191c1e),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4.0, left: 15),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  'Search Anything...',
                                  style: TextStyle(
                                      color: Colors.white60,
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 28.0, top: 20),
                            child: Text(
                              'World Beyond Our \nComprehension',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.of(context).pushNamed('/seeAll');
                          //   },
                          //   child: const Padding(
                          //     padding: EdgeInsets.only(top: 18.0),
                          //     child: Text(
                          //       'See All',
                          //       style: TextStyle(
                          //         color: Colors.white54,
                          //         fontSize: 14,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: planets.length,
                          itemBuilder: (context, index) {
                            Planet planet = planets[index];
                            bool isFavorite = provider.favoritePlanetIds.contains(
                                "${planet.id}-${planet.name}-${planet.image}-${planet.short_des}");
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/planetDetail',
                                    arguments: planet);
                              },
                              child: SizedBox(
                                height: 548,
                                width: 400,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 300,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: const Color(0xFF191c1e),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Spacer(),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                  onPressed: () {
                                                    provider
                                                        .toggleFavorite(planet);
                                                  },
                                                  icon: Icon(
                                                    provider.isFavorite(planet)
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_border_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  planet.short_des,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: 1.5,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  ' The ${planet.name}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 35,
                                                    letterSpacing: 1.5,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  '  The basics knowledge of The ${planet.name}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Positioned(
                                          top: 50,
                                          left: 52,
                                          child: AnimatedBuilder(
                                            animation: _animationController,
                                            builder: (context, child) {
                                              return Transform.rotate(
                                                angle: _rotationAnimation.value,
                                                child: Hero(
                                                  tag:
                                                      'planetImage_${planet.id}',
                                                  // Unique tag for the Hero widget
                                                  child: Container(
                                                    height: 305,
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            planet.image),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
