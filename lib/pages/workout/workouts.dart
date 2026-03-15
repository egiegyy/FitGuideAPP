import 'package:fitguide/pages/workout/machine/equipment.dart';
import 'package:fitguide/pages/workout/package/package.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          /// FIX garis putih
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,

          centerTitle: true,

          title: const Text(
            "Workout",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(90),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              child: Container(
                height: 50,

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24),
                ),

                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,

                  /// padding tombol aktif
                  indicatorPadding: const EdgeInsets.all(6),

                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,

                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),

                  tabs: const [
                    Tab(text: "Equipment"),
                    Tab(text: "Package"),
                  ],
                ),
              ),
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

          child: const TabBarView(children: [Equipment(), Package()]),
        ),
      ),
    );
  }
}
