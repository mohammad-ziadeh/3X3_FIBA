import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: GoogleFonts.bebasNeueTextTheme(ThemeData.light().textTheme),
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
        iconTheme: const IconThemeData(color: Color(0xFF3B1E54)),
        primaryIconTheme: const IconThemeData(color: Color(0xFF3B1E54)),
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
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 121, 60, 174),
        ),
        primaryIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 121, 60, 174),
        ),
        cardColor: const Color(0xFF3B1E54),
      ),

      // ----- {{ End Dark Theme }} ----- //
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(onToggleTheme: _toggleTheme),
        // '/login': (context) => Login(),
        // '/home': (context) => MainPage(onToggleTheme: _toggleTheme),
        // '/attendance': (context) => Attendance(),
        // '/students': (context) => StudentsPage(onToggleTheme: _toggleTheme),
      },
    );
  }
}
