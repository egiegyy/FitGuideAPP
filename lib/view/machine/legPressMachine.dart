import 'package:fitguide/view/exercise/legPress.dart';
import 'package:fitguide/view/exercise/legPressCalfRaise.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("assets/images/Leg Press Machine.png"),
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
                  color: Colors.white.withAlpha(800),
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

              /// LEG PRESS
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LegPressPage(),
                    ),
                  );
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/Leg Press.png"),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LegPressPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "More",
                    style: TextStyle(
                      color: Color(0xff6C9E56),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// LEG PRESS CALF RAISE
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LegPressCalfRaisePage(),
                    ),
                  );
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/Leg Press.png"),
                ),
                title: const Text(
                  "Leg Press Calf Raise",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LegPressCalfRaisePage(),
                      ),
                    );
                  },
                  child: const Text(
                    "More",
                    style: TextStyle(
                      color: Color(0xff6C9E56),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
