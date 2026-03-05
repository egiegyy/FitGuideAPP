import 'package:flutter/material.dart';

class MyRoutine extends StatefulWidget {
  const MyRoutine({super.key});

  @override
  State<MyRoutine> createState() => _MyRoutineState();
}

class _MyRoutineState extends State<MyRoutine> {
  bool isMyRoutineSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(20),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Routine",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [Icon(Icons.notifications, color: Colors.white, size: 30)],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 155,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Monday",
                        style: TextStyle(
                          color: Color(0xff1F80FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Chest Press Machine, Lat Pulldown Machine, Leg Press Machine.",
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child:
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "see more>",
                            style: TextStyle(color: Color(0xff6C9E56)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    children: [Icon(Icons.add, color: Colors.white)],
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
