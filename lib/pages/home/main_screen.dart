import 'package:fitguide/pages/home/home.dart';
import 'package:fitguide/pages/profile/profile.dart';
import 'package:fitguide/pages/scanner/scanner.dart';
import 'package:fitguide/pages/workout/workouts.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int _homeRefreshVersion = 0;
  int _scannerSession = 0;

  /// NAVIGATION FUNCTION
  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        _homeRefreshVersion++;
      }
      if (_selectedIndex != 2 && index == 2) {
        _scannerSession++;
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// PAGE SWITCHER
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(key: ValueKey(_homeRefreshVersion)),
          const WorkoutPage(),
          _selectedIndex == 2
              ? ScannerPage(key: ValueKey(_scannerSession))
              : const SizedBox.shrink(),
          ProfilePage(),
        ],
      ),

      /// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        elevation: 0,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF66BB6A),
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 26),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center, size: 26),
            label: "Workout",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined, size: 26),
            label: "Scanner",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 26),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
