import 'package:fitguide/pages/workout/package/fullbody_workout.dart';
import 'package:fitguide/pages/workout/package/leg_workout.dart';
import 'package:fitguide/pages/workout/package/pull_workout.dart';
import 'package:fitguide/pages/workout/package/push_workout.dart';
import 'package:flutter/material.dart';

class Package extends StatelessWidget {
  const Package({super.key});

  static const List<({
    String title,
    String imagePath,
    Widget page,
  })> _packageCategories = [
    (
      title: "Push",
      imagePath: "assets/images/exercises/push/profile_push.png",
      page: PushWorkout(),
    ),
    (
      title: "Pull",
      imagePath: "assets/images/exercises/pull/profile_pull.png",
      page: PullWorkout(),
    ),
    (
      title: "Leg",
      imagePath: "assets/images/exercises/leg/profile_leg.png",
      page: LegWorkout(),
    ),
    (
      title: "Full Body",
      imagePath: "assets/images/contoh_fullBody.png",
      page: FullBodyWorkout(),
    ),
  ];

  Widget buildPackageCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required Widget page,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: 40,
            height: 40,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "More",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              ..._packageCategories.map(
                (item) => buildPackageCard(
                  context: context,
                  title: item.title,
                  imagePath: item.imagePath,
                  page: item.page,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
