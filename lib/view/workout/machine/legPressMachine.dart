import 'package:fitguide/view/workout/exercise/legPress.dart';
import 'package:fitguide/view/workout/exercise/legPressCalfRaise.dart';
import 'package:flutter/material.dart';

class LegPressMachine extends StatefulWidget {
  const LegPressMachine({super.key});

  @override
  State<LegPressMachine> createState() => _LegPressMachineState();
}

class _LegPressMachineState extends State<LegPressMachine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Workout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        actions: const [
          Icon(Icons.search_rounded, color: Colors.white, size: 30),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF0A0F0A),
              Color(0xFF101810),
              Color(0xFF000000),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset("assets/images/Leg Press Machine.png"),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Leg Press Machine",
                  style: TextStyle(
                    color: Color(0xFF66BB6A),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(13),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white24),
                  ),

                  child: const Text(
                    "Alat gym untuk melatih kekuatan otot kaki dengan gerakan mendorong beban menggunakan kaki pada posisi duduk atau setengah berbaring. Latihan ini menargetkan quadriceps sebagai otot utama, serta melibatkan glutes dan hamstrings sebagai otot pendukung.",
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Exercise",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 20),

                /// LEG PRESS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(13),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white24),
                  ),

                  child: ListTile(
                    contentPadding: EdgeInsets.zero,

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LegPressPage(),
                        ),
                      );
                    },

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/Leg Press.png",
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: const Text(
                      "Leg Press",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        "More",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// LEG PRESS CALF RAISE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(13),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white24),
                  ),

                  child: ListTile(
                    contentPadding: EdgeInsets.zero,

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LegPressCalfRaisePage(),
                        ),
                      );
                    },

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/Leg Press.png",
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: const Text(
                      "Leg Press Calf Raise",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        "More",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
