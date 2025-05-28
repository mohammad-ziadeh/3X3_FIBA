import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  Widget buildCard(BuildContext context, String imagePath) {
    return Stack(
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
                offset: Offset(0, 4),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
