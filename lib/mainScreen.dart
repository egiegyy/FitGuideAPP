import 'package:flutter/material.dart';
import 'package:fitguide/view/home.dart';
import 'package:fitguide/view/equipment.dart';
import 'package:fitguide/view/scanner.dart';
import 'package:fitguide/view/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    Equipment(),
    Scanner(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: IndexedStack(index: _selectedIndex, children: pages),

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
