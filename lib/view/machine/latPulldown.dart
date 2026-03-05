import 'dart:math';
import 'package:flutter/material.dart';

class LatPulldown extends StatefulWidget {
  const LatPulldown({super.key});

  @override
  State<LatPulldown> createState() => _LatPulldownState();
}

class _LatPulldownState extends State<LatPulldown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Workout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: const [
          Icon(Icons.search_rounded, color: Colors.white, size: 30),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/lat pulldown machine.png"),
            ),
            const SizedBox(height: 10),
            const Text(
              "Lat Pulldown Machine",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(800),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "Alat gym untuk melatih otot punggung dengan gerakan menarik bar dari atas ke arah dada. Latihan ini membantu memperkuat dan membentuk punggung bagian atas. Otot utama yang dilatih adalah latissimus dorsi, dengan bantuan biceps dan bahu belakang.",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Exercise",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: ListTile(
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/images/latPulldown.png"),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow_rounded, size: 30),
                    ),
                  ],
                ),
                title: const Text(
                  "Lat Pulldown",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "see more>",
                    style: TextStyle(color: Color(0xff6C9E56)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
