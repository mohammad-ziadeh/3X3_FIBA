import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class SearchPlayerEvent extends StatelessWidget {
  const SearchPlayerEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () {},
            child: HoverContainer(
              width: 420,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: const Color.fromARGB(255, 31, 31, 31),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              hoverDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: const Color.fromARGB(255, 0, 72, 197),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Events",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Start your way to the top by playing in your local events",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () {},
            child: HoverContainer(
              width: 420,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: const Color.fromARGB(255, 31, 31, 31),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              hoverDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: const Color.fromARGB(255, 0, 72, 197),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Players",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Create your own profile, be visible to the 3x3 family around the world",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
