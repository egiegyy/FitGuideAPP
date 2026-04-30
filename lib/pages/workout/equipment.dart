import 'package:fitguide/localization/app_language.dart';
import 'package:fitguide/pages/workout/machine/chest_press_machine.dart';
import 'package:fitguide/pages/workout/machine/lat_pulldown_machine.dart';
import 'package:fitguide/pages/workout/machine/leg_press_machine.dart';
import 'package:flutter/material.dart';

class Equipment extends StatefulWidget {
  const Equipment({super.key});

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  final List<String> kategoriLatihan = [
    "Chest Press",
    "Lat Pulldown",
    "Leg Press",
  ];

  final List<Widget> equipmentPages = const [
    ChestPressMachine(),
    LatPulldownMachine(),
    LegPressMachine(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: ListView.builder(
        itemCount: kategoriLatihan.length,
        physics: const BouncingScrollPhysics(),

        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              height: 95,

              decoration: BoxDecoration(
                color: Colors.white.withAlpha(13),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white24),
              ),

              child: ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => equipmentPages[index],
                    ),
                  );
                },

                leading: Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),

                  child: const Icon(
                    Icons.fitness_center,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                title: Text(
                  context.tr(kategoriLatihan[index]),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF66BB6A),
                  size: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
