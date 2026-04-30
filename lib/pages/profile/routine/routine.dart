import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/localization/app_language.dart';
import 'package:fitguide/pages/profile/routine/add_exercise.dart';
import 'package:flutter/material.dart';
import 'routine_day.dart';

class MyRoutine extends StatefulWidget {
  const MyRoutine({super.key});

  @override
  State<MyRoutine> createState() => _MyRoutineState();
}

class _MyRoutineState extends State<MyRoutine> {
  List<String> days = [];

  static const List<String> _orderedDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  void initState() {
    super.initState();
    loadDays();
  }

  Future loadDays() async {
    final data = await DBHelper.getRoutineDays();
    data.sort((a, b) {
      final aIndex = _orderedDays.indexOf(a);
      final bIndex = _orderedDays.indexOf(b);
      return aIndex.compareTo(bIndex);
    });

    if (!mounted) return;
    setState(() {
      days = data;
    });
  }

  Future chooseDay() async {
    List<String> availableDays = _orderedDays
        .where((d) => !days.contains(d))
        .toList();

    if (availableDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr("All days already have routine"))),
      );
      return;
    }

    final day = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B5E20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            context.tr("Select Day"),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: availableDays.map((d) {
              return ListTile(
                title: Text(
                  context.tr(d),
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context, d);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (!mounted) return;
    if (day != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddExercisePage(day: day)),
      );

      if (!mounted) return;
      loadDays();
    }
  }

  Future openDay(String day) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RoutineDayPage(day: day)),
    );

    if (!mounted) return;
    loadDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.tr("Routine"),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
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
          child: days.isEmpty
              ? Center(
                  child: Text(
                    context.tr("There is no Routine"),
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 88),
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final day = days[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          openDay(day);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(13),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.tr(day),
                                style: const TextStyle(
                                  color: Color(0xFF66BB6A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white70,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: _buildAddFab(onTap: chooseDay),
    );
  }

  Widget _buildAddFab({required VoidCallback onTap}) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: FloatingActionButton(
        heroTag: 'add-routine-day',
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: onTap,
        child: const Icon(Icons.add_rounded, size: 30),
      ),
    );
  }
}
