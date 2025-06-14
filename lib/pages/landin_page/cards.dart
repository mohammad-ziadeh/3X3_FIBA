import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  Widget buildCard(BuildContext context, String imagePath) {
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        effect: const ShimmerEffect(
          baseColor: Color(0xFFE0E0E0),
          highlightColor: Color(0xFFF5F5F5),
        ),
      ),
      child: Skeletonizer(
        enabled: isLoading,

        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 390,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 5),
                        Text(
                          'W SERIES MARSEILLE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Marseille',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '23 May - 24 May',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -20,
              left: 10,
              child: Container(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  '#3X3WT',
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth;

    if (screenWidth < 1000) {
      cardWidth = screenWidth < 390 ? screenWidth * 0.9 : 390;
    } else {
      cardWidth = (screenWidth / 3) - 40;
      if (cardWidth > 300) cardWidth = 300;
    }

    final cards = [
      buildCard(context, 'assets/images/3x3one.png'),
      buildCard(context, 'assets/images/3x3two.jpeg'),
      buildCard(context, 'assets/images/3x3three.jpeg'),
    ];

    if (screenWidth < 1000) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:
              cards
                  .map(
                    (card) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35),
                      child: SizedBox(width: cardWidth, child: card),
                    ),
                  )
                  .toList(),
        ),
      );
    } else {
      return Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                cards
                    .map(
                      (card) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(width: cardWidth, child: card),
                      ),
                    )
                    .toList(),
          ),
        ),
      );
    }
  }
}
