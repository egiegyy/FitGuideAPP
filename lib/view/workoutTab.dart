import 'package:fitguide/view/equipment.dart';
import 'package:fitguide/view/package.dart';
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
        backgroundColor: Colors.black,

        appBar: AppBar(
          backgroundColor: Colors.black,
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
            preferredSize: const Size.fromHeight(80),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

              /// CONTAINER WRAPPER
              child: Container(
                height: 50,

                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(500),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xff6C9E56), width: 2),
                ),

                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,

                  /// ACTIVE TAB BACKGROUND
                  indicator: BoxDecoration(
                    color: const Color(0xff6C9E56),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xff6C9E56),

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

        /// TAB CONTENT
        body: TabBarView(children: [Equipment(), Package()]),
      ),
    );
  }
}
