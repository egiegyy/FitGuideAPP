import 'package:fitguide/view/package/fullbodyworkout.dart';
import 'package:fitguide/view/package/legworkout.dart';
import 'package:fitguide/view/package/pullworkout.dart';
import 'package:fitguide/view/package/pushworkout.dart';
import 'package:flutter/material.dart';

class Package extends StatefulWidget {
  Package({super.key});

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// PUSH
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Image.asset("assets/images/Leg Press.png"),
                  title: Text(
                    "Push",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
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
                        color: Color(0xff6C9E56),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          
              /// PULL
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Image.asset("assets/images/Leg Press.png"),
                  title: Text(
                    "Pull",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
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
                        color: Color(0xff6C9E56),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          
              /// LEG
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Image.asset("assets/images/Leg Press.png"),
                  title: Text(
                    "Leg",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LegWorkout()),
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
              ),
          
              /// FULL BODY
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Image.asset("assets/images/Leg Press.png"),
                  title: Text(
                    "Full Body",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullBodyWorkout(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
