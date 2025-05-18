import 'package:flutter/material.dart';
import 'package:fiba_3x3/components/carousel.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Some data above carousel'),

          CarouselWidget(),

          const Text('More content below carousel'),
        ],
      ),
    );
  }
}
