import 'dart:math';
import 'package:flutter/material.dart';

class LegPress extends StatefulWidget {
  const LegPress({super.key});

  @override
  State<LegPress> createState() => _LegPressState();
}

class _LegPressState extends State<LegPress> {
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
              child: Image.asset("assets/images/leg press machine.png"),
            ),
            const SizedBox(height: 10),
            const Text(
              "Leg Press Machine",
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
                "Alat gym untuk melatih kekuatan otot kaki dengan gerakan mendorong beban menggunakan kaki pada posisi duduk atau setengah berbaring. Latihan ini menargetkan quadriceps sebagai otot utama, serta melibatkan glutes dan hamstrings sebagai otot pendukung.",
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
                      child: Image.asset("assets/images/legPress.png"),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow_rounded, size: 30),
                    ),
                  ],
                ),
                title: const Text(
                  "Leg Press",
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
