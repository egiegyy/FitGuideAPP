import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/pages/profile/routine/add_exercise.dart';
import 'package:flutter/material.dart';
import 'routine_day.dart';

class MyRoutine extends StatefulWidget {
  const MyRoutine({super.key});

  @override
  State<MyRoutine> createState() => _MyRoutineState();
}

class _MyRoutineState extends State<MyRoutine> {
  List<String> days = [];

  @override
  void initState() {
    super.initState();
    loadDays();
  }

  Future loadDays() async {
    final data = await DBHelper.getRoutineDays();

    setState(() {
      days = data;
    });
  }

  Future chooseDay() async {
    List<String> allDays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    List<String> availableDays = allDays
        .where((d) => !days.contains(d))
        .toList();

    if (availableDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All days already have routine")),
      );
      return;
    }

    final day = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B5E20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            "Select Day",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: availableDays.map((d) {
              return ListTile(
                title: Text(d, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context, d);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (day != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddExercisePage(day: day)),
      );

      loadDays();
    }
  }

  Future openDay(String day) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RoutineDayPage(day: day)),
    );

    loadDays();
  }

  Widget addButton() {
    return InkWell(
      onTap: () {
        chooseDay();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24),
        ),
        child: const Column(
          children: [Icon(Icons.add, color: Color(0xFF66BB6A), size: 28)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Routine",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
          child: days.isEmpty
              ? Column(children: [addButton()])
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          final day = days[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),

                            child: InkWell(
                              onTap: () {
                                openDay(day);
                              },

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                height: 90,

                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(13),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: Colors.white24),
                                ),

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text(
                                      day,
                                      style: const TextStyle(
                                        color: Color(0xFF66BB6A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),

                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white70,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    addButton(),
                  ],
                ),
        ),
      ),
    );
  }
}
