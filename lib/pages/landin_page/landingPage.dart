// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:fiba_3x3/pages/landin_page/carousel.dart';
import 'package:fiba_3x3/pages/landin_page/event_cards/cards.dart';
import 'package:fiba_3x3/pages/landin_page/socialIcons.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final GlobalKey<EventCardState> _eventCardKey = GlobalKey<EventCardState>();

  Future<void> refreshEventCard() async {
    await _eventCardKey.currentState?.refreshEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselWidget(),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'NEXT EVENTS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 40),
          EventCard(key: _eventCardKey),
          SocialFollowSection(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
