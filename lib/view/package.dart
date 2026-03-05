import 'package:fitguide/view/home.dart';
import 'package:fitguide/view/equipment.dart';
import 'package:flutter/material.dart';

class Package extends StatefulWidget {
  const Package({super.key});

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  bool isMyRoutineSelected = false;

  int _selectedIndex = 1;

  final List<Map<String, dynamic>> programWorkout = [
    {
      "name": "Bench Press",
      "level": "Beginner",
      "type": "Push",
      "image": "assets/images/ContohPushPullLeg.png",
    },
    {
      "name": "Lat Pulldown",
      "level": "Beginner",
      "type": "Pull",
      "image": "assets/images/ContohPushPullLeg.png",
    },
    {
      "name": "Seated Cable Row",
      "level": "Beginner",
      "type": "Pull",
      "image": "assets/images/ContohPushPullLeg.png",
    },
    {
      "name": "Pull Up",
      "level": "Intermediate",
      "type": "Pull",
      "image": "assets/images/ContohPushPullLeg.png",
    },
    {
      "name": "Leg Press",
      "level": "Beginner",
      "type": "Leg",
      "image": "assets/images/ContohPushPullLeg.png",
    },
    {
      "name": "Romanian Deadlift",
      "level": "Intermediate",
      "type": "Leg",
      "image": "assets/images/ContohPushPullLeg.png",
    },
    {
      "name": "Push Up",
      "level": "Beginner",
      "type": "Full Body",
      "image": "assets/images/ContohFullBody.png",
    },
    {
      "name": "Plank",
      "level": "Beginner",
      "type": "Full Body",
      "image": "assets/images/ContohFullBody.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Workout",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isMyRoutineSelected
                          ? const Color(0xff6C9E56)
                          : Colors.transparent,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Equipment(),
                        ),
                      );

                      setState(() {
                        isMyRoutineSelected = true;
                      });
                    },
                    child: const Text(
                      "Equipment",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isMyRoutineSelected
                          ? const Color(0xff6C9E56)
                          : Colors.transparent,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      setState(() {
                        isMyRoutineSelected = false;
                      });
                    },
                    child: const Text(
                      "Package",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: programWorkout.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = programWorkout[index];

                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(80),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                        ),
                        title: Text(
                          data["name"],
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          data["type"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
