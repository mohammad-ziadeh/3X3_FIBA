import 'package:flutter/material.dart';
import 'package:fiba_3x3/pages/page1.dart';

class MainPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const MainPage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyWidget(),
    Center(child: Text("Attendance Page", style: TextStyle(fontSize: 20))),
    Center(
      child: Text("Wheel of Fortune Page", style: TextStyle(fontSize: 20)),
    ),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/3x3Logo.svg', width: 50),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_mode),
            label: 'Wheel of Fortune',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
