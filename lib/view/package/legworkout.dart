import 'package:fitguide/view/exercise/legPress.dart';
import 'package:fitguide/view/exercise/legPressCalfRaise.dart';
import 'package:flutter/material.dart';

class LegWorkout extends StatefulWidget {
  const LegWorkout({super.key});

  @override
  State<LegWorkout> createState() => _LegWorkoutState();
}

class _LegWorkoutState extends State<LegWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Package",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: 150,
                width: 150,
                decoration: BoxDecoration(),
          
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: Image.asset("assets/images/ContohPushPullLeg.png"),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text(
                "Leg Workout",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
          
              Text(
                "Created by FitGuide",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
          
              Divider(),
          
              /// LEG PRESS
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/Leg Press.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
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
                      MaterialPageRoute(builder: (context) => LegPressPage()),
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
          
              Divider(),
          
              /// LEG PRESS CALF RAISE
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/Leg Press.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
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
                        builder: (context) => LegPressCalfRaisePage(),
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
          
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
