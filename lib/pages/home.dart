import 'package:fiba_3x3/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'landin_page/landingPage.dart';
import 'package:fiba_3x3/pages/landin_page/socialMediaBar.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';

class Home extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const Home({super.key, required this.onToggleTheme});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(onToggleTheme: widget.onToggleTheme),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [MainPage(), const SizedBox(height: 20), SocialMediaBar()],
        ),
      ),
      endDrawer: const CustomDrawer(),
    );
  }
}
