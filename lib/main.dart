import 'package:fiba_3x3/pages/ball_info/ball.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/profile/profile.dart';
import 'pages/Auth/auth_main.dart';
import 'widgets/search.dart/search_event.dart';
import 'widgets/search.dart/search_player.dart';
import 'pages/rules/rules.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIBA 3X3',

      // ----- {{ Light Theme }} ----- //
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color.fromARGB(255, 56, 56, 56),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        primaryIconTheme: const IconThemeData(color: Colors.black),
        scaffoldBackgroundColor: Colors.white,
      ),
      // ----- {{ End Light Theme }} ----- //

      // ----- {{ Dark Theme }} ----- //
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        primaryIconTheme: const IconThemeData(color: Colors.white),
        cardColor: Colors.white,
      ),

      // ----- {{ End Dark Theme }} ----- //
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: AuthMain(onToggleTheme: _toggleTheme),
      routes: {
        '/home': (context) => Home(onToggleTheme: _toggleTheme),
        '/profile': (context) => ProfilePage(onToggleTheme: _toggleTheme),
        '/ball-info':
            (context) => Official3x3BallPage(onToggleTheme: _toggleTheme),
        '/rules': (context) => RulesPage(onToggleTheme: _toggleTheme),
        '/search-event': (context) => SearchEvent(onToggleTheme: _toggleTheme),
        '/search-player':
            (context) => SearchPlayer(onToggleTheme: _toggleTheme),
      },
    );
  }
}
