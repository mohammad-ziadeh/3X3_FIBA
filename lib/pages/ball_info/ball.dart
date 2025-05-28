import 'package:fiba_3x3/widgets/appBar.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Official3x3BallPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const Official3x3BallPage({super.key, required this.onToggleTheme});

  @override
  State<Official3x3BallPage> createState() => _Official3x3BallPageState();
}

class _Official3x3BallPageState extends State<Official3x3BallPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'wHj9oL8nZqY',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(onToggleTheme: widget.onToggleTheme),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/ball-Info.jpeg',
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  top: 20,
                  left: 16,
                  right: 16,
                  child: Text(
                    "OFFICIAL 3X3 BALL",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 7),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: YoutubePlayer(controller: _controller),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 7),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: const Text(
                            "UNIQUE GAME, UNIQUE BALL. Wilson paired their patented Wave Triple Threat Technology with a smaller ball spec to engineer a basketball with the kind of grip and control the energy of the 3x3 game demands",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    "SIZE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "6",
                                    style: TextStyle(
                                      fontSize: 48,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: const [
                                  Text(
                                    "WEIGHT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "7",
                                    style: TextStyle(
                                      fontSize: 48,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: const [
                                  Text(
                                    "FEATURES",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Weather-proof",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Fast-pace ready",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Optimised grip",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Urban design",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 7),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/ball-info-image.jpeg',
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: const CustomDrawer(),
    );
  }
}
