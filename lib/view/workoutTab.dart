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
            preferredSize: const Size.fromHeight(70),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: TabBar(
                indicatorColor: Color(0xff6C9E56),
                labelPadding: EdgeInsets.all(10),
                
                tabs: [
                  /// EQUIPMENT TAB
                  Tab(
                    child: Container(
                      height: 45,

                      decoration: BoxDecoration(
                        // color: const Color(0xff6C9E56),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Center(
                        child: Text(
                          "Equipment",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// PACKAGE TAB
                  Tab(
                    child: Container(
                      height: 45,

                      decoration: BoxDecoration(
                        // color: const Color(0xff6C9E56),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Center(
                        child: Text(
                          "Package",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// TAB CONTENT
        body: TabBarView(
          children: [
            /// EQUIPMENT PAGE
            Equipment(),

            /// PACKAGE PAGE
            Package(),
          ],
        ),
      ),
    );
  }
}
