import 'package:fitguide/view/exercise/closeGripLP.dart';
import 'package:fitguide/view/exercise/wideGripLP.dart';
import 'package:flutter/material.dart';

class PullWorkout extends StatefulWidget {
  const PullWorkout({super.key});

  @override
  State<PullWorkout> createState() => _PullWorkoutState();
}

class _PullWorkoutState extends State<PullWorkout> {
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
                "Pull Workout",
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

              /// CLOSE GRIP LAT PULLDOWN
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/Close Grip Lat Pulldown.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),

                title: const Text(
                  "Close Grip Lat Pulldown",
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
                        builder: (context) => CloseGripLatPulldownPage(),
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

              /// WIDE GRIP LAT PULLDOWN
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/Lat Pulldown.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),

                title: const Text(
                  "Wide Grip Lat Pulldown",
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
                        builder: (context) => WideGripLatPulldownPage(),
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
