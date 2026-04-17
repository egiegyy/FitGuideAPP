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

    if (!mounted) return;
    setState(() {
      exercises = data;
    });

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

    if (!mounted) return;
    loadRoutine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.day,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
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

          child: Column(
            children: [
              Expanded(
                child: exercises.isEmpty
                    ? const Center(
                        child: Text(
                          "No Exercise Yet",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
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
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(13),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,

                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  exerciseData.image,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              title: Text(
                                exerciseData.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
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

                              trailing: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(20),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
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
                            ),
                          );
                        },
                      ),
              ),

              InkWell(
                onTap: openAddExercise,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(13),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.add, color: Color(0xFF66BB6A), size: 28),
                    ],
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
