import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/utils/ui_components.dart';
import 'package:flutter/material.dart';
import 'exercise_list.dart';

class AddExercisePage extends StatefulWidget {
  final String day;
  const AddExercisePage({super.key, required this.day});

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  // Menyimpan exercise yang sudah dipilih
  final Set<String> selectedExercises = {};

  Future addExercise(String exercise) async {
    // Hindari double klik
    if (selectedExercises.contains(exercise)) return;

    final result = await DBHelper.insertRoutine(widget.day, exercise);

    if (!mounted) return;

    if (result == null) {
      // Jika sudah ada di database
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$exercise already exists in ${widget.day}"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Jika berhasil ditambahkan
      UIComponents.showSuccessSnackBar(
        context,
        "$exercise added to ${widget.day}",
      );

      // Tandai sebagai sudah dipilih
      setState(() {
        selectedExercises.add(exercise);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Exercise",
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: allExercises.length,
          itemBuilder: (context, index) {
            final exercise = allExercises[index];

            // Cek apakah sudah dipilih
            final bool isSelected =
                selectedExercises.contains(exercise.name);

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                // Jika sudah dipilih, ubah warna jadi abu-abu
                color: isSelected
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.white.withAlpha(13),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white24),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,

                // Gambar dibuat redup jika sudah dipilih
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Opacity(
                    opacity: isSelected ? 0.5 : 1,
                    child: Image.asset(
                      exercise.image,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Text ikut redup jika sudah dipilih
                title: Text(
                  exercise.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white38 : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                trailing: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    // Icon berubah jadi check jika sudah dipilih
                    icon: Icon(
                      isSelected ? Icons.check : Icons.add,
                      color: isSelected
                          ? Colors.grey
                          : const Color(0xFF66BB6A),
                    ),

                    // Disable klik jika sudah dipilih
                    onPressed: isSelected
                        ? null
                        : () {
                            addExercise(exercise.name);
                          },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}