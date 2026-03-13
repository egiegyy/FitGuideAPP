import 'package:flutter/material.dart';
import 'package:fitguide/controller/progress_controller.dart';
import 'package:fitguide/model/progress_model.dart';
import 'package:fitguide/view/progress_chart.dart';

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

  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFD9D9D9),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black54),
      prefixIcon: Icon(icon, color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }

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

  Widget buildInputForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: exerciseController,
            style: const TextStyle(color: Colors.black),
            decoration: inputDecoration(
              hint: "Exercise",
              icon: Icons.fitness_center,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: weightController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: inputDecoration(hint: "Weight (kg)", icon: Icons.scale),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: repsController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: inputDecoration(hint: "Reps", icon: Icons.repeat),
          ),
          const SizedBox(height: 12),

          /// DATE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate.toString().split(" ")[0],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.blue),
                  onPressed: pickDate,
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          /// SAVE BUTTON
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6C9E56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: saveProgress,
              child: const Text(
                "Save Workout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProgressList(List<ProgressModel> data) {
    Map<String, List<ProgressModel>> grouped = {};

    for (var item in data) {
      grouped.putIfAbsent(item.date, () => []);
      grouped[item.date]!.add(item);
    }

    return Column(
      children: grouped.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              ...entry.value.map((e) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    e.exercise,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${e.weight} kg • ${e.reps} reps",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xff6C9E56)),
                        onPressed: () async {
                          await showEditDialog(e);
                        },
                      ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Workout Progress",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: FutureBuilder<List<ProgressModel>>(
          future: ProgressController.getAllProgress(),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data ?? [];

            return ListView(
              children: [
                buildInputForm(),
                const SizedBox(height: 20),

                if (data.isNotEmpty) ProgressChart(data: data),

                const SizedBox(height: 20),

                buildProgressList(data),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> showEditDialog(ProgressModel item) async {
    final exerciseEdit = TextEditingController(text: item.exercise);
    final weightEdit = TextEditingController(text: item.weight);
    final repsEdit = TextEditingController(text: item.reps);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Edit Workout",
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: exerciseEdit,
                decoration: inputDecoration(
                  hint: "Exercise",
                  icon: Icons.fitness_center,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: weightEdit,
                decoration: inputDecoration(hint: "Weight", icon: Icons.scale),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: repsEdit,
                decoration: inputDecoration(hint: "Reps", icon: Icons.repeat),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white70),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6C9E56),
              ),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
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
