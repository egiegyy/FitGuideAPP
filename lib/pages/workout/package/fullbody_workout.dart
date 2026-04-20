import 'package:fitguide/pages/workout/exercise_detail_page.dart';
import 'package:fitguide/utils/exercise_data.dart';
import 'package:flutter/material.dart';

class FullBodyWorkout extends StatefulWidget {
  const FullBodyWorkout({super.key});

  @override
  State<FullBodyWorkout> createState() => _FullBodyWorkoutState();
}

class _FullBodyWorkoutState extends State<FullBodyWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Package",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                /// HEADER IMAGE
                Container(
                  alignment: Alignment.topLeft,
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      "assets/images/contoh_fullBody.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                /// TITLE
                const Text(
                  "Full Body Workout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),

                const SizedBox(height: 4),

                /// CREATOR
                const Text(
                  "Created by FitGuide",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 10),

                const Divider(color: Colors.white24),

                /// CHEST PRESS
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),

                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/exercises/push/chest_press.png",
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    title: const Text(
                      "Chest Press",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExerciseDetailPage(
                              exercise: ExerciseData.chestPress,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          child: Text(
                            "More",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// WIDE GRIP LAT PULLDOWN
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),

                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/exercises/pull/lat_pulldown.png",
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    title: const Text(
                      "Lat Pulldown",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExerciseDetailPage(
                              exercise: ExerciseData.wideGripLatPulldown,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          child: Text(
                            "More",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// LEG PRESS
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),

                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/exercises/leg/leg_press.png",
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    title: const Text(
                      "Leg Press",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExerciseDetailPage(
                              exercise: ExerciseData.legPress,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          child: Text(
                            "More",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                const Divider(color: Colors.white24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
