import 'dart:async';
import 'package:fitguide/database/preferance.dart';
import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/pages/profile/routine/routine.dart';
import 'package:fitguide/pages/profile/routine/routine_day.dart';
import 'package:fitguide/pages/workout/package/pull_workout.dart';
import 'package:fitguide/pages/workout/package/push_workout.dart';
import 'package:fitguide/pages/workout/workouts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  List<String> routineDays = [];
  final PageController _controller = PageController();
  int currentPage = 0;
  Timer? timer;
  final TextStyle pageTitle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  final TextStyle sectionTitle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  final TextStyle cardTitle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  final TextStyle bodyText = const TextStyle(
    fontSize: 14,
    color: Colors.white70,
  );
  final TextStyle buttonText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  Future<void> getUser() async {
    final user = await UserPref.getCurrentUser();
    if (!mounted) return;
    setState(() {
      username = user?["username"] ?? "User";
    });
  }

  void loadRoutine() async {
    final data = await DBHelper.getRoutineDays();
    if (!mounted) return;
    setState(() {
      routineDays = data;
    });
  }

  void startAutoSlide() {
    timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (currentPage < 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      if (_controller.hasClients) {
        _controller.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    loadRoutine();
    startAutoSlide();
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> openRoutineDay(String day) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoutineDayPage(day: day)),
    );
    loadRoutine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black.withValues(alpha: 0.6),
        elevation: 0,
        centerTitle: true,
        title: Text("Home", style: pageTitle),
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
                /// GREETING
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo $username,",
                      style: TextStyle(
                        color: Color(0xFF66BB6A),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text("Let's be better 1% everyday!", style: bodyText),
                  ],
                ),
                const SizedBox(height: 30),

                /// BANNER
                SizedBox(
                  height: 200,
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          "assets/images/banners/body_builder.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          "assets/images/banners/trail_run.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                /// DOT INDICATOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: currentPage == index ? 20 : 8,
                      decoration: BoxDecoration(
                        gradient: currentPage == index
                            ? const LinearGradient(
                                colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                              )
                            : null,
                        color: currentPage == index ? null : Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                /// ROUTINE
                Text("Your Routine", style: sectionTitle),
                const SizedBox(height: 10),
                routineDays.isEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "There is no Routine",
                              style: bodyText.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2E7D32),
                                    Color(0xFF66BB6A),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyRoutine(),
                                    ),
                                  );
                                  loadRoutine();
                                },
                                child: Text("Add Routine", style: buttonText),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: routineDays.map((day) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Container(
                                width: 150,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Column(
                                  children: [
                                    Text(day, style: cardTitle),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () {
                                          openRoutineDay(day);
                                        },
                                        child: const Text(
                                          "More",
                                          style: TextStyle(
                                            color: Color(0xFF66BB6A),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                const SizedBox(height: 25),

                /// PACKAGE
                Text("Package Exercise", style: sectionTitle),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    children: [
                      _packageTile(
                        context,
                        "Push Work out",
                        "assets/images/exercises/push/profile_push.png",
                        const PushWorkout(),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 1,
                        color: Colors.white24,
                      ),
                      _packageTile(
                        context,
                        "Pull Workout",
                        "assets/images/exercises/pull/profile_pull.png",
                        const PullWorkout(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WorkoutPage(),
                          ),
                        );
                      },
                      child: Text("See More", style: buttonText),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _packageTile(
    BuildContext context,
    String title,
    String imagePath,
    Widget page,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 55,
          height: 55,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      title: Text(title, style: cardTitle),
      subtitle: Text(
        "Push Pull Leg is a workout split that groups exercises based on movement patterns.",
        style: bodyText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: const Text(
          "More",
          style: TextStyle(
            color: Color(0xFF66BB6A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

