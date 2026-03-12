import 'package:flutter/material.dart';
import 'package:fitguide/controller/progress_controller.dart';
import 'package:fitguide/model/progress_model.dart';
import 'package:fitguide/utils/decoration.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final exerciseController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  /// DATE PICKER
  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      initialDate: selectedDate,
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  /// SAVE WORKOUT
  Future<void> saveProgress() async {
    if (exerciseController.text.isEmpty ||
        weightController.text.isEmpty ||
        repsController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }
    final progress = ProgressModel(
      exercise: exerciseController.text,
      weight: weightController.text,
      reps: repsController.text,
      date: selectedDate.toString().split(" ")[0],
    );
    await ProgressController.insertProgress(progress);
    exerciseController.clear();
    weightController.clear();
    repsController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    exerciseController.dispose();
    weightController.dispose();
    repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Workout Progress",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// INPUT FORM
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  /// EXERCISE
                  TextFormField(
                    controller: exerciseController,
                    style: const TextStyle(color: Colors.white),
                    decoration: decorationConstant(
                      hintText: "Enter exercise name",
                      labelText: "Exercise",
                      prefixIcon: Icons.fitness_center,
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// WEIGHT
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: decorationConstant(
                      hintText: "Enter weight",
                      labelText: "Weight (kg)",
                      prefixIcon: Icons.scale,
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// REPS
                  TextFormField(
                    controller: repsController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: decorationConstant(
                      hintText: "Enter reps",
                      labelText: "Reps",
                      prefixIcon: Icons.repeat,
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// DATE
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Date: ${selectedDate.toString().split(" ")[0]}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        onPressed: pickDate,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: saveProgress,
                      child: const Text(
                        "Save Workout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// WORKOUT HISTORY
            Expanded(child: buildProgressList()),
          ],
        ),
      ),
    );
  }

  /// WORKOUT LIST
  Widget buildProgressList() {
    return FutureBuilder<List<ProgressModel>>(
      future: ProgressController.getAllProgress(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "No workout history",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        final data = snapshot.data!;

        /// GROUP BY DATE
        Map<String, List<ProgressModel>> grouped = {};
        for (var item in data) {
          grouped.putIfAbsent(item.date, () => []);
          grouped[item.date]!.add(item);
        }
        return ListView(
          children: grouped.entries.map((entry) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// DATE HEADER
                  Text(
                    entry.key,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),

                  /// EXERCISE LIST
                  ...entry.value.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              e.exercise,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${e.weight}kg",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${e.reps} reps",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),

                          /// EDIT
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () async {
                              await showEditDialog(e);
                            },
                          ),

                          /// DELETE
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await ProgressController.deleteProgress(e.id!);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  /// EDIT WORKOUT
  Future<void> showEditDialog(ProgressModel item) async {
    final exerciseEdit = TextEditingController(text: item.exercise);
    final weightEdit = TextEditingController(text: item.weight);
    final repsEdit = TextEditingController(text: item.reps);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Workout"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: exerciseEdit,
                decoration: decorationConstant(
                  hintText: "Exercise",
                  labelText: "Exercise",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: weightEdit,
                decoration: decorationConstant(
                  hintText: "Weight",
                  labelText: "Weight",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: repsEdit,
                decoration: decorationConstant(
                  hintText: "Reps",
                  labelText: "Reps",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Save"),
              onPressed: () async {
                await ProgressController.updateProgress(
                  ProgressModel(
                    id: item.id,
                    exercise: exerciseEdit.text,
                    weight: weightEdit.text,
                    reps: repsEdit.text,
                    date: item.date,
                  ),
                );
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
