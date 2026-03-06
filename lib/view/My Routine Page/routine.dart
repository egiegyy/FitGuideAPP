import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/view/My%20Routine%20Page/add_exercise.dart';
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

    /// hanya tampilkan hari yang belum dipakai
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
          title: const Text("Select Day"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: availableDays.map((d) {
              return ListTile(
                title: Text(d),
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
        MaterialPageRoute(builder: (_) => RoutineDayPage(day: day)),
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white),
        ),
        child: const Column(children: [Icon(Icons.add, color: Colors.white)]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Routine",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: days.isEmpty
            /// jika belum ada routine
            ? Column(children: [addButton()])
            /// jika sudah ada routine
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: days.length,
                      itemBuilder: (context, index) {
                        final day = days[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),

                          child: InkWell(
                            onTap: () {
                              openDay(day);
                            },

                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 90,

                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.white),
                              ),

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    day,
                                    style: const TextStyle(
                                      color: Color(0xff1F80FF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),

                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// tombol tambah otomatis berada di bawah list
                  addButton(),
                ],
              ),
      ),
    );
  }
}
