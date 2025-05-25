import 'package:flutter/material.dart';
import 'landin_page/landingPage.dart';
import 'package:fiba_3x3/pages/landin_page/socialMediaBar.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: SvgPicture.asset('assets/images/3x3Logo.svg', height: 53),
            ),

            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/profile');
              },
              child: Text('Profile', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
          if (MediaQuery.of(context).size.width < 600)
            Builder(
              builder:
                  (context) => IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
            ),
        ],
      ),
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
