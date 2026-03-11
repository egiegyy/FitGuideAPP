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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> getUser() async {
    String? user = await UserPref.getLoginUser();

    if (!mounted) return;

    setState(() {
      username = user ?? "User";
    });
  }

  /// LOAD ROUTINE FROM DATABASE
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
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Halo, $username",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              Text(
                "today is your Push Day!",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),

              SizedBox(height: 20),

              /// POSTER
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 300,

                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(15),

                        child: Image.asset(
                          "assets/images/posterCompetition.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    SizedBox(
                      height: 200,
                      width: 300,

                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(15),

                        child: Image.asset(
                          "assets/images/posterCompetition2.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              /// YOUR ROUTINE
              Text(
                "Your routine",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              /// IF ROUTINE EMPTY
              routineDays.isEmpty
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        children: [
                          Text(
                            "There is no Routine",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 10),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),

                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyRoutine(),
                                ),
                              );

                              /// reload routine setelah user membuat routine
                              loadRoutine();
                            },

                            child: Text(
                              "Add Routine",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  /// SHOW USER ROUTINE
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      child: Row(
                        children: routineDays.map((day) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10),

                            child: Container(
                              width: 150,
                              padding: EdgeInsets.all(10),

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
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),

                                  Text(
                                    "Your custom workout",
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
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

                                      child: Text(
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

              SizedBox(height: 20),

              /// PACKAGE EXERCISE
              Text(
                "Package Exercise",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              /// PACKAGE LIST
              ListTile(
                contentPadding: EdgeInsets.all(5),

                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset("assets/images/ContohPushPullLeg.png"),
                ),
                title: Text(
                  "Pull Workout",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                subtitle: Text(
                  "Push Pull Leg is a workout split that groups exercises based on movement patterns: Push trains chest, shoulders, and triceps; Pull trains back and biceps; and Leg focuses on lower body muscles like thighs and glutes.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
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
                  child: Text(
                    "More",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Divider(),

              ListTile(
                contentPadding: EdgeInsets.all(5),

                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset("assets/images/ContohPushPullLeg.png"),
                ),
                title: Text(
                  "Pull Workout",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                subtitle: Text(
                  "Push Pull Leg is a workout split that groups exercises based on movement patterns: Push trains chest, shoulders, and triceps; Pull trains back and biceps; and Leg focuses on lower body muscles like thighs and glutes.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
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
                  child: Text(
                    "More",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

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

                  child: Text(
                    "See More",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
