import 'package:fitguide/model/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // ✅ FIX: dari transparent → solid
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Workout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE
                Container(
                  width: double.infinity,
                  height: 260,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      exercise.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// TITLE
                Text(
                  exercise.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                /// INFO
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      _InfoRow(label: "Equipment", value: exercise.equipment),
                      const SizedBox(height: 10),
                      _InfoRow(label: "Category", value: exercise.category),
                      const SizedBox(height: 10),
                      _InfoRow(label: "Level", value: exercise.level),
                      const SizedBox(height: 10),
                      _InfoRow(label: "Repetitions", value: exercise.reps),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                /// DESCRIPTION
                const Text(
                  "Description",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    exercise.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                /// HOW TO USE
                const Text(
                  "How to Use",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: exercise.steps.map(_StepText.new).toList(),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepText extends StatelessWidget {
  final String text;

  const _StepText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}