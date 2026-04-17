import 'package:fitguide/pages/profile/progress/progress_chart.dart';
import 'package:flutter/material.dart';
import 'package:fitguide/controller/progress_controller.dart';
import 'package:fitguide/firebase/model/progress_model.dart';

enum ChartRange { week, month, year }

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
  ChartRange selectedRange = ChartRange.week;
  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withAlpha(20),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Container(
        margin: const EdgeInsets.only(left: 10, right: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFF66BB6A)),
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

  List<ProgressModel> filterData(List<ProgressModel> data) {
    DateTime now = DateTime.now();
    DateTime startDate;
    switch (selectedRange) {
      case ChartRange.week:
        startDate = now.subtract(const Duration(days: 7));
        break;
      case ChartRange.month:
        startDate = now.subtract(const Duration(days: 30));
        break;
      case ChartRange.year:
        startDate = now.subtract(const Duration(days: 365));
        break;
    }
    return data.where((item) {
      DateTime itemDate = DateTime.parse(item.date);
      return itemDate.isAfter(startDate);
    }).toList();
  }

  Widget rangeButton(String text, ChartRange range) {
    bool active = selectedRange == range;
    return ElevatedButton(
      style:
          ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ).copyWith(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
      onPressed: () {
        setState(() {
          selectedRange = range;
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: active
              ? const LinearGradient(
                  colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                )
              : null,
          color: active ? null : Colors.white.withAlpha(30),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: active ? Colors.white : Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRangeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        rangeButton("7D", ChartRange.week),
        const SizedBox(width: 10),
        rangeButton("1M", ChartRange.month),
        const SizedBox(width: 10),
        rangeButton("1Y", ChartRange.year),
      ],
    );
  }

  Widget buildInputForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: exerciseController,
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration(
              hint: "Exercise",
              icon: Icons.fitness_center,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: weightController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration(hint: "Weight (kg)", icon: Icons.scale),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: repsController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration(hint: "Reps", icon: Icons.repeat),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate.toString().split(" ")[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      color: Color(0xFF66BB6A),
                    ),
                    onPressed: pickDate,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  shadowColor: Colors.transparent,
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
            color: Colors.white.withAlpha(13),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  color: Color(0xFF66BB6A),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.white24),
              ...entry.value.map((e) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    e.exercise,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${e.weight} kg • ${e.reps} reps",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xFF66BB6A),
                          ),
                          onPressed: () async {
                            await showEditDialog(e);
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await ProgressController.deleteProgress(e.id!);
                            setState(() {});
                          },
                        ),
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
  void dispose() {
    exerciseController.dispose();
    weightController.dispose();
    repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<List<ProgressModel>>(
              future: ProgressController.getAllProgress(),
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return ListView(
                  children: [
                    const Center(
                      child: Text(
                        "Workout Progress",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildInputForm(),
                    const SizedBox(height: 20),
                    if (data.isNotEmpty) ...[
                      buildRangeSelector(),
                      const SizedBox(height: 10),
                      ProgressChart(data: filterData(data)),
                    ],
                    const SizedBox(height: 20),
                    buildProgressList(data),
                  ],
                );
              },
            ),
          ),
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
          backgroundColor: const Color(0xFF1B5E20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            "Edit Workout",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: exerciseEdit,
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration(
                  hint: "Exercise",
                  icon: Icons.fitness_center,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: weightEdit,
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration(hint: "Weight", icon: Icons.scale),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: repsEdit,
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration(hint: "Reps", icon: Icons.repeat),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.greenAccent),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
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
