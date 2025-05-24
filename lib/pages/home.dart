import 'package:flutter/material.dart';
import 'landin_page/landingPage.dart';
import 'package:fiba_3x3/pages/landin_page/socialMediaBar.dart';
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
        title: SvgPicture.asset('assets/images/3x3Logo.svg', height: 53),
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
      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 70,
                padding: EdgeInsets.all(16),
                color: Color.fromARGB(255, 34, 34, 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 70,
                      child: SvgPicture.asset('assets/images/3x3Logo.svg'),
                    ),
                    Builder(
                      builder:
                          (context) => IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            padding: EdgeInsets.only(bottom: 8, left: 13),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _buildMenuItem('HOME', Icons.arrow_forward_ios_outlined),
                    _buildMenuItem('3x3', Icons.arrow_forward_ios_outlined),
                    _buildMenuItem('EVENTS', Icons.arrow_forward_ios_outlined),
                    _buildMenuItem(
                      'RANKINGS',
                      Icons.arrow_forward_ios_outlined,
                    ),
                    _buildMenuItem(
                      'OLYMPICS',
                      Icons.arrow_forward_ios_outlined,
                    ),
                    _buildMenuItem('NEWS', Icons.arrow_forward_ios_outlined),
                    _buildMenuItem('PLAYERS', Icons.arrow_forward_ios_outlined),
                    _buildMenuItem(
                      'ORGANIZERS',
                      Icons.arrow_forward_ios_outlined,
                    ),
                    _buildMenuItem(
                      'FEDERATIONS',
                      Icons.arrow_forward_ios_outlined,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.black,
                height: 70,
                width: double.infinity,
                child: Text(
                  'FIBA.BASKETBALL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      trailing: Icon(icon, color: Colors.white, size: 18),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
