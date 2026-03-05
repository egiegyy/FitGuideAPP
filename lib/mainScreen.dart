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

  final List<Map<String, dynamic>> pages = [
    {"icon": Icons.home, "label": "Home", "page": const HomePage()},
    {
      "icon": Icons.fitness_center,
      "label": "Workout",
      "page": const Equipment(),
    },
    {
      "icon": Icons.qr_code_scanner_outlined,
      "label": "Scanner",
      "page": const Scanner(),
    },
    {"icon": Icons.person, "label": "Profile", "page": const ProfilePage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: pages[_selectedIndex]["page"],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: List.generate(pages.length, (index) {
          return BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                pages[index]["icon"],
                color: _selectedIndex == index ? Colors.blue : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                });

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => pages[index]["page"]),
                );
              },
            ),
            label: pages[index]["label"],
          );
        }),
      ),
    );
  }
}
