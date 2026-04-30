import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/localization/app_language.dart';
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

  // Dialog sudah disamakan dengan logout dialog
  Future confirmDelete(int id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B5E20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            context.tr("Hapus Exercise"),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(
            context.tr("Apakah anda yakin ingin menghapus exercise ini?"),
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          actionsPadding: const EdgeInsets.only(right: 12, bottom: 8),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                context.tr("Tidak"),
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await deleteExercise(id);
              },
              child: Text(
                context.tr("Ya"),
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
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
          context.tr(widget.day),
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

          child: exercises.isEmpty
              ? Center(
                  child: Text(
                    context.tr("No Exercise Yet"),
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 88),
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
                          exerciseData.exercise.displayName(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => exerciseData.page),
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
                              confirmDelete(routine['id']);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: _buildAddFab(onTap: openAddExercise),
    );
  }

  Widget _buildAddFab({required VoidCallback onTap}) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: FloatingActionButton(
        heroTag: 'add-routine-exercise',
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: onTap,
        child: const Icon(Icons.add_rounded, size: 30),
      ),
    );
  }
}
