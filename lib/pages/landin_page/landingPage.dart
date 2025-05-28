import 'package:flutter/material.dart';
import 'package:fiba_3x3/pages/landin_page/carousel.dart';
import 'package:fiba_3x3/pages/landin_page/cards.dart';
import 'package:fiba_3x3/pages/landin_page/socialIcons.dart';
// import 'package:fiba_3x3/components/promote.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselWidget(),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NEXT EVENTS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          SizedBox(height: 40),
          EventCard(),
          SocialFollowSection(),
          // Promote(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
