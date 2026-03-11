import 'package:fitguide/view/exercise/chestPress.dart';
import 'package:fitguide/view/exercise/closeGripCP.dart';
import 'package:flutter/material.dart';

class PushWorkout extends StatefulWidget {
  const PushWorkout({super.key});

  @override
  State<PushWorkout> createState() => _PushWorkoutState();
}

class _PushWorkoutState extends State<PushWorkout> {
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
                "Push Workout",
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
          
              /// CHEST PRESS
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/Chest Press.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
          
                title: const Text(
                  "Chest Press",
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
                      MaterialPageRoute(builder: (context) => ChestPressPage()),
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
          
              /// CLOSE GRIP CHEST PRESS
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/Chest Press.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
          
                title: const Text(
                  "Close Grip Chest Press",
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
                      MaterialPageRoute(builder: (context) => CloseGripCPPage()),
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
