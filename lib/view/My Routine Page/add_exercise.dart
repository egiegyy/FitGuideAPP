import 'package:fitguide/database/sqflite.dart';
import 'package:flutter/material.dart';
import 'exercise_list.dart';

class AddExercisePage extends StatefulWidget {
  final String day;

  const AddExercisePage({super.key, required this.day});

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  Future addExercise(String exercise) async {
    final result = await DBHelper.insertRoutine(widget.day, exercise);

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$exercise already exists in ${widget.day}"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$exercise added to ${widget.day}"),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Exercise",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: allExercises.length,
        itemBuilder: (context, index) {
          final exercise = allExercises[index];

          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                exercise.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),

            title: Text(
              exercise.name,
              style: const TextStyle(color: Colors.white),
            ),

            trailing: IconButton(
              icon: const Icon(Icons.add, color: Colors.green),

              onPressed: () {
                addExercise(exercise.name);
              },
            ),
          );
        },
      ),
    );
  }
}
