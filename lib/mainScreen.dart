import 'package:fitguide/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:fitguide/view/home.dart';
import 'package:fitguide/view/workoutTab.dart';
import 'package:fitguide/view/scanner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  /// LIST PAGE UTAMA
  final List<Widget> pages = [
    /// HOME
    HomePage(),

    /// WORKOUT
    WorkoutPage(),

    /// SCANNER
    ScannerPage(),

    /// PROFILE
    ProfilePage(),
  ];

  /// NAVIGATION FUNCTION
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// PAGE SWITCHER
      body: IndexedStack(index: _selectedIndex, children: pages),

      /// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,

        currentIndex: _selectedIndex,

        selectedItemColor: Colors.blue,

        unselectedItemColor: Colors.white,

        type: BottomNavigationBarType.fixed,

        onTap: _onItemTapped,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Workout",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: "Scanner",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
