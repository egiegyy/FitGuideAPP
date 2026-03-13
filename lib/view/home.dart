import 'package:fitguide/database/preferance.dart';
import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/view/My%20Routine%20Page/routine.dart';
import 'package:fitguide/view/My%20Routine%20Page/routine_day.dart';
import 'package:fitguide/view/equipment.dart';
import 'package:fitguide/view/package.dart';
import 'package:fitguide/view/package/pullworkout.dart';
import 'package:fitguide/view/package/pushworkout.dart';
import 'package:fitguide/view/workoutTab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  List<String> routineDays = [];

  /// TEXT STYLE SYSTEM
  final TextStyle pageTitle = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  final TextStyle sectionTitle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  final TextStyle cardTitle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  final TextStyle bodyText = const TextStyle(
    fontSize: 14,
    color: Colors.white70,
  );

  final TextStyle buttonText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// GET USERNAME
  Future<void> getUser() async {
    final user = await UserPref.getCurrentUser();

    if (!mounted) return;

    setState(() {
      username = user?["username"] ?? "User";
    });
  }

  /// LOAD ROUTINE
  void loadRoutine() async {
    final data = await DBHelper.getRoutineDays();

    setState(() {
      routineDays = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    loadRoutine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Home", style: pageTitle),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// GREETING
              Text("Halo, $username", style: sectionTitle),

              Text("Today is your Push Day!", style: bodyText),

              const SizedBox(height: 20),

              /// POSTER
              SizedBox(
                height: 200,
                child: PageView(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/images/posterCompetition.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/images/posterCompetition2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// ROUTINE TITLE
              Text("Your Routine", style: sectionTitle),

              const SizedBox(height: 10),

              routineDays.isEmpty
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        children: [
                          Text(
                            "There is no Routine",
                            style: bodyText.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 10),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyRoutine(),
                                ),
                              );
                              loadRoutine();
                            },
                            child: Text("Add Routine", style: buttonText),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: routineDays.map((day) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),

                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.all(10),

                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.white),
                              ),

                              child: Column(
                                children: [
                                  Text(
                                    day,
                                    textAlign: TextAlign.center,
                                    style: cardTitle,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RoutineDayPage(day: day),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "More",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

              const SizedBox(height: 25),

              /// PACKAGE TITLE
              Text("Package Exercise", style: sectionTitle),

              const SizedBox(height: 10),

              ListTile(
                contentPadding: const EdgeInsets.all(5),

                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/ContohPushPullLeg.png"),
                ),

                title: Text("Push Workout", style: cardTitle),

                subtitle: Text(
                  "Push Pull Leg is a workout split that groups exercises based on movement patterns.",
                  style: bodyText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PushWorkout()),
                    );
                  },
                  child: const Text(
                    "More",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const Divider(color: Colors.white24),

              ListTile(
                contentPadding: const EdgeInsets.all(5),

                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/ContohPushPullLeg.png"),
                ),

                title: Text("Pull Workout", style: cardTitle),

                subtitle: Text(
                  "Push Pull Leg is a workout split that groups exercises based on movement patterns.",
                  style: bodyText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PullWorkout()),
                    );
                  },
                  child: const Text(
                    "More",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkoutPage()),
                    );
                  },
                  child: Text("See More", style: buttonText),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
