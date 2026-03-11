import 'package:fitguide/database/sqflite.dart';
import 'package:flutter/material.dart';
import 'add_exercise.dart';
import 'exercise_list.dart';

class RoutineDayPage extends StatefulWidget {
  final String day;

  const RoutineDayPage({super.key, required this.day});

  @override
  State<RoutineDayPage> createState() => _RoutineDayPageState();
}

class _RoutineDayPageState extends State<RoutineDayPage> {
  List<Map<String, dynamic>> exercises = [];

  @override
  void initState() {
    super.initState();
    loadRoutine();
  }

  Future loadRoutine() async {
    final data = await DBHelper.getRoutineByDay(widget.day);

    setState(() {
      exercises = data;
    });

    /// jika semua exercise sudah dihapus → kembali ke halaman sebelumnya
    if (data.isEmpty) {
      Navigator.pop(context);
    }
  }

  Future deleteExercise(int id) async {
    await DBHelper.deleteRoutine(id);

    loadRoutine();
  }

  Future openAddExercise() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddExercisePage(day: widget.day)),
    );

    loadRoutine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.day,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: exercises.isEmpty
                  ? const Center(
                      child: Text(
                        "No Exercise Yet",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final routine = exercises[index];

                        final exerciseData = allExercises.firstWhere(
                          (e) => e.name == routine['exercise'],
                          orElse: () => allExercises.first,
                        );

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                exerciseData.image,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              exerciseData.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => exerciseData.page,
                                ),
                              );
                            },
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                              onPressed: () {
                                deleteExercise(routine['id']);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            InkWell(
              onTap: openAddExercise,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white),
                ),
                child: const Column(
                  children: [Icon(Icons.add, color: Colors.white)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
